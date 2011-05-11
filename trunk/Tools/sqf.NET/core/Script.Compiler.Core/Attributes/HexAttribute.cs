using System;

namespace Script.Compiler.Core.Attributes
{
    /// <summary>
    /// Indicates that the integer value assigned to a parameter should be represented
    /// as an hex 
    /// </summary>
    [global::System.AttributeUsage(AttributeTargets.Parameter | AttributeTargets.Field, Inherited = false, AllowMultiple = true)]
    public sealed class HexAttribute : Attribute
    {

    }
}
