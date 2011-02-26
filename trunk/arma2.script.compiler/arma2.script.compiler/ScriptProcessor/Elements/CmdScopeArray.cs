using ArmA2.Script.Compile;

namespace ArmA2.Script.ScriptProcessor
{
    internal class CmdScopeArray : CmdScopeBase
    {
        internal CmdScopeArray()
        {
            OpenCh = "[";
            EndCh = "]";
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