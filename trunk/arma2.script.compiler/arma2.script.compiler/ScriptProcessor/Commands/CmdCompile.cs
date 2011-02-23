namespace ArmA2.Script.ScriptProcessor.Commands
{
    public class CmdCompile : CmdCommandOne
    {
        protected override void CompileInternal(Compiler compiler)
        {
            base.CompileInternal(compiler);

            if (Arg1 is CmdCommand && ((CmdCommand)Arg1).Text.Equal("format"))
            {
                Logger.Log(LogLevel.Warning, CompileCode.PerfomanceIssue,
                    "Possible performance degradation: {0}", Parent.ToString());
                return;
            }

            if (Arg1 is CmdString)
            {
                var arg1 = (CmdString)Arg1;

                var prevCmd = NextElement<CmdCommand>(-1);
                bool applyPrivate = (prevCmd != null && prevCmd.Text.Equal("call")) ? false : true; // call compile "_myvar=1"  // do not declare local variables for this case

                var contentPartial = arg1.Text.Replace("\"\"", "\"");

                var stateApplyPrivate = compiler.ApplyPrivateVars;
                var stateApplyMinimize = GlobalSettings.ApplyMinimize;
                GlobalSettings.ApplyMinimize = true;

                compiler.ApplyPrivateVars = applyPrivate;
                contentPartial = compiler.CompilePartial(contentPartial, null);

                compiler.ApplyPrivateVars = stateApplyPrivate;
                GlobalSettings.ApplyMinimize = stateApplyMinimize;

                arg1.Text = contentPartial.Replace("\"", "\"\"");
            }
        }
    }
}