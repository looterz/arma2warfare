using System;
using System.Collections.Generic;
using System.IO;
using System.Linq;
using ArmA2.Script.ScriptProcessor.Elements;

namespace ArmA2.Script.ScriptProcessor
{
    public class Function
    {
        public string Name;

        public Type Command;
        public CmdCommand GetCmdCompile()
        {
            if (Command != null)
            {
                return (CmdCommand)Command.GetConstructor(new Type[0]).Invoke(new object[0]);
            }
            return null;
        }
    }

    public partial class Processor
    {
        private static void PVEventHandler(CmdCommand cmd, Compiler compiler)
        {
        }
    }
}