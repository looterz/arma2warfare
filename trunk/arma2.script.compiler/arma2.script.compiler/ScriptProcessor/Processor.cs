using System.Collections.Generic;
using System.Linq;

namespace ArmA2.Script.ScriptProcessor
{
    public partial class Processor
    {
        public Compiler Compiler { get; private set; }

        public Processor()
        {
            Compiler = new Compiler();
        }

        public Processor(Compiler compiler)
        {
            Compiler = compiler;
        }

        public CmdElement CompileToByteCode(string content)
        {
            return CompileToByteCode(content, null);
        }

        public CmdElement CompileToByteCode(string content, CmdScopeBase rootScope)
        {
            CmdScopeBase scope;
            if (rootScope == null)
                scope = new CmdScopeCodeRoot(this);
            else
            {
                scope = new CmdScopeBase();
                rootScope.ChildAdd(scope);
            }

            ProcessCommand(scope, content, 0);
            return scope;
        }

        private readonly string[] _sep = (new[] {"==", ">=", "<=", "!=", "&&", "||",
                "{", "[", "(", "]", ")", "}", 
                " greater ", " greater=", " less ", " less=", " or ", " and ", " plus ",
                "<", ">", "|", 
                "!", "=", "*", "+", "-", "/", "^", "&", ",", ":", "\"", "'", ";", " "})
                .OrderByDescending(m => m.Length).ToArray();

        private string[] _baseEndCommand = new[] {",", ";"};

        private int ProcessCommand(CmdElement cmdRoot, string content, int startPos)
        {
            List<string> separatorTypes = null;
            List<string> endCommand = null;

            CmdElement cmdElement = cmdRoot;
            cmdElement = new CmdElement();
            cmdRoot.ChildAdd(cmdElement);

            int opStart = -1;
            for(int i=startPos; i<content.Length; i++)
            {
                if (endCommand == null)
                {
                    separatorTypes = new List<string>(_sep);
                    separatorTypes.AddRange(_baseEndCommand);

                    endCommand = new List<string>(_baseEndCommand);
                }

                if (opStart == -1)
                    opStart = i;

                int i1 = i;
                var separator = separatorTypes.FirstOrDefault(m => content.Equal(m, i1));
                if (separator == null)
                    continue;

                if (cmdElement.Commands.Count() >= 1 && cmdElement.Commands.Get<CmdPreprocessor>(0) != null && separator == "\\\n")
                {
                    i += 1;
                    continue;
                }

                if (opStart != -1)
                {
                    var cmdName = content.Substring(opStart, i - opStart).Trim();

                    var cmd = cmdElement.CmdAdd(cmdName);
                    if (cmd != null && cmdElement.Commands.Count() == 1 && cmd is CmdPreprocessor)
                    {
                        separatorTypes.Clear();
                        separatorTypes.AddRange(new[] { "\\\n", "\n" });
                        separatorTypes = separatorTypes.OrderByDescending(m => m.Length).ToList();

                        endCommand.AddRange(new[]{"\n"});
                        endCommand = endCommand.OrderByDescending(m => m.Length).ToList();
                    }
                    opStart = -1;
                }

                if (separator == "'" || separator == "\"")
                {
                    var endP = content.GetEndQuote(i);
                    if (endP == -1)
                        endP = content.Length - 1;

                    var cmdString = new CmdString {Quote = separator, Text = content.Substring(i + 1, endP - i - 1)};
                    cmdElement.ChildAdd(cmdString);
                    i = endP;
                    continue;
                }

                if (separator == "[" || separator == "(" || separator == "{")
                {
                    var scope  = cmdElement.ScopeAdd(separator);;
                    i = ProcessCommand(scope, content, i + 1);
                    continue;
                }

                if (cmdRoot is CmdScopeBase)
                {
                    if (separator == ((CmdScopeBase)cmdRoot).EndCh)
                    {
                        ApplySingleChildElement(cmdRoot, cmdElement);
                        return i;
                    }
                }

                if (separator.Length > 1)
                    i = i + (separator.Length - 1);

                if (endCommand.Any(m => m == separator))
                {
                    ApplySingleChildElement(cmdRoot, cmdElement);
                    if (separator == "\n")
                        endCommand = null;

                    cmdRoot.SeparatorAdd(separator);

                    cmdElement = new CmdElement();
                    cmdRoot.ChildAdd(cmdElement);
                    continue;
                }

                if (separator == " " && cmdElement.Items.Count > 0 && cmdElement.NextElement<CmdSeparator>(-1) != null)
                {
                    // dont add trailing spaces
                }
                else
                {
                    cmdElement.SeparatorAdd(separator);    
                }
            }

            if (opStart != -1)
            {
                var cmdName = content.Substring(opStart, content.Length - opStart).Trim();
                cmdElement.CmdAdd(cmdName);
            }

            ApplySingleChildElement(cmdRoot, cmdElement);
            if (cmdRoot is CmdScopeBase && !string.IsNullOrEmpty(((CmdScopeBase)cmdRoot).OpenCh))
            {
                var scope = (CmdScopeBase)cmdRoot;
                Logger.Log(LogLevel.Error, "Unclosed scope: {0}", scope.ToString());
            }

            return content.Length;
        }

        private void ApplySingleChildElement(CmdElement cmdRoot, CmdElement cmdElement)
        {
            if (cmdElement.Items.Count == 1)
            {
                cmdRoot.Items.Remove(cmdElement);
                cmdRoot.ChildAdd(cmdElement.Items[0]);
            }
        }
    }
}