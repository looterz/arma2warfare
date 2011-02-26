using ArmA2.Script.Compile;

namespace ArmA2.Script.ScriptProcessor
{
    internal class CmdText : CmdBase
    {
        internal string Text;
        public override void Render(ScriptWriter writer)
        {
            base.Render(writer);
            writer.Write(Text);
        }
    }
}