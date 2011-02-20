using System;
using System.Collections.Generic;
using System.IO;
using System.Linq;
using System.Text.RegularExpressions;
using ArmA2.Script.ScriptProcessor;

namespace ArmA2.Script
{
    public class Compiler
    {
        public bool FsmContent = false;
        public bool HideVars = false;

        public string FileName = string.Empty;
        public bool IsTopFile = true;
        public bool ApplyPrivateVars = true;

        public void CompileFile(string fileName)
        {
            string content = File.ReadAllText(fileName);
            FileName = fileName;
            IsTopFile = false;
            FsmContent = (Path.GetExtension(fileName).ToLower() == ".fsm");

            content = Compile(content);
            File.WriteAllText(fileName, content);
        }

        public static void ResetPublicUsage()
        {
            GlobalSettings.PublicVariables.ForEach(m =>
            {
                m.Regex = new Regex("\\b" + Regex.Escape(m.VarName) + "\\b", RegexOptions.IgnoreCase);
                m.UsageCount = 0;
            }
            );
        }

        public static void AddPublicVariablesUsageStat(string fileName)
        {
            string content = File.ReadAllText(fileName);
            GlobalSettings.PublicVariables.ForEach(m => m.UsageCount += m.Regex.Matches(content).Count);
        }
        public static List<Variable> GetPublicVarsOrderByUsage()
        {
            return GlobalSettings.PublicVariables.OrderByDescending(m => m.UsageCount).ToList();
        }
        public string Compile(string content)
        {
            if (IsTopFile)
            {
                Console.WriteLine("---------------------------------------------");
                Console.WriteLine("Compile: {0}", FileName);
            }

            content = CompilePartial(content);

            if (IsTopFile)
            {
                Console.WriteLine();
            }
            return content;
        }

        public int GetEndMultiComment(string content, int startPos)
        {
            for (int i = startPos+2; i < content.Length; i++)
            {
                if (content.Equal("/*", i))     // skip internal comments
                {
                    var end = GetEndMultiComment(content, i + 2);
                    i = (end != -1) ? end : content.Length;
                    continue;
                }
                if (content.Equal("*/", i))     // found end
                    return (i + 1);
            }

            Logger.Log(LogLevel.Error, "Multiline comment is not completed: {0}", content.Substring(startPos));
            return -1;
        }

        public string DeleteComments(string content)
        {
            string contentNew = string.Empty;
            int lineStart = -1;
            for (int i = 0; i < content.Length; i++)
            {
                if (lineStart == -1)
                    lineStart = i;

                if (content.Equal("/*", i)) // skip all comments
                {
                    if (i - lineStart > 0)
                        contentNew = contentNew + content.Substring(lineStart, i - lineStart);

                    var end = GetEndMultiComment(content, i);
                    i = (end != -1) ? end : content.Length;

                    lineStart = -1;
                    continue;
                }
                if (content.Equal("//", i)) // skip single line comments
                {
                    if (i - lineStart > 0)
                        contentNew = contentNew + content.Substring(lineStart, i - lineStart);
                    i = content.IndexOf("\n", i);
                    if (i == -1)
                        i = content.Length;
                    lineStart = -1;
                    continue;
                }

                if (content.IsStartString(i))   // пропускаем строковые переменные
                {
                    var end = content.GetEndQuote(i);
                    i = (end != -1) ? end : content.Length;
                    continue;
                }
            }

            if (lineStart != -1 && content.Length - lineStart > 0)
                contentNew = contentNew + content.Substring(lineStart, content.Length - lineStart);

            return contentNew;
        }


