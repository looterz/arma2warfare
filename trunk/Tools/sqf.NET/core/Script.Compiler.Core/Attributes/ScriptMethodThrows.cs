using System;
using System.Reflection;

namespace Script.Compiler.Core.Attributes
{
    [global::System.AttributeUsage(AttributeTargets.Method, Inherited = false, AllowMultiple = false)]
    public sealed class ScriptMethodThrows : Attribute
    {
        public Type ThrowType;

        public ScriptMethodThrows(Type e)
        {
            ThrowType = e;
        }

        public static ScriptMethodThrows[] ArrayOfProvider(ICustomAttributeProvider m)
        {
            try
            {
                ScriptMethodThrows[] s = m.GetCustomAttributes(typeof(ScriptMethodThrows), false) as ScriptMethodThrows[];

                return s;
            }
            catch (Exception exc)
            {
                throw exc;
            }
        }
    }
}