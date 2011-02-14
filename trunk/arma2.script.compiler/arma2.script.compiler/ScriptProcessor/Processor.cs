using System.Collections.Generic;
using System.Linq;

namespace ArmA2.Script.ScriptProcessor
{
    public partial class Processor
    {
        public CmdElement CompileToByteCode(string content)
        {
            CmdScopeBase root = new CmdScopeBase();
            ProcessCommand(root, content, 0);

            GroupSetOp(root);
            return root;
        }

        public List<string> Validate(CmdElement root)
        {
            var validate = new List<string>();
            Validation.ValidateElement(root, validate);

            return validate;
        }

        private void GroupSetOp(CmdElement root)
        {
            var items = root.Items;

            var operators =
                items.Select((m, id) => new { Id = id, Item = m }).Where(m => m.Item is CmdCommandBase).Select(m => new { Id = m.Id, Item = (CmdCommandBase)m.Item, Text = ((CmdCommandBase)m.Item).Text });

            var op = operators.FirstOrDefault();

            if (op != null && !(root is CmdScopeArray))
            {
                var nextOp = (op.Text != "=") ? operators.FirstOrDefault(m => m.Id > op.Id) : null; // get next operator - skip if current operator is assignment operator
                var nextOpId = (nextOp != null) ? nextOp.Id : items.Count();

                var valueOp2 = root.Items.Where((m, pos) => op.Id < pos && pos < nextOpId ).ToList();

                if (valueOp2.Where(m => (!(m is CmdSeparator))).Count() > 1)
                {
                    CmdElement groupOp2 = new CmdElement();
                    groupOp2.Parent = root;
                    valueOp2.ForEach(m => { groupOp2.ChildAdd(m); items.Remove(m); });
                    items.Insert(op.Id + 1, groupOp2);
                }
            }

            items.Where(m => m is CmdElement).ForEach(m => GroupSetOp((CmdElement) m));
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

                if (opStart != -1)
                {
                    var cmdName = content.Substring(opStart, i - opStart).Trim();

                    var cmd = cmdElement.CmdAdd(cmdName);
                    if (cmd != null && cmdElement.Commands.Count() == 1 && cmd is CmdPreprocessor)
                    {
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

                cmdElement.SeparatorAdd(separator);
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