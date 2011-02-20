using System;
using ArmA2.Script.ScriptProcessor.Commands;

namespace ArmA2.Script.ScriptProcessor
{
    public class CmdEventHandler : CmdCommandTwo
    {
        protected override void CompileInternal(Compiler compiler)
        {
            base.CompileInternal(compiler);

            // _player addeventhandler ['killed', _eventHandler];
            var arg1 = NextElement<CmdScopeArray>(1);
            if (arg1 == null)
               throw new CompileException(CompileCode.CommandInvalidArgument,
                                          "EventHandler argument must be array\nAt scope:{0}",
                                          Scope.ShortTerm);

            if (arg1.Commands.Count < 2)
                throw new CompileException(CompileCode.CommandInvalidArgument,
                                           "EventHandler array must have at least 2 arguments\nAt scope:{0}",
                                           Scope.ShortTerm);

            var eventName = arg1.Commands.Get<CmdBase>(0);
            var eventHanlder = arg1.Commands.Get<CmdBase>(1);
            
            if (!(eventName is CmdString || eventName is CmdVariable))
                throw new CompileException(CompileCode.CommandInvalidArgument,
                                           "EventHandler argument 1 must be string or variable\nAt scope:{0}",
                                           Scope.ShortTerm);

            if (!(eventHanlder is CmdString || eventHanlder is CmdVariable || eventHanlder is CmdScopeCode))
                throw new CompileException(CompileCode.CommandInvalidArgument,
                                           "EventHandler argument 1 must be string, variable or code scope\nAt scope:{0}",
                                           Scope.ShortTerm);

            if (eventHanlder is CmdString)
            {
                var ehString = (CmdString) eventHanlder;
                Processor p = new Processor();

                var contentPartial = ehString.Text.Replace("\"\"", "\"");

                var applyPrivate = compiler.ApplyPrivateVars;
                compiler.ApplyPrivateVars = true;
                contentPartial = compiler.CompilePartial(contentPartial);
                compiler.ApplyPrivateVars = applyPrivate;

                var partial = p.CompileToByteCode(contentPartial);

                var codeScope = new CmdScopeCode();
                codeScope.Parent = arg1;
                partial.Items.ForEach(m => codeScope.ChildAdd(m));
                codeScope.ApplyPrivate = true;

                int id = arg1.Items.IndexOf(ehString);
                arg1.Items[id] = codeScope;
            }
        }
    }
}