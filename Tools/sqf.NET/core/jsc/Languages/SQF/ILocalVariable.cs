using System.Reflection;

namespace jsc.Languages.SQF
{
    public interface ILocalVariable : IScriptVariable
    {
        LocalVariableInfo LocalVariable { get; set; }
    }
}