using System;
using System.Collections.Generic;
using System.IO;
using System.Linq;

namespace ArmA2.Script.ScriptProcessor
{
    public delegate void CompileHandler(CmdCommand cmd, Compiler compiler);
    public delegate void ExecuteHandler(CmdCommand cmd, Compiler compiler);

    public class Function
    {
        public string Name;
        public CompileHandler OnCompile;
        public ExecuteHandler OnExecute;
    }

    public partial class Processor
    {
        private static void PVEventHandler(CmdCommand cmd, Compiler compiler)
        {
        }

        private static void EventHandler(CmdCommand cmd, Compiler compiler)
        {
            // _player addeventhandler ['killed', _eventHandler];

            var root = (CmdElement) cmd.Parent;
            var data = root.Data;
            var opPos = data.IndexOf(cmd);

            var arg2 = data.Get<CmdScopeArray>(opPos + 1);
            if (arg2.Data.Count < 2)
                Logger.Log(LogLevel.Error, "Error: Event Handler is not defined - {0}", cmd.ToString());

            var strEventHanlder = arg2.Data.Get<CmdString>(1);
            if (strEventHanlder != null)
            {
                var ehString = (CmdString)arg2.Data[1];
                Processor p = new Processor();

                var contentPartial = ehString.Text.Replace("\"\"", "\"");
                contentPartial = compiler.CompilePartial(contentPartial);
                var partial = p.CompileToByteCode("{" + contentPartial + "}").Items.Get<CmdScopeCode>(0);

                int id = arg2.Items.IndexOf(ehString);
                arg2.Items[id] = partial;
            }
        }

    }
}