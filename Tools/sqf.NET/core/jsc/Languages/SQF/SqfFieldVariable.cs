using System.Linq;
using System.Reflection;
using Script.Compiler.Core.ScriptModel;

namespace Script.Compiler.Languages.SQF
{
    class SqfFieldVariable : IFieldVariable
    {
        public string Name { get; private set; }
        public IScriptClass Class { get; private set; }
        public FieldInfo FieldInfo { get; private set; }

        public SqfFieldVariable(FieldInfo fieldInfo, IScriptClass scriptClass)
        {
            Class = scriptClass;
            FieldInfo = fieldInfo;

            string name = "_" + fieldInfo.Name;
            Name = name;
            int id = 0;
            while (Class.Fields.Any(m => m.Name == Name))
            {
                Name = name + StringTools.GetName(id++);
            }
        }
    }
}