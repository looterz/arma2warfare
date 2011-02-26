using ArmA2.Script.Compile;

namespace ArmA2.Script.ScriptProcessor.Commands
{
    internal class CmdFor : CmdCommand
    {
        protected override void CompileInternal(Compiler compiler)
        {
            base.CompileInternal(compiler);

            // for '_z' from 0 to (count _c)-1 do {}
            var cmd2 = NextElement<CmdCommand>(2);
            if (cmd2 != null && cmd2.Text == "from")
            {
                var arg1 = NextElement<CmdBase>(1);
                if ((arg1 is CmdString || arg1 is CmdVariable) == false)
                    throw new CompileException(CompileCode.CommandInvalidArgument,
                                               "Command \"for '_var' from\" _var must be string or variable\nAt scope:{0}",
                                               ParentScope.ShortTerm);

                if (arg1 is CmdString)
                {
                    var varName = ((CmdString) NextElement(1)).Text;
                    ParentScope.LocalVars.VarAdd(varName);
                }
            }
        }
    }
}