using System;

namespace ArmA2.Script.ScriptProcessor
{
    internal class CmdCommand : CmdCommandBase
    {
        public override void Render(ScriptWriter writer)
        {
            string oldCmdName = Text;
            if (!writer.ApplyMinimize)
            {
                var cmd = Processor.GetFunction(Text);
                Text = cmd.Name;
            }
            base.Render(writer);
            Text = oldCmdName;
        }       
 
        internal Function Function
        {
            get { return Processor.GetFunction(this.Text); }
        }
    }
}