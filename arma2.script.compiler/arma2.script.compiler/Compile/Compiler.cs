using System;
using System.Collections.Generic;
using System.IO;
using System.Linq;
using System.Text.RegularExpressions;
using ArmA2.Script.Compile.Exceptions;
using ArmA2.Script.ScriptProcessor;

namespace ArmA2.Script.Compile
{
    public class Compiler
    {
        #region Поля класса

        private readonly char[] _allowedVarChars = "abcdefghijklmnopqrstuvwxyz".ToCharArray();
        private readonly Stack<CompileSettings> _settingsStack = new Stack<CompileSettings>();
        private int _count;

        #endregion

        #region Свойства класса

        public CompileContext Context { get; set; }

        public CompileSettings Settings { get; set; }

        #endregion

        #region Конструкторы класса

        public Compiler()
        {
            Settings = new CompileSettings();
            Context = new CompileContext();
        }

        #endregion

        #region Методы класса

        public void CompileFile(string fileName)
        {
            try
            {
                PushSettings();
                string content = File.ReadAllText(fileName);

                Settings.FileName = fileName;
                Settings.IsTopFile = false;
                Settings.FsmContent = (Path.GetExtension(fileName).ToLower() == ".fsm");

                content = Compile(content);
                File.WriteAllText(fileName, content);
                PopSettings();
            }
            catch (Exception e)
            {
                Console.WriteLine(e.ToString());
            }
        }

        internal void ResetinternalUsage()
        {
            Context.PublicVariables.ForEach(m =>
            {
                m.Regex = new Regex("\\b" + Regex.Escape(m.VarName) + "\\b",
                                    RegexOptions.IgnoreCase);
                m.UsageCount = 0;
            });
        }

        internal void AddPrivateVariablesUsageStat(string fileName)
        {
            string content = File.ReadAllText(fileName);
            Context.PublicVariables.ForEach(m => m.UsageCount += m.Regex.Matches(content).Count);
        }

        internal List<Variable> GetPrivateVarsOrderByUsage()
        {
            return Context.PublicVariables.OrderByDescending(m => m.UsageCount).ToList();
        }

        public string Compile(string content)
        {
            if (Settings.IsTopFile)
            {
                Console.WriteLine("---------------------------------------------");
                Console.WriteLine("Compile: {0}", Settings.FileName);
            }

            content = CompilePartial(content, null);

            if (Settings.IsTopFile)
            {
                Console.WriteLine();
            }
            return content;
        }

        internal int GetEndMultiComment(string content, int startPos)
        {
            for (int i = startPos + 2; i < content.Length; i++)
            {
                if (content.Equal("/*", i)) // skip internal comments
                {
                    int end = GetEndMultiComment(content, i + 2);
                    i = (end != -1) ? end : content.Length;
                    continue;
                }
                if (content.Equal("*/", i)) // found end
                {
                    return (i + 1);
                }
            }

            Logger.Log(LogLevel.Error, "Multiline comment is not completed: {0}", content.Substring(startPos));
            return -1;
        }

        internal string DeleteComments(string content)
        {
            string contentNew = string.Empty;
            int lineStart = -1;
            for (int i = 0; i < content.Length; i++)
            {
                if (lineStart == -1)
                {
                    lineStart = i;
                }

                if (content.Equal("/*", i)) // skip all comments
                {
                    if (i - lineStart > 0)
                    {
                        contentNew = contentNew + content.Substring(lineStart, i - lineStart);
                    }

                    int end = GetEndMultiComment(content, i);
                    i = (end != -1) ? end : content.Length;

                    lineStart = -1;
                    continue;
                }
                if (content.Equal("//", i)) // skip single line comments
                {
                    if (i - lineStart > 0)
                    {
                        contentNew = contentNew + content.Substring(lineStart, i - lineStart);
                    }
                    i = content.IndexOf("\n", i);
                    if (i == -1)
                    {
                        i = content.Length;
                    }
                    lineStart = -1;
                    continue;
                }

                if (content.IsStartString(i)) // пропускаем строковые переменные
                {
                    int end = content.GetEndQuote(i);
                    i = (end != -1) ? end : content.Length;
                    continue;
                }
            }

            if (lineStart != -1 && content.Length - lineStart > 0)
            {
                contentNew = contentNew + content.Substring(lineStart, content.Length - lineStart);
            }

            return contentNew;
        }

        private string CleanupContent(string content)
        {
            try
            {
                return CleanupContentInternal(content);
            }
            catch (CompileException e)
            {
                if (e.Throwable)
                {
                    throw;
                }

                e.WriteToLog();
            }
            return content;
        }

