using System.Reflection;

namespace Script.Compiler.Core.ScriptModel
{
    public interface IParameterVariable : IScriptVariable
    {
        ParameterInfo ParameterInfo { get; }
    }
}