namespace ArmA2.Script.ScriptProcessor
{
    public class CmdVariable : CmdText
    {
        public bool IsLocal
        {
            get { return (string.IsNullOrEmpty(Text)) ? false : Text.StartsWith("_"); }
        }

        protected override void CompileInternal(Compiler compiler)
        {
            base.CompileInternal(compiler);

            if (IsLocal)
            {
                if (!Scope.LocalVars.IsDeclared(Text) && compiler.Settings.ApplyPrivateVars)
                {
                    if (Scope.IsDeclaredInOuterScope(Text))
                    {
                        return;
                        //throw new CompileException(CompileCode.OutOfScopeDeclaration,
                        //           "Variable '{0}' declared at outer scope, possible errors.\nAt scope:{1}",
                        //           Text, Scope.ShortTerm);
                    }

                    if (!Scope.CompileProperties.ContainsKey("UndeclaredVars"))
                        Scope.CompileProperties.Add("UndeclaredVars", new UniqueVarList());

                    UniqueVarList varList = (UniqueVarList)Scope.CompileProperties["UndeclaredVars"];

                    if (!varList.IsDeclared(Text))
                    {
                        varList.VarAdd(Text);
                        throw new CompileException(CompileCode.UseUndeclaredVariable,
                                                   "Use undeclared variable '{0}'\nAt scope:{1}",
                                                   Text, Scope.ShortTerm);
                    }
                }
            }
        }
    }
}