using System.Reflection;

namespace jsc.Languages.SQF
{
    public interface IFieldVariable
    {
        string Name { get; }
        IScriptClass Class { get; }
        FieldInfo FieldInfo { get; }
    }
}