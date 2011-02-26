using ArmA2.Script.Compile.Lexicon;
using ArmA2.Script.Compile.TextWriters;
using ArmA2.Script.ScriptProcessor;

namespace ArmA2.Script.Compile.Commands.Common
{
    internal class CmdCommand : CmdCommandBase
    {
        public override void Render(ScriptWriter writer)
        {
            string oldCmdName = Text;
            if (!writer.ApplyMinimize)
            {
                var cmd = Parser.Dict.GetFunction(Text);
                Text = cmd.Name;
            }
            base.Render(writer);
            Text = oldCmdName;
        }       
 
        internal Function Function
        {
            get { return Parser.Dict.GetFunction(this.Text); }
        }
    }
}