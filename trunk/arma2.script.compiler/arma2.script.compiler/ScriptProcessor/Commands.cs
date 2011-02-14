using System;
using System.Collections.Generic;
using System.IO;
using System.Linq;

namespace ArmA2.Script.ScriptProcessor
{
    public delegate void CompileHandler(CmdCommand cmd, Compiler compiler);
    public delegate void ExecuteHandler(CmdCommand cmd, Compiler compiler);
    public delegate void ValidateHandler(CmdCommand cmd, List<string> validate);

    public class Function
    {
        public string Name;
        public CompileHandler OnCompile;
        public ExecuteHandler OnExecute;
        public ValidateHandler OnValidate;
    }

    public partial class Processor
    {
        private static void PVEventHandler(CmdCommand cmd, Compiler compiler)
        {
        }

        private static void CompileCommand(CmdCommand cmd, Compiler compiler)
        {
            var root = (CmdElement)cmd.Parent;
            var data = root.Commands;
            var opPos = data.IndexOf(cmd);

            var cmd1 = data.Get<CmdCommand>(opPos - 1);
            bool declarePrivate = (cmd1 != null && cmd1.Text.Equal("call")) ? false : true;

            var arg1 = data.Get<CmdBase>(opPos + 1); 
            if (arg1 == null)
            {
                Logger.Log(LogLevel.Error, "Argument for compile command is not exists: {0}", cmd.Parent.ToString());
                return;
            }

            if (arg1 is CmdCommand && ((CmdCommand)arg1).Text.Equal("format"))
            {
                Logger.Log(LogLevel.Inform, "Possible performance degradation: {0}", cmd.Parent.ToString());
                return;
            }

            if (arg1 is CmdString)
            {
                var sarg1 = (CmdString) arg1;

                Processor p = new Processor();
                var contentPartial = sarg1.Text.Replace("\"\"", "\"");

                bool stateDeclarePrivateVars = compiler.DeclarePrivateVars;
                    compiler.DeclarePrivateVars = declarePrivate;
                    contentPartial = compiler.CompilePartial(contentPartial);
                    compiler.DeclarePrivateVars = stateDeclarePrivateVars;

                sarg1.Text = contentPartial.Replace("\"", "\"\"");
            }

        }

        private static void EventHandler(CmdCommand cmd, Compiler compiler)
        {
            // _player addeventhandler ['killed', _eventHandler];

            var root = (CmdElement) cmd.Parent;
            var data = root.Commands;
            var opPos = data.IndexOf(cmd);

            var arg1 = data.Get<CmdScopeArray>(opPos + 1);
            if (arg1.Commands.Count < 2)
                Logger.Log(LogLevel.Error, "Error: Event Handler is not defined - {0}", cmd.ToString());

            var strEventHanlder = arg1.Commands.Get<CmdString>(1);
            if (strEventHanlder != null)
            {
                var ehString = (CmdString)arg1.Commands[1];
                Processor p = new Processor();

                var contentPartial = ehString.Text.Replace("\"\"", "\"");
                contentPartial = compiler.CleanupContent(contentPartial);
                var partial = p.CompileToByteCode(contentPartial);
                compiler.DeclareVariables(partial);

                var codeScope = new CmdScopeCode();
                codeScope.ChildAdd(partial);
                codeScope.Parent = arg1;

                int id = arg1.Items.IndexOf(ehString);
                arg1.Items[id] = codeScope;
            }
        }

    }
}