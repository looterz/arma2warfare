﻿using System;

namespace Script.Compiler.Core.Attributes
{
    /// <summary>
    /// While running under different virtual machine this 
    /// attribute instructs to switch runtimes.
    /// 
    /// At the moment this would be possible from JVM to CLR.
    ///
    /// Extension: Later this could be used 
    /// to switch from JavaScript to Silverlight.
    /// </summary>
    [AttributeUsage(AttributeTargets.Class, Inherited = false, AllowMultiple = false)]
    public sealed class SwitchToCLRContextAttribute : Attribute
    {
      
    }

  
}