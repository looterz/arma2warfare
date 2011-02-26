using ArmA2.Script.Compile;
using ArmA2.Script.Compile.Collections;

namespace ArmA2.Script.ScriptProcessor
{
    internal class CmdVariable : CmdText
    {
        internal bool IsLocal
        {
            get { return (string.IsNullOrEmpty(Text)) ? false : Text.StartsWith("_"); }
        }

        protected override void CompileInternal(Compiler compiler)
        {
            base.CompileInternal(compiler);

            if (IsLocal)
            {
                if (!ParentScope.LocalVars.IsDeclared(Text) && compiler.Settings.UpdatePrivateVars)
                {
                    if (ParentScope.IsDeclaredInOuterScope(Text))
                    {
                        return;
                        //throw new CompileException(CompileCode.OutOfScopeDeclaration,
                        //           "Variable '{0}' declared at outer scope, possible errors.\nAt scope:{1}",
                        //           Text, Scope.ShortTerm);
                    }

                    if (!ParentScope.CompileProperties.ContainsKey("UseUndeclaredVars"))
                        ParentScope.CompileProperties.Add("UseUndeclaredVars", new UniqueVarList(Processor.Compiler));

                    UniqueVarList varList = (UniqueVarList)ParentScope.CompileProperties["UseUndeclaredVars"];

                    if (!varList.IsDeclared(Text))
                    {
                        varList.VarAdd(Text);
                        //throw new CompileException(CompileCode.UsedNotAssigned,
                        //                           "Use undeclared variable '{0}'\nAt scope:{1}",
                        //                           Text, ParentScope.ShortTerm);
                    }
                }
            }
        }
    }
}