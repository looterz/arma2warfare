using System;

namespace ArmA2.Script.Compile.Exceptions
{
    internal class CompileException : Exception
    {
        #region Свойства класса

        internal bool Throwable { get; set; }
        internal CompileCode CompileCode { get; private set; }

        internal LogLevel Level
        {
            get
            {
                if (CompileCode >= CompileCode.Error)
                {
                    return LogLevel.Error;
                }

                if (CompileCode >= CompileCode.Warning)
                {
                    return LogLevel.Warning;
                }

                return LogLevel.High;
            }
        }

        #endregion

        #region Конструкторы класса

        internal CompileException(CompileCode code, string text, params object[] args)
            : base((args != null && args.Length > 0) ? string.Format(text, args) : text)
        {
            CompileCode = code;
            Throwable = false;
        }

        #endregion

        #region Методы класса

        internal void WriteToLog()
        {
            Logger.Log(Level, CompileCode, Message);
        }

        #endregion
    }
}