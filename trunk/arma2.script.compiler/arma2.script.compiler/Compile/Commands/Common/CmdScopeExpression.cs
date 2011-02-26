using ArmA2.Script.Compile.TextWriters;
using ArmA2.Script.ScriptProcessor;

namespace ArmA2.Script.Compile.Commands.Common
{
    internal class CmdScopeExpression : CmdScopeBase
    {
        internal CmdScopeExpression()
        {
            OpenCh = "(";
            EndCh = ")";
        }

        public override void Render(ScriptWriter writer)
        {
            var state = writer.Minimized;
            writer.Minimized = true;
            base.Render(writer);
            writer.Minimized = state;
        }
    }
}