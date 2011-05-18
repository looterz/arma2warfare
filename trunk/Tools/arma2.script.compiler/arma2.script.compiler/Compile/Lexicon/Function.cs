using System;
using ArmA2.Script.Compile.Commands.Common;

namespace ArmA2.Script.Compile.Lexicon
{
    public class Function
    {
        public string Name;
        public Type Command;

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