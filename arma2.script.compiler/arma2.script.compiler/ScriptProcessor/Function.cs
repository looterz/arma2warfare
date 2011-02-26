using System;
using System.Collections.Generic;
using System.IO;
using System.Linq;
using ArmA2.Script.Compile;
using ArmA2.Script.Compile.Commands.Common;

namespace ArmA2.Script.ScriptProcessor
{
    internal class Function
    {
        internal string Name;

        internal Type Command;
        internal CmdCommand GetCmdCompile()
        {
            if (Command != null)
            {
                return (CmdCommand)Command.GetConstructor(new Type[0]).Invoke(new object[0]);
            }
            return null;
        }
    }
}