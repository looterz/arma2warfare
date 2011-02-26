using System;
using System.Linq;
using ArmA2.Script.Compile.Collections;
using ArmA2.Script.ScriptProcessor;
using ArmA2.Script.ScriptProcessor.Commands;

namespace ArmA2.Script.Compile.Commands.Common
{
    //[DebuggerTypeProxy(typeof(Flatten))]

    internal class CmdGroup : CmdBase
    {
        internal readonly CmdCollection Items = new CmdCollection();

        internal event EventHandler ChildAdded;

        internal CmdBase ChildAdd(CmdBase child)
        {
            child.Parent = this;
            Items.Add(child);

            if (ChildAdded != null)
                ChildAdded(this, null);

            return child;
        }

        internal CmdText CmdAdd(string cmdName)
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

        internal CmdBase SeparatorAdd(string separatorName)
        {
            if (separatorName.Length != 0)
            {
                if (Processor.IsOperator(separatorName))
                    return CmdAdd(separatorName);

                return ChildAdd(new CmdSeparator { Text = separatorName });
            }
            return null;
        }

        internal CmdScopeBase ScopeAdd(string openScopeCh)
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

        internal CmdCollection Commands
        {
            get
            {
                var items = new CmdCollection();
                items.AddRange(Items.Where(m => 
                    !(m is CmdSeparator) &&
                    !(m.GetType() == typeof(CmdGroup) && ((CmdGroup)m).Items.Count == 0)
                    ));
                return items;
            }
        }

        internal CmdCollection FlatData
        {
            get
            {
                var items = new CmdCollection();
                foreach(var item in Commands)
                {
                    if (!item.GetType().Equals(typeof(CmdGroup)))
                    {
                        items.Add(item);
                    }
                    
                    if (item is CmdGroup)
                    {
                        items.AddRange(((CmdGroup)item).FlatData);
                    }
                }
                return items;
            }
        }

        public override void Render(ScriptWriter writer)
        {
            base.Render(writer);
            Items.Render(writer);

            //if (Items.Any(m => m is CmdPreprocessor))
            //    writer.WriteIndent(true, "");
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