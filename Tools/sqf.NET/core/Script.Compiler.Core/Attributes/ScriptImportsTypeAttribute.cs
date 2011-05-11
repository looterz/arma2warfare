﻿using System;

namespace Script.Compiler.Core.Attributes
{
    /// <summary>
    /// Defines an external type to be imported with current class definition. To be used with native source code injection.
    /// </summary>
    [global::System.AttributeUsage(AttributeTargets.Class, Inherited = false, AllowMultiple = true)]
    public sealed class ScriptImportsTypeAttribute : Attribute
    {
        public string Name;

        public ScriptImportsTypeAttribute(string Name)
        {
            this.Name = Name;
        }
    }
}
