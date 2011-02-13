namespace ArmA2.Script.ScriptProcessor
{
    public class CmdText : CmdBase
    {
        public string Text;
        public override void Render(ScriptWriter writer)
        {
            base.Render(writer);
            writer.Write(Text);
        }
    }
}