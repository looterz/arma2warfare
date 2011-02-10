using System.Collections.Generic;
using System.Linq;

namespace ArmA2.Script.ScriptProcessor
{
    public class Processor
    {
        public bool ScriptDefinition = true;
        public bool Scope = false;

        public List<string> LocalVars = new List<string>();
        public List<string> PrivateVars = new List<string>();

        public int StartPosition { get; private set; }
        public int EndPosition { get; private set; }

        public void Execute(string content)
        {
            CmdElement root = new CmdElement();
            int startPos = 0;

            while (startPos < content.Length)
            {
                CmdElement script = new CmdElement();
                root.Elements.Add(script);
                startPos = ProcessCommand(script, content, startPos) + 1;
            }

            string test = root.ToString();
            if (test == content)
                test = test;
        }

        private string[] _sep = {"==", ">=", "<=", "!=", "&&", "||",
                "{", "[", "(", "]", ")", "}", 
                "!", "=", "*", "+", "-", "/", "^", "&", ",", ":", "\"", "'", ";", " "};

        private int ProcessCommand(CmdElement cmdElement, string content, int startPos)
        {
            int opStart = -1;
            for(int i=startPos; i<content.Length; i++)
            {
                if (opStart == -1)
                    opStart = i;

                int i1 = i;
                var separator = _sep.FirstOrDefault(m => content.Equal(m, i1));
                if (separator == null)
                    continue;

                if (opStart != -1)
                {
                    var leftOp = content.Substring(opStart, i - opStart);
                    if (leftOp.Length != 0)
                        cmdElement.Elements.Add(new CmdOperator {Text = leftOp});

                    opStart = -1;
                }

                if (separator == "'" || separator == "\"")
                {
                    var endP = content.GetEndQuote(i);
                    if (endP == -1)
                        endP = content.Length - 1;

                    var cmdString = new CmdString {Quote = separator, Text = content.Substring(i + 1, endP - i - 1)};
                    cmdElement.Elements.Add(cmdString);
                    i = endP;
                    continue;
                }

                if (separator == "[" || separator == "(" || separator == "{")
                {
                    var array = new CmdScope {OpenCh = separator};
                    cmdElement.Elements.Add(array);
                    i = ProcessCommand(array, content, i + 1);
                    continue;
                }

                if (cmdElement is CmdScope)
                {
                    if (separator == ((CmdScope)cmdElement).EndCh)
                    {
                        return i;
                    }
                }
                cmdElement.Elements.Add(new CmdSeparator { Text = separator});

                if (separator == ";")
                    return i;
            }

            if (cmdElement is CmdScope)
            {
                var scope = (CmdScope)cmdElement;
                Logger.Log(LoggingLevel.Error, "Unclosed scope: {0}", scope.ToString());
            }

            return content.Length;
        }

        private void RegisterVariable(string varName)
        {
            if (LocalVars.Any(m => m.ToLower() == varName.ToLower()))
                return;

            LocalVars.Add(varName);
        }
    }
}