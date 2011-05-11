using System.Linq;
using System.Reflection;

namespace jsc.Languages.SQF
{
    class SqfLocalVariable : ILocalVariable
    {
        public string Name { get; set; }
        public IScriptMethod Method { get; set; }
        public LocalVariableInfo LocalVariable { get; set; }

        public SqfLocalVariable(LocalVariableInfo localVariable, IScriptMethod method)
        {
            Method = method;
            LocalVariable = localVariable;

            string name = "_" + StringTools.GetName(localVariable.LocalIndex);
            Name = name;
            int id = 0;
            while (method.Locals.Any(m => m.Name == Name))
            {
                Name = name + StringTools.GetName(id++);
            }
        }
    }
}