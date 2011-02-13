﻿namespace ArmA2.Script.ScriptProcessor
{
    public class CmdSeparator : CmdText
    {
        public override void Render(ScriptWriter writer)
        {
            base.Render(writer);
            if (Text == ";")
                writer.WriteIndent(true, "");
            else
            {
                if (!GlobalSettings.AllowMinimize && Text != " ")
                    writer.Write(" ");
            }
        }        
    }
}