        private string CleanupContentInternal(string content)
        {
            content = content.Replace("\t", " ");
            content = content.Replace("\r\n", "\n");
            content = content.Replace("\r", "\n");

            //content = RemoveMultiLineComments(content);

            if (Settings.FsmContent)
            {
                content = content.Replace("\"\"\">*/", "*/"); // """>*/  to */
            }

            content = DeleteComments(content);

            string[] lines = content.Split(new[] {"\n"}, StringSplitOptions.RemoveEmptyEntries);
            IEnumerable<string> content1 = lines.Select(m => m);

            content1 = content1.Where(m => m.Trim().Length > 0).Select(m => m.Trim());
            if (!Settings.FsmContent)
            {
                content1 = content1.Where(m => !Context.ExcludeLines.Any(n => new Regex(n).IsMatch(m)));
            }

            string contentText = "";
            content1.ForEach(m => contentText = contentText + m + "\n");

            contentText = RemoveStringBreaks(contentText);
            contentText = RemoveExtraSpaces(contentText);

            if (Settings.FsmContent)
            {
                contentText = ProcessFSM(contentText);
            }

            if (!Settings.FsmContent)
            {
                contentText = RemoveLineBreaks(contentText.Split(new[] {"\n"}, StringSplitOptions.RemoveEmptyEntries));
                contentText = RemoveExtraSpaces(contentText);
                contentText = ContentCleanup(contentText);
                contentText = RemoveExtraSpaces(contentText);
            }

            string[] commands = contentText.Split(new[] {"\n"}, StringSplitOptions.RemoveEmptyEntries);
            contentText = RemoveLineBreaks(commands);
            contentText = contentText.Replace(";;", ";");
            return contentText.Trim();
        }

        internal string CompilePartial(string content, CmdScopeBase rootScope)
        {
            content = CleanupContent(content);
            if (!Settings.FsmContent)
            {
                var p = new Processor(this);
                CmdGroup byteCode = p.CompileToByteCode(content, rootScope);

                byteCode.CompileSafe(this);
                content = byteCode.GetScript(Settings.ScriptMinimized);
            }
            return content.Replace("\r\n", "\n").Replace("\n\n", "\n").Trim();
        }

        private string RemoveLineBreaks(IEnumerable<string> content1)
        {
            string contentText = "";
            bool nextLineReturn = false;
            content1.ForEach(m =>
            {
                string line = m.Trim();
                if (line.StartsWith("#") && line.Length > 0)
                {
                    contentText = contentText + "\n";
                }

                contentText = contentText + line;

                if (nextLineReturn || line.StartsWith("#"))
                {
                    contentText = contentText + "\n";
                }

                nextLineReturn = (line.StartsWith("#define") || nextLineReturn) &&
                                 line.EndsWith("\\");
            });
            return contentText;
        }

        private string ContentCleanup(string contentText)
        {
            contentText = RemoveEmptyLines(contentText);
            string text = contentText;
            Context.ExcludePhrases.ForEach(m =>
            {
                var regex = new Regex(m);
                text = regex.Replace(text, "");
            });
            contentText = RemoveEmptyLines(text);
            return contentText;
        }

        private string RemoveEmptyLines(string contentText)
        {
            while (true)
            {
                int L1 = contentText.Length;
                contentText = contentText.Replace("\n\n", "\n");
                if (L1 == contentText.Length)
                {
                    break;
                }
            }
            return contentText;
        }

        private string ProcessFSM(string content)
        {
            var ignoredNames = new[] {"fsmname", "from", "to", "name", "priority", "initstate"};

            var p = new Processor(this);
            p.Functions.Clear();
            p.Functions.Add(new Function {Name = "class"});

            CmdGroup code = p.CompileToByteCode(content);
            var rootScope = new FsmClass((CmdScopeBase) code);

            FsmClass fsmClass = rootScope.ClassList["FSM"];
            if (fsmClass == null)
            {
                throw new CompileException(CompileCode.FsmMissedClass, "root Class FSM not found");
            }

            FsmClass statesClass = fsmClass.ClassList["States"];
            if (statesClass == null)
            {
                throw new CompileException(CompileCode.FsmMissedClass, "statesClass Class not found");
            }

            fsmClass.States = statesClass;

            FsmProperty propInit = fsmClass.PropertyList["InitState"];
            if (propInit == null)
            {
                throw new CompileException(CompileCode.FsmMissedProperty, "InitState property not found");
            }

            var initClassName = propInit.GetValue<CmdString>();
            if (initClassName == null)
            {
                throw new CompileException(CompileCode.FsmInvalidValueType,
                                           "InitState invalid value type must be string");
            }

            FsmClass initClass = fsmClass.States.ClassList[initClassName.Text];
            if (initClass == null)
            {
                throw new CompileException(CompileCode.FsmMissedClass, "class '{0}' not found", initClassName.Text);
            }

            IEnumerable<CmdBase> assignList =
                code.FlatData.Where(m => m is CmdOperator && ((CmdOperator) m).Text.Equal("="));

            PushSettings();

            Settings.UpdatePrivateVars = true;
            Settings.FsmContent = false;

            var scopeRoot = new CmdScopeCodeRoot(new Processor(this));
            initClass.Compile(this, scopeRoot, "** ");

            content = code.GetScript(Settings.ScriptMinimized);

            PopSettings();
            return content;
        }

