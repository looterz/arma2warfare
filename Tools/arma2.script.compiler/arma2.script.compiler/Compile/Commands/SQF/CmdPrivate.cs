using ArmA2.Script.Compile.Commands.Common;
using ArmA2.Script.Compile.Exceptions;

namespace ArmA2.Script.Compile.Commands.SQF
{
    internal class CmdPrivate : CmdCommandOne
    {
        protected override void CompileInternal(Compiler compiler)
        {
            base.CompileInternal(compiler);

            var data = NextElement<CmdScopeArray>(1);
            if (data == null)
                throw new CompileException(CompileCode.CommandInvalidArgument,
                                          "Private argument must be array with string names of local variables\nAt scope:{0}",
                                          ParentScope.ShortTerm);
           
            foreach (var item in data.Commands)
            {
                try
                {
                    CompilePrivateArrayItem(item);
                }
                catch (CompileException e)
                {
                    if (e.Throwable)
                        throw;

                    e.WriteToLog();
                }
            }
            
        }

        private void CompilePrivateArrayItem(CmdBase item)
        {
            if (item is CmdString == false)
                throw new CompileException(CompileCode.InvalidArrayElement,
                                           "Element in private array is not string '{0}'\nAt scope:{1}",
                                           item, ParentScope.ShortTerm);

            var varName = (CmdString)item;

            if (ParentScope.PrivateVars.IsDeclared(varName.Text))
                throw new CompileException(CompileCode.PrivateVarDuplicate,
                                           "Duplicated '{0}' in private array\nAt scope:{1}",
                                           varName.Text, ParentScope.ShortTerm);

            ParentScope.PrivateVars.VarAdd(varName.Text);
        }
    }
}