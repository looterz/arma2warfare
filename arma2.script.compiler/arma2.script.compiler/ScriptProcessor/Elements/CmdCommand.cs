namespace ArmA2.Script.ScriptProcessor
{
    public class CmdCommand : CmdCommandBase
    {
        public override void Render(ScriptWriter writer)
        {
            string oldCmdName = Text;
            if (!GlobalSettings.AllowMinimize)
            {
                var cmd = Processor.GetCommand(Text);
                Text = cmd.Name;
            }
            base.Render(writer);
            Text = oldCmdName;
        }       
 
        public Function Function
        {
            get { return Processor.GetCommand(this.Text); }
        }
    }
}