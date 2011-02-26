namespace ArmA2.Script.ScriptProcessor.Commands
{
    internal class CmdForEach : CmdCommandTwo
    {
        protected override void CompileInternal(Compiler compiler)
        {
            base.CompileInternal(compiler);

            //if (!(Arg1 is CmdScopeBase || Arg1 is CmdVariable))
            //    throw new CompileException(CompileCode.CommandInvalidArgument,
            //        "arg2 {0} arg1: arg1 must be array|expression|code scope|variable\nAt scope:{1}", Text, Scope.ShortTerm);

            if (!(Arg2 is CmdScopeCode || Arg2 is CmdVariable))
                throw new CompileException(CompileCode.CommandInvalidArgument,
                    "arg2 {0} arg1: arg2 must be code scope or variable\nAt scope:{1}", Text, ParentScope.ShortTerm);
        }
    }
}