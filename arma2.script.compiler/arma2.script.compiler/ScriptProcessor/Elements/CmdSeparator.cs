using System.Linq;

namespace ArmA2.Script.ScriptProcessor
{
    internal class CmdSeparator : CmdText
    {
        private static string[] IgnoredOnRender = {" ", "\n"};
        public static int pos = 0;

        public override void Render(ScriptWriter writer)
        {
            base.Render(writer);
            if ((Text == ";" || Text == "\n"))
            {
                bool newLine = true;
                //var next = this.NextItem(this.IndexId + 1);

                writer.WriteIndent(true, newLine, "");
            }
            else
            {
                if (!writer.ApplyMinimize && !IgnoredOnRender.Any(m => m.Equal(Text)))
                    writer.Write(" ");
            }
        }        
    }
}