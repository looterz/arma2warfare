﻿using ArmA2.Script.Compile.Commands.Common;
using ArmA2.Script.Compile.Exceptions;

namespace ArmA2.Script.Compile.Commands.SQF
{
    internal class CmdCommandOne : CmdCommand
    {
        internal CmdBase Arg1;

        protected override void CompileInternal(Compiler compiler)
        {
            base.CompileInternal(compiler);
            Arg1 = NextElement(1);

            if (Arg1 == null)
                throw new CompileException(CompileCode.CommandInvalidArgument,
                                           "'{0}' arg1: arg1 is not defined\nAt scope:{1}", this.Text, ParentScope.ShortTerm);       
        }
    }
}