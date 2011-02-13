namespace ArmA2.Script.ScriptProcessor
{
    public class CmdPreprocessor : CmdCommand
    {
        public override void Render(ScriptWriter writer)
        {
            if (writer.BaseStream.Length > 0)
                writer.Write("\n");

            base.Render(writer);
        }
    }
}