        internal void PushSettings()
        {
            _settingsStack.Push(Settings);
            Settings = Settings.Clone();
        }

        internal void PopSettings()
        {
            Settings = _settingsStack.Pop();
        }

        internal int GetNextStringStart(string line, int startPos)
        {
            for (int i = startPos; i < line.Length; i++)
            {
                char ch = line[i];
                if (ch == '"' || ch == '\'')
                {
                    return i;
                }
            }
            return -1;
        }

        internal string GetNextString(string line, int startPos)
        {
            int strA = GetNextStringStart(line, startPos);
            if (strA == -1)
            {
                return null;
            }

            int strB = line.GetEndQuote(strA);
            if (strB == -1)
            {
                return null;
            }

            return line.Substring(strA, strB - strA + 1);
        }

        internal string RemoveExtraSpaces(string line)
        {
            line = line.Trim();
            int l0 = line.Length;

            int startPos = 0;
            while (startPos < line.Length)
            {
                int next = GetNextStringStart(line, startPos);
                if (next != -1)
                {
                    if (next > 0)
                    {
                        line = RemoveExtraSpaces(line, startPos, next);
                        next = GetNextStringStart(line, startPos);
                    }
                    int endStr = line.GetEndQuote(next);
                    startPos = (endStr != -1) ? endStr + 1 : line.Length;
                }
                else
                {
                    break;
                }
            }
            line = RemoveExtraSpaces(line, startPos, line.Length);

            if (l0 != line.Length)
            {
                line = RemoveExtraSpaces(line);
            }

            return line.Trim();
        }

        internal string RemoveExtraSpaces(string line, int startPos, int endPos)
        {
            var removed = new[]
            {
                ">", "<", ">=", "<=", "!=", "==", "=", ",", ";", ":", "!", "(", ")",
                "{", "}", "[", "]", "+", "-", "*", "/", "&&", "||", "|", "&", "\\n"
            };

            string strA = (startPos > 0) ? line.Substring(0, startPos) : string.Empty;
            string strB = line.Substring(endPos);

            string data = string.Empty;
            if (startPos != endPos)
            {
                data = line.Substring(startPos, endPos - startPos);
                int length = data.Length;
                int newlength = 0;
                while (length != newlength)
                {
                    length = data.Length;
                    data = data.Replace("  ", " ");
                    removed.ForEach(m => data = data.Replace(" " + m, m).Replace(" " + m + " ", m).Replace(m + " ", m));

                    if (!Settings.FsmContent)
                    {
                        data = data.Replace(";}", "}");
                    }
                    newlength = data.Length;
                }
            }
            return strA + data + strB;
        }

        internal string RemoveStringBreaks(string line)
        {
            line = line.Trim();
            int startPos = 0;

            while (startPos != -1)
            {
                int str1start = GetNextStringStart(line, startPos);
                startPos = str1start;
                int str1end = (str1start != -1) ? line.GetEndQuote(str1start) : -1;

                while (str1end != -1)
                {
                    int str2start = GetNextStringStart(line, str1end + 1);
                    if (str2start == -1)
                    {
                        startPos = str1end + 1;
                        break;
                    }

                    string m = line.Substring(str1end + 1, str2start - str1end - 1).Trim();
                    if (m == @"\n")
                    {
                        line = line.Remove(str1end, str2start - str1end + 1);
                        if (Settings.FsmContent)
                        {
                            line = line.Insert(str1end, "\n");
                        }
                        str1end = line.GetEndQuote(str1start);
                    }
                    else
                    {
                        str1start = str2start;
                        str1end = (str1start != -1) ? line.GetEndQuote(str1start) : -1;
                    }
                }
            }
            return line.Trim();
        }

        private string GetVarName(int varId)
        {
            int max = _allowedVarChars.Count();

            string name = "";
            while (true)
            {
                int ch1 = varId / max;
                int ch = varId - ch1 * max;

                name = name + _allowedVarChars[ch];
                if (ch1 == 0)
                {
                    break;
                }
                varId = ch1;
            }
            return name;
        }

        internal string GetNextLocalName()
        {
            string varName = "_" + GetVarName(_count++).ToLower();

            if (Context.ReservedNameLocalVariable.Any(m => m == varName))
            {
                varName = GetNextLocalName();
            }

            return varName;
        }

        internal int GetUsageStat(string content, string varName)
        {
            var usage = new Regex("\\b" + varName + "\\b", RegexOptions.IgnoreCase);
            return usage.Matches(content).Count;
        }

        #endregion
    }
}