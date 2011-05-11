using Script.Compiler.Core.ScriptModel;

namespace Script.Compiler.Languages.SQF
{
    class SqfSysVariable : IScriptVariable
    {
        public string Name { get; private set; }
        public IScriptMethod Method { get; private set; }

        public SqfSysVariable(string name, IScriptMethod method)
        {
            Name = name;
            Method = method;
        }
    }
}