        public string CleanupContent(string content)
        {
            content = content.Replace("\t", " ");
            content = content.Replace("\r\n", "\n");
            content = content.Replace("\r", "\n");

            //content = RemoveMultiLineComments(content);

            if (FsmContent)
                content = content.Replace("\"\"\">*/", "*/");     // """>*/  to */

            content = DeleteComments(content);

            string[] lines = content.Split(new[] { "\n" }, StringSplitOptions.RemoveEmptyEntries);
            var content1 = lines.Select(m => m);


            content1 = content1.Where(m => m.Trim().Length > 0).Select(m => m.Trim());
            if (!FsmContent)
            {
                content1 = content1.Where(m => !GlobalSettings.ExcludeLines.Any(n => new Regex(n).IsMatch(m)));
            }

            string contentText = "";
            content1.ForEach(m => contentText = contentText + m + "\n");



            contentText = RemoveStringBreaks(contentText);
            contentText = RemoveExtraSpaces(contentText);

            if (FsmContent)
            {
                contentText = ProcessFSM(contentText);
            }

            if (!FsmContent)
            {
                contentText = RemoveLineBreaks(contentText.Split(new[] { "\n" }, StringSplitOptions.RemoveEmptyEntries));
                contentText = RemoveExtraSpaces(contentText);
                contentText = ContentCleanup(contentText);
                contentText = RemoveExtraSpaces(contentText);
            }


            var commands = contentText.Split(new[] {"\n"}, StringSplitOptions.RemoveEmptyEntries);
            contentText = RemoveLineBreaks(commands);
            contentText = contentText.Replace(";;", ";");
            return contentText.Trim();
        }

        public string CompilePartial(string content)
        {
            content = CleanupContent(content);
            if (!FsmContent)
            {
                content = PreprocessByteCode(content);
            }
            return content.Replace("\r\n", "\n").Replace("\n\n", "\n").Trim();
        }

        public string PreprocessByteCode(string content)
        {
            Processor p = new Processor();
            var byteCode = p.CompileToByteCode(content);

            byteCode.CompileSafe(this);
            return byteCode.ToString();
        }

        public delegate string HandleCommand(string commandText);

        private string RemoveLineBreaks(IEnumerable<string> content1)
        {
            string contentText = "";
            bool nextLineReturn = false;
            content1.ForEach(m =>
            {
                string line = m.Trim();
                if (line.StartsWith("#") && line.Length > 0)
                    contentText = contentText + "\n";

                contentText = contentText + line;

                if (nextLineReturn || line.StartsWith("#"))
                    contentText = contentText + "\n";

                nextLineReturn = (line.StartsWith("#define") || nextLineReturn) && line.EndsWith("\\");
            });
            return contentText;
        }

