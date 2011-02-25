namespace ArmA2.Script.ScriptProcessor
{
    internal class CmdSeparator : CmdText
    {
        public override void Render(ScriptWriter writer)
        {
            base.Render(writer);
            if (Text == ";")
                writer.WriteIndent(true, "");
            else
            {
                if (!writer.ApplyMinimize && Text != " ")
                    writer.Write(" ");
            }
        }        
    }
}