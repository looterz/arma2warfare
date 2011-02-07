using System;
using System.Collections.Generic;
using System.IO;
using System.Linq;
using System.Text.RegularExpressions;

namespace ArmA2.Script
{
    public class Compiler
    {
        public static bool WarnStringUnclosed = false;

        public bool FsmContent = false;
        public bool HideVars = false;

        public string FileName = string.Empty;
        public bool IsTopFile = true;
        public bool DeclarePrivateVars = true;

        public static void CompileFile(string fileName, bool showHeader)
        {
            string content = File.ReadAllText(fileName);

            var obfuscate = new Compiler();
            obfuscate.FileName = fileName;
            obfuscate.IsTopFile = showHeader;

            obfuscate.FsmContent = (Path.GetExtension(fileName).ToLower() == ".fsm");
            content = obfuscate.Compile(content);
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

        public string Compile(string strContent)
        {
            if (IsTopFile)
            {
                Console.WriteLine("---------------------------------------------");
                Console.WriteLine("Compile: {0}", FileName);
            }
            strContent = strContent.Replace("\t", " ");
            strContent = strContent.Replace("\r\n", "\n");
            strContent = strContent.Replace("\r", "\n");

            string[] content = strContent.Split(new[] {"\n"}, StringSplitOptions.RemoveEmptyEntries);
            var content1 = content.Select(RemoveSingleLineComments);

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
                //contentText = ProcessCommands(contentText);
                contentText = RemoveExtraSpaces(contentText);
                contentText = ContentCleanup(contentText);
                contentText = PackVariables(contentText);
            }


            var commands = contentText.Split(new[] {"\n"}, StringSplitOptions.RemoveEmptyEntries);
            contentText = RemoveLineBreaks(commands);
            contentText = contentText.Replace(";;", ";");

            if (IsTopFile)
            {
                Console.WriteLine();
                Console.WriteLine("Done.");
            }
            return contentText.Trim();
        }

        public delegate string HandleCommand(string commandText);
        public string ProcessCommands(string content, HandleCommand handleCommand)
        {
            var scopes = GetScopes(content, 0, content.Length).OrderByDescending(m => m.Start);
            scopes.ForEach(m =>
            {
                int L = m.End - m.Start;
                if (L > 0)
                {
                    var scopeContent = content.Substring(m.Start+1, L-1);
                    scopeContent = ProcessCommands(scopeContent, handleCommand);
                    content = content.Remove(m.Start + 1, L-1);
                    content = content.Insert(m.Start + 1, scopeContent);
                }
            });

            List<Scope> commandScopes = new List<Scope>();
            int end = content.Length;
            int start;
            var scopes1 = GetScopes(content, 0, content.Length).OrderByDescending(m => m.Start).ToArray();
            for (int i = scopes1.Count()-1; i >= 0; i--)
            {
                start = scopes1[i].End;
                if (start < end && start < content.Length)
                {
                    commandScopes.Add(new Scope {Start = start+1, End = end});
                }
                end = scopes1[i].Start;
            }

            start = 0;
            if (start < end)
            {
                commandScopes.Add(new Scope { Start = start, End = end });
            }

            commandScopes.ForEach(m =>
            {
                int L = m.End - m.Start;
                if (L > 0)
                {
                    var scopeContent = content.Substring(m.Start, L);
                    scopeContent = ProcessCommandLine(scopeContent, handleCommand);
                    content = content.Remove(m.Start, L);
                    content = content.Insert(m.Start, scopeContent);
                }
            });            


            return content;
        }


        private string ProcessCommandLine(string line, HandleCommand handleCommand)
        {
            line = line.Trim();
            Console.WriteLine(line);

            int start = 0;
            while (true)
            {
                int pos = GetNextChar(line, start, ";");
                int end = (pos == -1) ? line.Length : pos;

                string cmd = line.Substring(start, end - start);
                handleCommand.Invoke(cmd);

                start = pos+1;
                if (pos == -1)
                    break;
            }


            return line;
        }

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
                int b = GetNextStringEnd(content, a);

                a = a + 1;
                b = b - 1;

                var script = content.Substring(a, b - a).Replace("\"\"", "\"").Trim();
                if (script.Length > 0)
                {
                    script = compiler.Compile(script);
                    script = script.Trim();
                }

