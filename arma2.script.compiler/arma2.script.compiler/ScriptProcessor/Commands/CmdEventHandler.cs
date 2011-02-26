using ArmA2.Script.Compile;
using ArmA2.Script.Compile.Exceptions;
using ArmA2.Script.ScriptProcessor.Commands;

namespace ArmA2.Script.ScriptProcessor
{
    internal class CmdEventHandler : CmdCommandTwo
    {
        #region Методы класса

        protected override void CompileInternal(Compiler compiler)
        {
            base.CompileInternal(compiler);

            // _player addeventhandler ['killed', _eventHandler];
            var arg1 = NextElement<CmdScopeArray>(1);
            if (arg1 == null)
            {
                throw new CompileException(CompileCode.CommandInvalidArgument,
                                           "EventHandler argument must be array\nAt scope:{0}",
                                           ParentScope.ShortTerm);
            }

            if (arg1.Commands.Count < 2)
            {
                throw new CompileException(CompileCode.CommandInvalidArgument,
                                           "EventHandler array must have at least 2 arguments\nAt scope:{0}",
                                           ParentScope.ShortTerm);
            }

            var eventName = arg1.Commands.Get<CmdBase>(0);
            var eventHanlder = arg1.Commands.Get<CmdBase>(1);

            if (!(eventName is CmdString || eventName is CmdVariable))
            {
                throw new CompileException(CompileCode.CommandInvalidArgument,
                                           "EventHandler argument 1 must be string or variable\nAt scope:{0}",
                                           ParentScope.ShortTerm);
            }

            if (!(eventHanlder is CmdString || eventHanlder is CmdVariable || eventHanlder is CmdScopeCode))
            {
                throw new CompileException(CompileCode.CommandInvalidArgument,
                                           "EventHandler argument 1 must be string, variable or code scope\nAt scope:{0}",
                                           ParentScope.ShortTerm);
            }

            if (eventHanlder is CmdString)
            {
                var ehString = (CmdString) eventHanlder;
                var p = new Processor(compiler);

                string contentPartial = ehString.Text.Replace("\"\"", "\"");

                compiler.PushSettings();
                compiler.Settings.ScriptMinimized = true;
                compiler.Settings.UpdatePrivateVars = true;

                contentPartial = compiler.CompilePartial(contentPartial, null);
                compiler.PopSettings();

                CmdGroup partial = p.CompileToByteCode(contentPartial);

                var codeScope = new CmdScopeCode();
                codeScope.Parent = arg1;
                partial.Items.ForEach(m => codeScope.ChildAdd(m));
                codeScope.TopPrivateScope = true;

                int id = arg1.Items.IndexOf(ehString);
                arg1.Items[id] = codeScope;
            }
        }

        #endregion
    }
}