using System.Reflection;

namespace Script.Compiler.Core.ScriptModel
{
    public interface ILocalVariable : IScriptVariable
    {
        LocalVariableInfo LocalVariable { get; set; }
    }
}