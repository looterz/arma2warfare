using System.Reflection;

namespace jsc.Languages.SQF
{
    public interface IParameterVariable : IScriptVariable
    {
        ParameterInfo ParameterInfo { get; }
    }
}