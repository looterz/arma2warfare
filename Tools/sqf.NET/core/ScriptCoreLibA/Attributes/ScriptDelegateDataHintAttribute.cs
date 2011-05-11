using System;

namespace ScriptCoreLib.Attributes
{
    ///<summary>
    ///</summary>
    [global::System.AttributeUsage(AttributeTargets.Field, Inherited = false, AllowMultiple = false)]
    public sealed class ScriptDelegateDataHintAttribute : Attribute
    {
        // this class shall be omitted from the future versions of jsc
        // jsc needs to infer this information by itself

        public enum FieldType
        {
            List,
            Target,
            Method
        }

        public readonly FieldType Value;

        public ScriptDelegateDataHintAttribute(FieldType Value)
        {
            this.Value = Value;
        }
    }
}