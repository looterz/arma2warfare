using ArmA2.Script.Compile.Commands.Common;
using ArmA2.Script.Compile.Exceptions;

namespace ArmA2.Script.Compile.Commands.SQF
{
    internal class CmdCommandTwo : CmdCommandOne
    {
        #region Поля класса

        internal CmdBase Arg2;

        #endregion

        #region Методы класса

        protected override void CompileInternal(Compiler compiler)
        {
            base.CompileInternal(compiler);
            Arg2 = NextElement(-1);

            if (Arg2 == null)
            {
                throw new CompileException(CompileCode.CommandInvalidArgument,
                                           "arg2 {0} arg1: arg2 is not defined\nAt scope:{1}", Text,
                                           ParentScope.ShortTerm);
            }
        }

        #endregion
    }
}