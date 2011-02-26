using System.Linq;
using ArmA2.Script.Compile;

namespace ArmA2.Script.ScriptProcessor.Commands
{
    internal class CmdOperatorSet : CmdOperator
    {
        protected override void CompileInternal(Compiler compiler)
        {
            base.CompileInternal(compiler);

            //CmdElement element = Parent;

            var id = Parent.Items.IndexOf(this);
            Parent.Items.Where((m, id1) => id1 > id).ForEach(op1 => op1.CompileSafe(compiler));

            var prevOp = NextElement(-1);

            if (NextElement(-1) is CmdVariable)
            {
                CmdVariable varName = (CmdVariable) NextElement(-1);

                if (varName.IsLocal)
                {
                    bool declared = compiler.Context.ReservedNameLocalVariable.Any(m => m.Equal(varName.Text));

                    if (declared)
                    {
                        Logger.Log(LogLevel.Warning, CompileCode.AssigmentToReserved, "Assignment to reserved variable: {0}",
                                   Parent.ShortTerm);
                    }

                    declared = (declared || Parent.ParentScope.LocalVars.Any(m => m.Equal(varName.Text)));

                    if (!declared)
                    {
                        Parent.ParentScope.LocalVars.Add(varName.Text);
                    }
                }
            }
            else if (prevOp != null)
            {
                Logger.Log(LogLevel.Error, "Left operator is not variable: {0}",
                           Parent.ShortTerm);
            }
            else
            {
                Logger.Log(LogLevel.Error, "Assignment variable not found: {0}",
                           Parent.ShortTerm);
            }
        }
    }
}