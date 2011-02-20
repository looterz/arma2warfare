using System;

namespace ArmA2.Script.ScriptProcessor.Elements
{
    public class CmdArgument
    {
        public int Position { get; set; }
        public virtual Type ParameterType
        {
            get { return null; }
        }
    }

    public class CmdArgument<T> : CmdArgument
    {
        public override Type ParameterType
        {
            get { return typeof(T); }
        }
    }
}