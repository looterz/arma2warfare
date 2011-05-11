using System;

namespace Script.Compiler.Core.Attributes
{
    ///<summary>
    ///</summary>
    [global::System.AttributeUsage(AttributeTargets.Parameter | AttributeTargets.Method | AttributeTargets.Class, Inherited = false, AllowMultiple = false)]
    public sealed class ScriptParameterByValAttribute : Attribute
    {

    }
}