        private string ContentCleanup(string contentText)
        {
            contentText = RemoveEmptyLines(contentText);
            string text = contentText;
            GlobalSettings.ExcludePhrases.ForEach(m =>
            {
                Regex regex = new Regex(m);
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
                    break;
            }
            return contentText;
        }

        private string ProcessFSM(string content)
        {
            string[] ignoredNames = new[] { "fsmname", "from", "to", "name", "priority", "initstate" };

            Processor p = new Processor();
            var code = p.CompileToByteCode(content);

            var assignList = code.FlatData.Where(m => m is CmdOperator && ((CmdOperator) m).Text.Equal("="));

            var prevDeclareVars = ApplyPrivateVars;
            var prevFsmContent = FsmContent;

            ApplyPrivateVars = false;
            FsmContent = false;

            foreach(var assign in assignList)
            {
                var cmdId = assign.Parent.Items.IndexOf(assign);
                var name = assign.Parent.Items.Get<CmdText>(cmdId - 1);
                var value = assign.Parent.Items.Get<CmdString>(cmdId + 1);

                if (name == null || value == null)
                {
                    continue;
                }

                if (ignoredNames.Any(m => m.Equal(name.Text)))
                    continue;

                var valueContent = value.Text.Replace("\"\"", "\"");
                this.ApplyPrivateVars = false;
                valueContent = this.CompilePartial(valueContent);
                value.Text = valueContent.Replace("\"", "\"\"");
            }

            content = code.ToString().Trim();

            ApplyPrivateVars = prevDeclareVars;
            FsmContent = prevFsmContent;
            return content;
        }

        public List<Scope> GetScopes(string content, int start, int end)
        {
            List<Scope> scopes = new List<Scope>();
            while(start != -1 && start < content.Length)
            {
                var scope = GetScopeNext(content, start);
                if (scope == null || scope.Start > end)
                    break;

                scopes.Add(scope);
                start = scope.End + 1;
            }
            return scopes;
        }

         public Scope GetScopeNext(string content, int startPos)
         {
             Scope scope = null;
             int openScopes = 0;
             for (int i = startPos; i < content.Length; i++)
             {
                 if (content.IsStartString(i))   // пропускаем строки
                 {
                     var end = content.GetEndQuote(i);
                     i = (end != -1) ? end : content.Length;
                     continue;
                 }

                 if (content.Equal("{", i))
                 {
                     if (openScopes == 0)
                         scope = new Scope {Start = i, Text = content};
                     openScopes = openScopes + 1;
                 }
                 if (content.Equal("}", i) && openScopes > 0)
                 {
                     openScopes--;
                     if (openScopes == 0)
                     {
                         scope.End = i;
                         break;
                     }
                 }
             }

             if (scope != null && openScopes > 0)
             {
                 scope.End = content.Length-1;
                 Logger.Log(LogLevel.Error, "Unclosed scope: {0}", scope.ScopeText);
             }

             return scope;
         }

        public int GetNextStringStart(string line, int startPos)
        {
            for (int i = startPos; i < line.Length; i++)
            {
                var ch = line[i];
                if (ch == '"' || ch == '\'')
                    return i;
            }
            return -1;
        }


        public string GetNextString(string line, int startPos)
        {
            int strA = GetNextStringStart(line, startPos);
            if (strA == -1)
                return null;

            int strB = line.GetEndQuote(strA);
            if (strB == -1)
                return null;

            return line.Substring(strA, strB - strA + 1);
        }

        public string RemoveExtraSpaces(string line)
        {
            line = line.Trim();
            int l0 = line.Length;

            int startPos = 0;
            while (startPos < line.Length)
            {
                var next = GetNextStringStart(line, startPos);
                if (next != -1)
                {
                    if (next > 0)
                    {
                        line = RemoveExtraSpaces(line, startPos, next);
                        next = GetNextStringStart(line, startPos);
                    }
                    var endStr = line.GetEndQuote(next);
                    startPos = (endStr != -1) ? endStr+1 : line.Length;
                }
                else break;
            }
            line = RemoveExtraSpaces(line, startPos, line.Length);

            if (l0 != line.Length)
                line = RemoveExtraSpaces(line);

            return line.Trim();
        }

        public string RemoveExtraSpaces(string line, int startPos, int endPos)
        {
            var removed = new[] { ">", "<", ">=", "<=", "!=", "==", "=", ",", ";", ":", "!", "(", ")", 
                                  "{", "}", "[", "]", "+", "-", "*", "/","&&","||","|","&", "\\n"};

            var strA = (startPos > 0) ? line.Substring(0, startPos) : string.Empty;
            var strB = line.Substring(endPos);

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
                    removed.ForEach(m => data = data.Replace(" " + m, m).Replace(" " + m + " ", m).Replace(m + " ", m) );

                    if (!FsmContent)
                    {
                        data = data.Replace(";}", "}");
                    }
                    newlength = data.Length;
                }
            }
            return strA + data + strB;
        }
        public string RemoveStringBreaks(string line)
        {
            line = line.Trim();
            int startPos = 0;

            while (startPos != -1)
            {
                var str1start = GetNextStringStart(line, startPos);
                startPos = str1start;
                var str1end = (str1start != -1) ? line.GetEndQuote(str1start) : -1;

                while (str1end != -1)
                {
                    var str2start = GetNextStringStart(line, str1end+1);
                    if (str2start == -1)
                    {
                        startPos = str1end+1;
                        break;
                    }

                    var m = line.Substring(str1end+1, str2start - str1end - 1).Trim();
                    if (m == @"\n")
                    {
                        line = line.Remove(str1end, str2start - str1end + 1);
                        if (this.FsmContent)
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

        private int _count = 0;
        public static string[] ReservedLocalVarNames = { "_this", "_x", "_sv" };
        public static string[] ReservedGlobalVarNames = 
        { "image", "shadow", "color", "fps", "valign", "1", "isplayer" };
        private readonly char[] _allowedVarChars = "abcdefghijklmnopqrstuvwxyz".ToCharArray();

        private string GetVarName(int varId)
        {
            int max = _allowedVarChars.Count();

            string name = "";
            while (true)
            {
                int ch1 = varId/max;
                var ch = varId - ch1*max;

                name = name + _allowedVarChars[ch];
                if (ch1 == 0)
                    break;
                varId = ch1;
            }
            return name;
        }

        public string GetNextLocalName()
        {
            var varName = "_" + GetVarName(_count++).ToLower();

            if (ReservedLocalVarNames.Any(m => m == varName))
                varName = GetNextLocalName();

            return varName;
        }

        public int GetUsageStat(string content, string varName)
        {
            var usage = new Regex("\\b" + varName + "\\b", RegexOptions.IgnoreCase);
            return usage.Matches(content).Count;
        }
    }
}