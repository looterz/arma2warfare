namespace ArmA2.Script.ScriptProcessor
{
    public class CmdScopeExpression : CmdScopeBase
    {
        public CmdScopeExpression()
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