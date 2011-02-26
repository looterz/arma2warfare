using System.Collections.Generic;
using System.Linq;
using ArmA2.Script.Compile.Commands.Common;

namespace ArmA2.Script.Compile
{
    internal class Parser
    {
        #region Поля класса

        private readonly string[] _baseEndCommand = new[] {",", ";"};

        private readonly string[] _sep = (new[]
        {
            "==", ">=", "<=", "!=", "&&", "||",
            "{", "[", "(", "]", ")", "}",
            " greater ", " greater=", " less ", " less=", " or ", " and ", " plus ",
            "<", ">", "|",
            "!", "=", "*", "+", "-", "/", "^", "&", ",", ":", "\"", "'", ";", " ", "\n"
        }).OrderByDescending(m => m.Length).ToArray();

        #endregion

        #region Свойства класса

        internal Compiler Compiler { get; private set; }
        internal Dict Dict { get; set; }

        #endregion

        #region Конструкторы класса

        internal Parser()
        {
            Compiler = new Compiler();
            Dict = new Dict();
        }

        internal Parser(Compiler compiler)
        {
            Compiler = compiler;
            Dict = new Dict();
        }

        #endregion

        #region Методы класса

        internal CmdGroup CompileToByteCode(string content)
        {
            return CompileToByteCode(content, null);
        }

        internal CmdGroup CompileToByteCode(string content, CmdScopeBase rootScope)
        {
            CmdScopeBase scope;
            if (rootScope == null)
            {
                scope = new CmdScopeCodeRoot(this);
            }
            else
            {
                scope = new CmdScopeBase();
                rootScope.ChildAdd(scope);
            }

            ProcessCommand(scope, content, 0);
            return scope;
        }

        private int ProcessCommand(CmdGroup cmdRoot, string content, int startPos)
        {
            List<string> separatorTypes = null;
            List<string> endCommand = null;

            CmdGroup cmdGroup = cmdRoot;
            cmdGroup = new CmdGroup();
            cmdRoot.ChildAdd(cmdGroup);

            int opStart = -1;
            for (int i = startPos; i < content.Length; i++)
            {
                if (endCommand == null)
                {
                    separatorTypes = new List<string>(_sep);
                    separatorTypes.AddRange(_baseEndCommand);

                    endCommand = new List<string>(_baseEndCommand);
                }

                if (opStart == -1)
                {
                    opStart = i;
                }

                int i1 = i;
                string separator = separatorTypes.FirstOrDefault(m => content.Equal(m, i1));
                if (separator == null)
                {
                    continue;
                }

                if (cmdGroup.Commands.Count() >= 1 && cmdGroup.Commands.Get<CmdPreprocessor>(0) != null &&
                    separator == "\\\n")
                {
                    i += 1;
                    continue;
                }

                if (opStart != -1)
                {
                    string cmdName = content.Substring(opStart, i - opStart).Trim();

                    CmdText cmd = cmdGroup.CmdAdd(cmdName);
                    if (cmd != null && cmdGroup.Commands.Count() == 1 && cmd is CmdPreprocessor)
                    {
                        separatorTypes.Clear();
                        separatorTypes.AddRange(new[] {"\\\n", "\n"});
                        separatorTypes = separatorTypes.OrderByDescending(m => m.Length).ToList();

                        endCommand.AddRange(new[] {"\n"});
                        endCommand = endCommand.OrderByDescending(m => m.Length).ToList();
                    }
                    opStart = -1;
                }

                if (separator == "'" || separator == "\"")
                {
                    int endP = content.GetEndQuote(i);
                    if (endP == -1)
                    {
                        endP = content.Length - 1;
                    }

                    var cmdString = new CmdString {Quote = separator, Text = content.Substring(i + 1, endP - i - 1)};
                    cmdGroup.ChildAdd(cmdString);
                    i = endP;
                    continue;
                }

                if (separator == "[" || separator == "(" || separator == "{")
                {
                    CmdScopeBase scope = cmdGroup.ScopeAdd(separator);
                    ;
                    i = ProcessCommand(scope, content, i + 1);
                    continue;
                }

                if (cmdRoot is CmdScopeBase)
                {
                    if (separator == ((CmdScopeBase) cmdRoot).EndCh)
                    {
                        ApplySingleChildElement(cmdRoot, cmdGroup);
                        return i;
                    }
                }

                if (separator.Length > 1)
                {
                    i = i + (separator.Length - 1);
                }

                if (endCommand.Any(m => m == separator))
                {
                    ApplySingleChildElement(cmdRoot, cmdGroup);
                    if (separator == "\n")
                    {
                        endCommand = null;
                    }

                    cmdRoot.SeparatorAdd(separator);

                    cmdGroup = new CmdGroup();
                    cmdRoot.ChildAdd(cmdGroup);
                    continue;
                }

                if (separator == " " && cmdGroup.Items.Count > 0 && cmdGroup.NextElement<CmdSeparator>(-1) != null)
                {
                    // dont add trailing spaces
                }
                else
                {
                    cmdGroup.SeparatorAdd(separator);
                }
            }

            if (opStart != -1)
            {
                string cmdName = content.Substring(opStart, content.Length - opStart).Trim();
                cmdGroup.CmdAdd(cmdName);
            }

            ApplySingleChildElement(cmdRoot, cmdGroup);
            if (cmdRoot is CmdScopeBase && !string.IsNullOrEmpty(((CmdScopeBase) cmdRoot).OpenCh))
            {
                var scope = (CmdScopeBase) cmdRoot;
                Logger.Log(LogLevel.Error, "Unclosed scope: {0}", scope.ToString());
            }

            return content.Length;
        }

        private void ApplySingleChildElement(CmdGroup cmdRoot, CmdGroup cmdGroup)
        {
            if (cmdGroup.Items.Count == 1)
            {
                cmdRoot.Items.Remove(cmdGroup);
                cmdRoot.ChildAdd(cmdGroup.Items[0]);
            }
        }

        #endregion
    }
}