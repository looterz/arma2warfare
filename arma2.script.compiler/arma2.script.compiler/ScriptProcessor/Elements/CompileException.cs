using System;

namespace ArmA2.Script.ScriptProcessor
{
    public class CompileException : Exception
    {
        public bool Throwable { get; set; }
        public CompileCode CompileCode { get; private set; }

        public CompileException(CompileCode code, string text, params object[] args)
            : base((args != null && args.Length > 0) ? string.Format(text, args) : text)
        {
            CompileCode = code;
            Throwable = false;
        }

        public void WriteToLog()
        {
            Logger.Log(Level, this.CompileCode, Message);
        }

        public LogLevel Level
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