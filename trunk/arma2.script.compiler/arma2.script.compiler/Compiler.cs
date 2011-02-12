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
        public bool DeclarePrivateVars = true;

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
            GlobalVars.PublicVariables.ForEach(m =>
            {
                m.Regex = new Regex("\\b" + Regex.Escape(m.VarName) + "\\b", RegexOptions.IgnoreCase);
                m.UsageCount = 0;
            }
            );
        }

        public static void AddPublicVariablesUsageStat(string fileName)
        {
            string content = File.ReadAllText(fileName);
            GlobalVars.PublicVariables.ForEach(m => m.UsageCount += m.Regex.Matches(content).Count);
        }
        public static List<Variable> GetPublicVarsOrderByUsage()
        {
            return GlobalVars.PublicVariables.OrderByDescending(m => m.UsageCount).ToList();
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
                Console.WriteLine("Done.");
            }
            return content;
        }
        public string CompilePartial(string strContent)
        {
            strContent = strContent.Replace("\t", " ");
            strContent = strContent.Replace("\r\n", "\n");
            strContent = strContent.Replace("\r", "\n");

            strContent = RemoveMultiLineComments(strContent);

            string[] content = strContent.Split(new[] {"\n"}, StringSplitOptions.RemoveEmptyEntries);
            var content1 = content.Select(m => 
                {
                    if (!FsmContent)
                    {
                        //m = RemoveSingleLineComments(m);
                    }
                    return m;
                });

            content1 = content1.Where(m => m.Trim().Length > 0).Select(m => m.Trim());
            if (!FsmContent)
            {
                content1 = content1.Where(m => !GlobalVars.ExcludeLines.Any(n => new Regex(n).IsMatch(m)));
            }

            string contentText = "";
            content1.ForEach(m => contentText = contentText + m + "\n");

            if (FsmContent)
            {
                contentText = contentText.Replace("\"\"\">*/", "*/");     // """>*/  to */
            }

            contentText = RemoveMultiLineComments(contentText);
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
                contentText = PackVariables(contentText);
                contentText = ExecuteCode(contentText);
            }


            var commands = contentText.Split(new[] {"\n"}, StringSplitOptions.RemoveEmptyEntries);
            contentText = RemoveLineBreaks(commands);
            contentText = contentText.Replace(";;", ";");

            return contentText.Trim();
        }

        public string ExecuteCode(string content)
        {
            Processor p = new Processor();
            var byteCode = p.CompileToByteCode(content);
            ExecuteCode(byteCode);

            return byteCode.ToString();
        }
        private void ExecuteCode(CmdElement byteCode)
        {
            var items = byteCode.Items;
            var commands = items.Where(m => m is CmdCommand).Select(m => (CmdCommand)m);

            commands.ForEach(cmd =>
            {
                var compile = Processor.GetCmd(cmd);
                if (compile != null && compile.OnCompile != null)
                    compile.OnCompile(cmd, this);
            });

            items.Where(m => m is CmdElement).ForEach(m => ExecuteCode((CmdElement) m));
        }

        public delegate string HandleCommand(string commandText);

        private string RemoveLineBreaks(IEnumerable<string> content1)
        {
            string contentText = "";
            bool nextLineReturn = false;
            content1.ForEach(m =>
            {
                string line = m.Trim();
                if (line.StartsWith("#"))
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
            GlobalVars.ExcludePhrases.ForEach(m =>
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
            Regex regex = new Regex(@"(\w+?)=[""]");
            var matches = regex.Matches(content);

            string[] ignoredNames = new[] { "from", "to", "name", "priority", "initstate" };

            Compiler compiler = new Compiler();

            compiler.HideVars = false;
            compiler.FileName = this.FileName;
            compiler.IsTopFile = false;
            compiler.DeclarePrivateVars = false;

            var groups = matches.Cast<Match>().Where(m => !ignoredNames.Any(n => n == m.Groups[1].Value.ToLower()));

            var scripts = groups.OrderByDescending(m => m.Index).Select(m => 
            {
                int a = m.Index + m.Length - 1;
                int b = content.GetEndQuote(a);

                string script = string.Empty;
                a = a + 1; 
                if (a != b)
                {
                    script = content.Substring(a, b - a).Replace("\"\"", "\"").Trim();
                    if (script.Length > 0)
                    {
                        script = compiler.Compile(script);
                        script = script.Trim();
                    }
                }

                return new {A = a, B = b, Script = script, Key=m.Value};
            }).Where(m => m.A < m.B);

            if (HideVars)
            {
                List<Variable> vars = new List<Variable>();
                scripts.ForEach(m => GetVariables(m.Script, vars));

                var ordered = vars.Where(m => m.VarName.StartsWith("_")).OrderByDescending(m => m.UsageCount).ToList();
                ordered.ForEach(m =>
                                    {
                                        m.Regex = new Regex("\\b" + Regex.Escape(m.VarName) + "\\b",
                                                            RegexOptions.IgnoreCase);
                                        m.ObfuscateName = GetNextLocalName();
                                    });

                ordered = ordered.OrderBy(m => m.VarName).ToList();
                scripts.ForEach(m => {
                    var script = m.Script;
                    ordered.ForEach(var => script = var.Regex.Replace(script, "uzxhgrwq" + var.ObfuscateName + "uzxhgrwq"));
                });
            }

            scripts.ForEach(m =>
            {
                var script = m.Script;
                script = script.Replace("\"", "\"\"");
                content = content.Remove(m.A, m.B - m.A);
                content = content.Insert(m.A, script);
            });

            if (HideVars)
                content = content.Replace("uzxhgrwq", "");

            return content;
        }

        private string PackVariables(string content)
        {
            if (!DeclarePrivateVars && !HideVars)
                return content;

            var vars = new List<Variable>();
            GetVariables(content, vars);
            var ordered = vars.Where(m => m.VarName.StartsWith("_")).OrderByDescending(m => m.UsageCount).ToList();


            if (HideVars)
            {
                ordered.ForEach(var =>
                {
                    var.Regex = new Regex("\\b" + Regex.Escape(var.VarName) + "\\b", RegexOptions.IgnoreCase);
                    var.ObfuscateName = GetNextLocalName();
                    content = var.Regex.Replace(content, "uzxhgrwq" + var.ObfuscateName + "uzxhgrwq");
                });
            }
            if (ordered.Count() > 0)
            {
                if (HideVars)
                    content = content.Replace("uzxhgrwq", "");

                var localVars = ordered.Select(m => (HideVars) ? m.ObfuscateName : m.VarName);

                Regex regex = new Regex(@"private\[(.+?)\];", RegexOptions.IgnoreCase );
                var matches = regex.Matches(content);

                List<string> addVars = new List<string>();

                var scopes = GetScopes(content, 0, content.Length);

                var firstDeclare = matches.Cast<Match>()
                    .Where(m => !scopes.Any(scope => scope.Start <= m.Index && m.Index <= scope.End))
                    .OrderBy(m => m.Index).FirstOrDefault();

                if (firstDeclare != null)
                    content = content.Remove(firstDeclare.Index, firstDeclare.Length);

                var privateVars = new List<string>();
                matches.Cast<Match>().ForEach(m1 =>
                {
                    var m = m1.Groups[1].Value;
                    var vars1 = m.Split(new[] { "," }, StringSplitOptions.RemoveEmptyEntries).Select(n => n.Substring(1, n.Length - 2));
                    privateVars.AddRange(vars1);
                    if (m1 == firstDeclare)
                    {
                        var used = vars1.Where(var => localVars.Any(local => local.ToLower() == var.ToLower()));
                        var unused = vars1.Where(var => !localVars.Any(local => local.ToLower() == var.ToLower()));
                        addVars.AddRange(used);

                        unused.ForEach(var => Console.WriteLine("Warning: var '{0}' declared as private but not used", var));
                    }
                });

                var unregistered = localVars.Where(localVar => !privateVars.Any(privateVar => privateVar.ToLower() == localVar.ToLower()));
                unregistered.ForEach(m => Console.WriteLine("Warning: variable {0} is not private", m));

                addVars.AddRange(unregistered);

                if (addVars.Count() > 0)
                {
                    string privateDeclare = "private[";

                    bool firstVar = true;
                    foreach (var localVar in addVars)
                    {
                        privateDeclare = privateDeclare + ((!firstVar) ? "," : "") + string.Format("'{0}'", localVar);
                        firstVar = false;
                    }
                    privateDeclare = privateDeclare + "];";
                    if (content.StartsWith("#"))
                        privateDeclare = privateDeclare + "\n";
                    content = privateDeclare + content;
                }
            }

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
        public string RemoveSingleLineComments(string content)
        {
            // delete "//" style comments

            content = content.Trim();

            for (int i = 0; i < content.Length; i++ )
            {
                if (content.IsStartString(i))    // skip strings
                {
                    var end = content.GetEndQuote(i);
                    i = (end != -1) ? end : content.Length;
                    continue;
                }

                if (content.Equal("*/", i))    // exclude select *//* 
                { i += 1; continue; }

                if (content.Equal("//", i))
                {
                    content = content.Remove(i);
                    break;
                }
            }

            return content.Trim();
        }
        public string RemoveMultiLineComments(string content)
        {
            content = content.Trim();

            int s0 = -1;
            int openMultiComment = 0;
            for (int i = 0; i < content.Length; i++)
            {
                if (content.IsStartString(i) && openMultiComment == 0)
                {
                    int i0 = i;
                    var end = content.GetEndQuote(i);
                    i = (end == -1) ? content.Length - 1 : end;
                    //Console.WriteLine("{0}: #{1}#", i0, content.Substring(i0, i-i0+1));
                    continue;
                }

                if (content.Equal("/*", i))
                {
                    if (openMultiComment == 0)
                        s0 = i;

                    openMultiComment++;
                }

                if (content.Equal("*/", i))
                {
                    if (openMultiComment > 0)
                    {
                        openMultiComment = openMultiComment - 1;
                        if (openMultiComment == 0)
                        {
                            content = content.Remove(s0, (i - s0) + 2);
                            i = s0 - 1;
                        }
                    }
                    else
                    {
                        i++;
                        continue;
                    }
                }

                if (!FsmContent)
                {
                    if (content.Equal("//", i))
                    {
                        int endLine = content.IndexOf("\n", i+1);
                        if (endLine == -1)
                            endLine = content.Length - 1;

                        content = content.Remove(i, endLine - i + 1);
                        i--;
                        continue;
                    }
                }

            }

            if (openMultiComment > 0)
            {
                Logger.Log(LogLevel.Error, "Some multi-comments are not closed: {0}", content.Substring(s0));
                content = content.Remove(s0);
            }

            return content.Trim();
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

        private void GetVariables(string content, List<Variable> vars)
        {
            Regex regex = new Regex(@"(\w+?)=[^=]");
            var matches = regex.Matches(content);

            var vars1 = matches.Cast<Match>().Select(m => m.Groups[1].Value);

            var localVars = vars1.Where(m => m.StartsWith("_") && !ReservedLocalVarNames.Any(n => n == m.ToLower()));
            RegisterVariables(content, localVars, vars, true);

            var globalVars = vars1.Where(m => !m.StartsWith("_") && !ReservedGlobalVarNames.Any(n => n == m.ToLower()));
            RegisterVariables(content, globalVars, GlobalVars.PublicVariables, false);
        }

        private void RegisterVariables(string content, IEnumerable<string> vars, List<Variable> varCollection, bool usageStat)
        {
            vars.GroupBy(m => m.ToLower()).ForEach(m =>
            {
                var var1 = varCollection.FirstOrDefault(v => v.VarName.ToLower() == m.Key.ToLower());
                if (var1 == null)
                {
                    var1 = new Variable {VarName = m.Key};
                    varCollection.Add(var1);
                }

                var1.UsageCount += (usageStat) ? GetUsageStat(content, m.Key) : 0;
            });
        }

        public int GetUsageStat(string content, string varName)
        {
            var usage = new Regex("\\b" + varName + "\\b", RegexOptions.IgnoreCase);
            return usage.Matches(content).Count;
        }
    }
}