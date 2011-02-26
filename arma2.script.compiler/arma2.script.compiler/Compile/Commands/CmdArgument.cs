using System;

namespace ArmA2.Script.Compile.Commands
{
    internal class CmdArgument
    {
        internal int Position { get; set; }
        internal virtual Type ParameterType
        {
            get { return null; }
        }
    }

    internal class CmdArgument<T> : CmdArgument
    {
        internal override Type ParameterType
        {
            get { return typeof(T); }
        }
    }
}