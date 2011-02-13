namespace ArmA2.Script.ScriptProcessor
{
    public class CmdString : CmdText
    {
        public string Quote;
        public override void Render(ScriptWriter writer)
        {
            writer.Write(Quote);
            base.Render(writer);
            writer.Write(Quote);
        }
    }
}