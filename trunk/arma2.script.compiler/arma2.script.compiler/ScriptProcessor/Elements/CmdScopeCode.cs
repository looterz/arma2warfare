using System.Linq;
using ArmA2.Script.ScriptProcessor.Commands;

namespace ArmA2.Script.ScriptProcessor
{
    internal class CmdScopeCode : CmdScopeCodeRoot
    {
        internal CmdScopeCode() : base(null)
        {
            OpenCh = "{";
            EndCh = "}";
        }

        protected override void CompileInternal(Compiler compiler)
        {
            base.CompileInternal(compiler);

            var nextCmd = NextElement(1);
            if (nextCmd != null)
            {
                bool bClosed = false;
                if (nextCmd is CmdCommand)
                {
                    string[] scopeCommands = new[] {"do", "then", "else", "foreach", "count"};

                    CmdCommand cmd1 = (CmdCommand) nextCmd;
                    bClosed = scopeCommands.Any(m => m.Equal(cmd1.Text));
                }

                if (Parent is CmdScopeArray)
                {
                    var nextCmd1 = Parent.NextElement(-1);
                    if (nextCmd1 is CmdCommand && ((CmdCommand) nextCmd1).Text == "for")
                        bClosed = true;
                }

                if (!bClosed)
                {
                    throw new CompileException(CompileCode.MissingSeparator,
                        "Missing ; at end scope\nAt scope {0}",
                        ShortTerm);
                }
            }
        }

    }
}