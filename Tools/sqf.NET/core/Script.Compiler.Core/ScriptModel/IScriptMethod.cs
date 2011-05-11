using System.Collections.Generic;
using System.Reflection;
using Script.Compiler.Core.ScriptWriter;

namespace Script.Compiler.Core.ScriptModel
{
    public interface IScriptMethod
    {
        MethodBase Method { get; set; }
        string Name { get; }
        IScriptClass Class { get; }
        List<IScriptVariable> Locals { get; }
        void Render(IScriptWriter writer);
        ILocalVariable GetVariable(LocalVariableInfo localVariableInfo);
        IParameterVariable GetVariable(ParameterInfo parameterInfo);
    }
}