using System;

namespace ScriptCoreLib.Attributes
{
    /// <summary>
    /// allows the compiler to detect wether it is out of date. If this value is higher than the one from the compiler the compile proccess fill halt with an error.
    /// </summary>
    [Obsolete]
    [global::System.AttributeUsage(AttributeTargets.Assembly, Inherited = false, AllowMultiple = false)]
    public sealed class ScriptVersionAttribute : Attribute
    {
        public int Value;

        public ScriptVersionAttribute(int e)
        {
            this.Value = e;
        }

    }
}
