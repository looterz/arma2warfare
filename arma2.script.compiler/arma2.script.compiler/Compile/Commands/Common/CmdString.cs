using ArmA2.Script.Compile.TextWriters;

namespace ArmA2.Script.Compile.Commands.Common
{
    internal class CmdString : CmdText
    {
        internal string Quote;
        public override void Render(ScriptWriter writer)
        {
            writer.Write(Quote);
            base.Render(writer);
            writer.Write(Quote);
        }
    }
}