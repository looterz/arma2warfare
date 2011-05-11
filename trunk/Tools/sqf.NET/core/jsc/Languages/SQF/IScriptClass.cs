using System;
using System.Collections.Generic;
using System.Reflection;

namespace jsc.Languages.SQF
{
    public interface IScriptClass
    {
        string Name { get; }
        Type Type { get; }
        List<IScriptMethod> Methods { get; }
        IScriptCompiler Compiler { get; }
        List<IFieldVariable> Fields { get; }
        IScriptMethod GetScriptMethod(MethodBase methodBase);
        void Render(ScriptWriter writer);
    }
}