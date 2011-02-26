using System;
using ArmA2.Script.Compile;
using ArmA2.Script.Compile.Commands.Common;
using ArmA2.Script.Compile.Exceptions;
using ArmA2.Script.ScriptProcessor.Commands;

namespace ArmA2.Script.ScriptProcessor
{
    internal class CmdEventHandlerPV : CmdCommandTwo
    {
        protected override void CompileInternal(Compiler compiler)
        {
            base.CompileInternal(compiler);

            // "NETSEND_BROADCAST" addinternalVariableEventHandler {(_this select 1) spawn NetSend_HandleMessage; };
            if ((Arg1 is CmdString || Arg1 is CmdScopeCode) == false)
            throw new CompileException(CState.CommandInvalidArgument,
                                       "arg2 EventHandler argument must be scope array or string\nAt scope:{0}",
                                       ParentScope.ShortTerm);

            if (Arg1 is CmdString)
            {
                var ehString = (CmdString) Arg1;
                Parser p = new Parser(compiler);

                var contentPartial = ehString.Text.Replace("\"\"", "\"");

                compiler.PushSettings();

                    compiler.Settings.UpdatePrivateVars = true;
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