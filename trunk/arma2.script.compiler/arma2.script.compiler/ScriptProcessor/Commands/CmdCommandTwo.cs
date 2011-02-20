namespace ArmA2.Script.ScriptProcessor.Commands
{
    public class CmdCommandTwo : CmdCommandOne
    {
        public CmdBase Arg2;

        protected override void CompileInternal(Compiler compiler)
        {
            base.CompileInternal(compiler);
            Arg2 = NextElement(-1);

            if (Arg2 == null)
                throw new CompileException(CompileCode.CommandInvalidArgument,
                                           "arg2 {0} arg1: arg2 is not defined\nAt scope:{1}", this.Text, Scope.ShortTerm);
        }
    }
}