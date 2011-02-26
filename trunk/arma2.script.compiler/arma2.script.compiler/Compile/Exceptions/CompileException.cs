using System;

namespace ArmA2.Script.Compile.Exceptions
{
    internal class CompileException : Exception
    {
        #region Свойства класса

        internal bool Throwable { get; set; }
        internal CState CState { get; private set; }

        internal LogLevel Level
        {
            get
            {
                if (CState >= CState.Error)
                {
                    return LogLevel.Error;
                }

                if (CState >= CState.Warning)
                {
                    return LogLevel.Warning;
                }

                return LogLevel.High;
            }
        }

        #endregion

        #region Конструкторы класса

        internal CompileException(CState code, string text, params object[] args)
            : base((args != null && args.Length > 0) ? string.Format(text, args) : text)
        {
            CState = code;
            Throwable = false;
        }

        #endregion

        #region Методы класса

        internal void WriteToLog()
        {
            Logger.Log(Level, CState, Message);
        }

        #endregion
    }
}