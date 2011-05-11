using System;
using System.Runtime.Serialization;

namespace Script.Compiler.Languages.SQF.ScriptBuilder
{
    [Serializable]
    public class SkipThisPrestatementException : Exception
    {
        #region Конструкторы класса

        public SkipThisPrestatementException()
        {
        }

        public SkipThisPrestatementException(string message) : base(message)
        {
        }

        public SkipThisPrestatementException(string message, Exception inner) : base(message, inner)
        {
        }

        protected SkipThisPrestatementException(
            SerializationInfo info,
            StreamingContext context)
            : base(info, context)
        {
        }

        #endregion
    }
}