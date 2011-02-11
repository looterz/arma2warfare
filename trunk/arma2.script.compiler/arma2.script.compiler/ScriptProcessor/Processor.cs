using System.Collections.Generic;
using System.Linq;

namespace ArmA2.Script.ScriptProcessor
{
    public partial class Processor
    {
        public CmdElement Execute(string content)
        {
            CmdElement root = new CmdElement();
            ProcessCommand(root, content, 0);

            GroupSetOp(root);
            return root;
        }

        private void GroupSetOp(CmdElement root)
        {
            var items = root.GetItems();
            var setOp = items.FirstOrDefault(m => (m is CmdOperator) && ((CmdOperator)m).Text == "=");
            if (setOp != null)
            {
                int id = items.IndexOf(setOp);
                var valueOp = root.GetItems().Where((m, pos) => pos > id).ToList();

                CmdElement groupOp = new CmdElement();
                valueOp.ForEach(m => {
                    groupOp.ChildAdd(m);
                    items.Remove(m);
                });

                root.ChildAdd(groupOp);
            }

            items.Where(m => m is CmdElement).ForEach(m => GroupSetOp((CmdElement) m));
        }

        private string[] _sep = (new[] {"==", ">=", "<=", "!=", "&&", "||",
                "{", "[", "(", "]", ")", "}", 
                " greater ", " greater=", " less ", " less=", " or ", " and ", " plus ",
                "!", "=", "*", "+", "-", "/", "^", "&", ",", ":", "\"", "'", ";", " "})
                .OrderByDescending(m => m.Length).ToArray();

        private int ProcessCommand(CmdElement cmdRoot, string content, int startPos)
        {
            CmdElement cmdElement = cmdRoot;
            cmdElement = new CmdElement();
            cmdRoot.ChildAdd(cmdElement);

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
                    var cmdName = content.Substring(opStart, i - opStart);
                    cmdElement.CmdAdd(cmdName);
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
                    var array = new CmdScope {OpenCh = separator};
                    cmdElement.ChildAdd(array);
                    i = ProcessCommand(array, content, i + 1);
                    continue;
                }

                if (cmdRoot is CmdScope)
                {
                    if (separator == ((CmdScope)cmdRoot).EndCh)
                    {
                        return i;
                    }
                }
                cmdElement.SeparatorAdd(separator);
                if (separator.Length > 1)
                    i = i + (separator.Length - 1);

                if (separator == ";")
                {
                    var items = cmdElement.GetItems();
                    if (items.Count == 1)
                    {
                        cmdRoot.GetItems().Remove(cmdElement);
                        cmdRoot.ChildAdd(items.First());
                    }

                    cmdElement = new CmdElement();
                    cmdRoot.ChildAdd(cmdElement);
                    continue;
                }
            }

            if (opStart != -1)
            {
                var cmdName = content.Substring(opStart, content.Length - opStart).Trim();
                cmdElement.CmdAdd(cmdName);
            }

            var items1 = cmdElement.GetItems();
            if (items1.Count == 1)
            {
                cmdRoot.GetItems().Remove(cmdElement); 
                cmdRoot.ChildAdd(items1.First());
            }

            if (cmdRoot is CmdScope)
            {
                var scope = (CmdScope)cmdElement;
                Logger.Log(LoggingLevel.Error, "Unclosed scope: {0}", scope.ToString());
            }

            return content.Length;
        }
    }
}