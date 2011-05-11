using System;
using System.Collections.Generic;
using System.Reflection;
using Script.Compiler.Core.ScriptWriter;

namespace Script.Compiler.Core.ScriptModel
{
    public interface IScriptClass
    {
        string Name { get; }
        Type Type { get; }
        List<IScriptMethod> Methods { get; }
        IScriptCompiler Compiler { get; }
        List<IFieldVariable> Fields { get; }
        IScriptMethod GetScriptMethod(MethodBase methodBase);
        void Render(IScriptWriter writer);
    }
}