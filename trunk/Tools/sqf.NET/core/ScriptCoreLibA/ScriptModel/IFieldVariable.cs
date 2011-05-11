using System.Reflection;

namespace Script.Compiler.Core.ScriptModel
{
    public interface IFieldVariable
    {
        string Name { get; }
        IScriptClass Class { get; }
        FieldInfo FieldInfo { get; }
    }
}