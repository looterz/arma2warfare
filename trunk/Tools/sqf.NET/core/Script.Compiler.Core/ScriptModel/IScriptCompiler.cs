using System;
using System.Collections.Generic;
using System.Reflection;

namespace Script.Compiler.Core.ScriptModel
{
    public interface IScriptCompiler
    {
        List<IScriptClass> Classes { get; }
        IScriptClass GetScriptClass(Type type);
        void Compile(Type[] argTypes);
        IScriptVariable GetVariable(MethodBase method, LocalVariableInfo varInfo);
        IScriptVariable GetVariable(MethodBase method, ParameterInfo paramInfo);
        IScriptMethod ResolveMethod(MethodBase sourceMethod, Type targetType, string matchMethodName);
        IFieldVariable GetField(FieldInfo field);
    }
}