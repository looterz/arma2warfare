﻿namespace ArmA2.Script.ScriptProcessor
{
    public class CmdOperator : CmdCommandBase
    {
        public override void Render(ScriptWriter writer)
        {
            bool addSpace = false;

            if (!GlobalSettings.AllowMinimize)
            {
                var id = Parent.Items.IndexOf(this);
                var item = Parent.Items.Get<CmdBase>(id - 1);
                addSpace = (item == null || item is CmdSeparator) ? false : true;
            }

            if (addSpace)
                writer.Write(" "); 
            
            base.Render(writer);

            if (addSpace)
                writer.Write(" ");
        }
    }
}