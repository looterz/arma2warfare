using System.Collections.Generic;
using System.Reflection;

namespace jsc.Languages.SQF
{
    public interface IScriptMethod
    {
        MethodBase Method { get; set; }
        string Name { get; }
        IScriptClass Class { get; }
        List<IScriptVariable> Locals { get; }
        void Render(ScriptWriter writer);
        ILocalVariable GetVariable(LocalVariableInfo localVariableInfo);
        IParameterVariable GetVariable(ParameterInfo parameterInfo);
    }
}