using System;
using ArmA2.Script.ScriptProcessor.Commands;

namespace ArmA2.Script.ScriptProcessor
{
    public class CmdEventHandlerPV : CmdCommandTwo
    {
        protected override void CompileInternal(Compiler compiler)
        {
            base.CompileInternal(compiler);

            // "NETSEND_BROADCAST" addPublicVariableEventHandler {(_this select 1) spawn NetSend_HandleMessage; };
            if ((Arg1 is CmdString || Arg1 is CmdScopeCode) == false)
            throw new CompileException(CompileCode.CommandInvalidArgument,
                                       "arg2 EventHandler argument must be scope array or string\nAt scope:{0}",
                                       Scope.ShortTerm);

            if (Arg1 is CmdString)
            {
                var ehString = (CmdString) Arg1;
                Processor p = new Processor(compiler);

                var contentPartial = ehString.Text.Replace("\"\"", "\"");

                compiler.PushSettings();

                    compiler.Settings.ApplyPrivateVars = true;
                    compiler.Settings.ScriptMinimized = true;

                    contentPartial = compiler.CompilePartial(contentPartial, null);

                compiler.PopSettings();

                var partial = p.CompileToByteCode(contentPartial);

                var codeScope = new CmdScopeCode();
                codeScope.ChildAdd(partial);
                codeScope.Parent = ehString.Parent;

                int id = ehString.Parent.Items.IndexOf(ehString);
                ehString.Parent.Items[id] = codeScope;
            }
        }
    }
}