                return new {A = a, B = b, Script = script, Key=m.Value};
            });

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
                int ix1 = GetScopeNext(content, start);
                if (ix1 == -1 || ix1 > end)
                    break;

                var ix2 = GetScopeEnd(content, ix1);
                if (ix2 == -1)
                    break;

                scopes.Add(new Scope { Start = ix1, End = ix2});
                start = ix2 + 1;
            }
            return scopes;
        }

        public int GetNextChar(string content, int startPos, string ch)
        {
            if (startPos == -1 || startPos >= content.Length)
                return -1;

            while (true)
            {
                int pos = content.IndexOf(ch, startPos);
                if (pos == -1)
                    return -1;

                while (true)
                {
                    int strA = GetNextStringStart(content, startPos);
                    if (strA == -1)
                        return pos;

                    int strB = GetNextStringEnd(content, strA);
                    if (strB == -1)
                    {
                        Console.WriteLine("Warning! Unterminated string: {0}", content.Substring(strA));
                        return -1;
                    }

                    if (strA < pos && pos < strB)
                    {
                        startPos = strB;    // скобка лежит внутри строки... это недопустимо
                        break;
                    }
                    startPos = strB;    // ищем следующую строку
                }
            }
        }

        public int GetScopeNext(string content, int startPos)
        {
            return GetNextChar(content, startPos, "{");
        }

        public int GetScopeEnd(string content, int startPos)
        {
            while (startPos != -1 && startPos < content.Length)
            {
                int pos = GetNextChar(content, startPos, "}");
                int insideScope = GetScopeNext(content, startPos + 1);
                if (insideScope == -1 || insideScope > pos)
                    return pos;

                startPos = GetScopeEnd(content, insideScope);
                if (startPos != -1)
                    startPos++;
            }
            return -1;
        }

        private int GetQuote(string line, int startPos, char quote)
        {
            char[] quotes = new char[]{'\'', '"'};
            if (quote != 0)
                quotes = new char[] {quote};

            for (int i = startPos; i < line.Length; i++)
            {
                var ch = line[i];
                if (quotes.Any(m => m == ch))
                {
                    return i;
                }
            }
            return -1;
        }
        public int GetEndQuotePos(string line, int startPos)
        {
            var withoutEscapes = line.Substring(startPos+1)
                .Replace("''", "##")         // ''
                .Replace("\"\"", "##")       // ""
                .Replace("\\\"", "##");      // \"

            var pos = GetQuote(withoutEscapes, 0, line[startPos]);
            return (pos != -1) ? startPos + pos + 1 : -1;
        }
        public int GetNextStringStart(string line, int startPos)
        {
            return GetQuote(line, startPos, (char)0);
        }
        public int GetNextStringEnd(string line, int startPos)
        {
            startPos = GetNextStringStart(line, startPos);
            return GetStringEnd(line, startPos);
        }

        private int GetStringEnd(string line, int startPos)
        {
            if (startPos != -1)
            {
                var endPos = GetEndQuotePos(line, startPos);
                if (endPos == -1)
                {
                    if (WarnStringUnclosed)
                    {
                        Console.WriteLine("string not closed");
                        int L = line.Length - startPos;
                        if (L > 30) L = 30;
                        Console.WriteLine(line.Substring(startPos, L));
                    }
                    endPos = line.Length - 1;
                }

                return endPos + 1;
            }
            return -1;
        }
        public string GetNextString(string line, int startPos)
        {
            startPos = GetQuote(line, startPos, (char)0);
            if (startPos != -1)
            {
                var endPos = GetEndQuotePos(line, startPos);
                if (endPos == -1)
                {
                    if (WarnStringUnclosed)
                    {
                        Console.WriteLine("string not closed");
                        int L = line.Length - startPos;
                        if (L > 30) L = 30;
                        Console.WriteLine(line.Substring(startPos, L));
                    }
                    endPos = line.Length - 1;
                }

                return line.Substring(startPos, endPos - startPos + 1);
            }
            return null;
        }
        public string RemoveSingleLineComments(string line)
        {
            line = line.Trim();
            line = RemoveMultiLineComments(line);

            int startComment;
            int startPos = 0;
            while (true)
            {
                startComment = line.IndexOf("//", startPos);
                if (startComment == 0)
                    break;

                var start = GetNextStringStart(line, startPos);
                var end = (start != -1) ? GetNextStringEnd(line, startPos) : -1;
                if (end == -1 || startComment < start)
                    break;

                startPos = end + 1;
            }

            while (startPos < line.Length && startPos != -1)
            {
                var pos = line.IndexOf("//", startPos);
                if (pos == -1)
                    break;

                line = line.Remove(pos);
                startPos = line.Length;
            }

            return line.Trim();
        }
        public string RemoveMultiLineComments(string line)
        {
            line = line.Trim();
            int l0 = line.Length;
            
            int startPos = 0;
            while (startPos != -1 && startPos < line.Length)
            {
                var next = GetNextStringStart(line, startPos);
                if (next != -1)
                {
                    if (next > 0)
                    {
                        int l1 = line.Length;
                        line = RemoveMultiLineComment(line, startPos, next - 1);
                        if (l1 == line.Length)
                        {
                            next = GetNextStringStart(line, startPos);
                            var endStr = GetStringEnd(line, next);
                            startPos = (endStr != -1) ? endStr : line.Length;
                        }
                    }
                    else
                    {
                        var endStr = GetStringEnd(line, next);
                        startPos = (endStr != -1) ? endStr : line.Length;
                    }
                }
                else break;
            }

            line = RemoveMultiLineComment(line, startPos, line.Length);
            line = line.Trim();

            if (line.Length != l0)
                line = RemoveMultiLineComments(line);

            return line.Trim();
        }
        public string RemoveMultiLineComment(string line, int startPos, int endPos)
        {
            if (startPos >= line.Length)
                return line;

            var startComment = line.IndexOf("/*", startPos);
            if (startComment > endPos || startComment == -1)
                return line;

            line = RemoveMultiLineComment(line, startComment + 2, endPos); // recurse for remove inside comments
            var endComment = line.IndexOf("*/", startComment);

            if (endComment != -1)
            {
                endComment = endComment + 2;
                line = line.Remove(startComment, endComment - startComment);
            }
            return line;
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
                    var endStr = GetStringEnd(line, next);
                    startPos = (endStr != -1) ? endStr : line.Length;
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
                var str1end = (str1start != -1) ? GetStringEnd(line, str1start) : -1;

                while (str1end != -1)
                {
                    var str2start = GetNextStringStart(line, str1end);
                    if (str2start == -1)
                    {
                        startPos = str1end;
                        break;
                    }

                    var m = line.Substring(str1end, str2start - str1end).Trim();
                    if (m == @"\n")
                    {
                        line = line.Remove(str1end - 1, str2start - str1end + 2);
                        if (this.FsmContent)
                        { 
                            line = line.Insert(str1end - 1, "\n");
                        }
                        str1end = GetStringEnd(line, str1start);
                    }
                    else
                    {
                        str1start = str2start;
                        str1end = (str1start != -1) ? GetStringEnd(line, str1start) : -1;
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