using System;
using System.Diagnostics;
using System.Linq;
using System.Text;
using ArmA2.Script.ScriptProcessor.Commands;

namespace ArmA2.Script.ScriptProcessor
{
    //[DebuggerTypeProxy(typeof(Flatten))]

    public class CmdElement : CmdBase
    {
        public readonly CmdElementCollection Items = new CmdElementCollection();

        public event EventHandler ChildAdded;

        public CmdBase ChildAdd(CmdBase child)
        {
            child.Parent = this;
            Items.Add(child);

            if (ChildAdded != null)
                ChildAdded(this, null);

            return child;
        }

        public CmdText CmdAdd(string cmdName)
        {
            if (cmdName.Length != 0)
            {
                double value;
                CmdText cmd;
                if (Processor.IsCommand(cmdName))
                {
                    if (cmdName.StartsWith("#"))
                        cmd = new CmdPreprocessor { Text = cmdName };
                    else
                    {
                        cmd = Processor.GetFunction(cmdName).GetCmdCompile() ?? new CmdCommand();
                        cmd.Text = cmdName;
                    }
                }
                else if (Processor.IsOperator(cmdName))
                {
                    if (cmdName == "=")
                        cmd = new CmdOperatorSet {Text = cmdName};
                    else
                        cmd = new CmdOperator {Text = cmdName};
                }
                else if (double.TryParse(cmdName, out value))
                {
                    cmd = new CmdFloat { Text = cmdName };
                }
                else
                    cmd = new CmdVariable { Text = cmdName };

                ChildAdd(cmd);
                return cmd;
            }
            return null;
        }

        public CmdBase SeparatorAdd(string separatorName)
        {
            if (separatorName.Length != 0)
            {
                if (Processor.IsOperator(separatorName))
                    return CmdAdd(separatorName);

                return ChildAdd(new CmdSeparator { Text = separatorName });
            }
            return null;
        }

        public CmdScopeBase ScopeAdd(string openScopeCh)
        {
            CmdScopeBase scope;
            switch (openScopeCh)
            {
                case "[":
                    scope = new CmdScopeArray();
                    break;
                case "{":
                    scope = new CmdScopeCode();
                    break;
                case "(":
                    scope = new CmdScopeExpression();
                    break;
                default:
                    Logger.Log(LogLevel.Warning, "CreateNewScope: Unknown open scope char - '{0}'", openScopeCh);
                    scope = new CmdScopeBase();
                    break;
            }
            ChildAdd(scope);
            return scope;
        }

        public CmdElementCollection Commands
        {
            get
            {
                var items = new CmdElementCollection();
                items.AddRange(Items.Where(m => 
                    !(m is CmdSeparator) &&
                    !(m.GetType() == typeof(CmdElement) && ((CmdElement)m).Items.Count == 0)
                    ));
                return items;
            }
        }

        public CmdElementCollection FlatData
        {
            get
            {
                var items = new CmdElementCollection();
                foreach(var item in Commands)
                {
                    if (!item.GetType().Equals(typeof(CmdElement)))
                    {
                        items.Add(item);
                    }
                    
                    if (item is CmdElement)
                    {
                        items.AddRange(((CmdElement)item).FlatData);
                    }
                }
                return items;
            }
        }

        public override void Render(ScriptWriter writer)
        {
            base.Render(writer);
            Items.Render(writer);
        }

        protected override void CompileInternal(Compiler compiler)
        {
            base.CompileInternal(compiler);

            var cmd = Commands.Get<CmdPreprocessor>(0);
            if (cmd != null)
                return;

            var op = Commands.Get<CmdOperatorSet>(1);
            if (op != null)
            {
                op.Compile(compiler);
                return;
            }

            Items.ForEach(op1 => op1.CompileSafe(compiler));
        }
    }
}