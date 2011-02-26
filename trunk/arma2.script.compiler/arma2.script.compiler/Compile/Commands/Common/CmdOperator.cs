using ArmA2.Script.Compile.TextWriters;
using ArmA2.Script.ScriptProcessor;

namespace ArmA2.Script.Compile.Commands.Common
{
    internal class CmdOperator : CmdCommandBase
    {
        public override void Render(ScriptWriter writer)
        {
            bool addSpace = false;

            if (!writer.ApplyMinimize)
            {
                var id = Parent.Items.IndexOf(this);
                var item = Parent.Items.Get<CmdBase>(id - 1);
                addSpace = (item == null || item is CmdSeparator) ? false : true;
            }

            if (addSpace && Text == "!")
                addSpace = false;

            if (addSpace)
                writer.Write(" "); 
            
            base.Render(writer);

            if (addSpace)
                writer.Write(" ");
        }
    }
}