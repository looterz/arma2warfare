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

            string name = fieldInfo.Name;
            if (fieldInfo.IsStatic)
            {
                name = scriptClass.Name + "_" + name;
            }

            if (name.EndsWith("k__BackingField")) {
                name = name.Replace("k__BackingField", "").Replace("<", "").Replace(">", "");
            }

            if (!fieldInfo.IsStatic && !name.StartsWith("_"))
                name = "_" + name;

            Name = name;
            int id = 0;
            while (Class.Fields.Any(m => m.Name == Name))
            {
                Name = name + StringTools.GetName(id++);
            }
        }
    }
}