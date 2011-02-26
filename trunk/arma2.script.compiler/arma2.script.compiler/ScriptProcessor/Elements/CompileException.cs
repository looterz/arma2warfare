using System;

namespace ArmA2.Script.ScriptProcessor
{
    internal class CompileException : Exception
    {
        internal bool Throwable { get; set; }
        internal CompileCode CompileCode { get; private set; }

        internal CompileException(CompileCode code, string text, params object[] args)
            : base((args != null && args.Length > 0) ? string.Format(text, args) : text)
        {
            CompileCode = code;
            Throwable = false;
        }

        internal void WriteToLog()
        {
            Logger.Log(Level, this.CompileCode, Message);
        }

        internal LogLevel Level
        {
            get
            {
                if (CompileCode >= CompileCode.Error)
                    return LogLevel.Error;

                if (CompileCode >= CompileCode.Warning)
                    return LogLevel.Warning;

                return LogLevel.High;
            }
        }
    }
}