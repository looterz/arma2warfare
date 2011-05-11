using System;
using System.Collections.Generic;
using System.Linq;
using System.Reflection;
using Script.Compiler.Core.ScriptModel;
using Script.Compiler.Core.ScriptWriter;

namespace Script.Compiler.Languages.SQF
{
    class SqfClass : IScriptClass
    {
        public string Name { get; private set; }

        public Type Type { get; private set; }
        public IScriptCompiler Compiler { get; private set; }

        public List<IScriptMethod> Methods { get; private set; }
        public List<IFieldVariable> Fields { get; private set; }

        public SqfClass(Type type, SqfCompiler compiler)
        {
            Type = type;
            Compiler = compiler;
            Methods = new List<IScriptMethod>();
            Fields = new List<IFieldVariable>();

            SetTypeName();
            Type.GetConstructors(BindingFlags.NonPublic | BindingFlags.Public | BindingFlags.Static | BindingFlags.Instance )
                .ForEach(ctor => Methods.Add(new SqfConstructor(ctor, this)));

            Type.GetMethods(BindingFlags.NonPublic | BindingFlags.Public | BindingFlags.Static | BindingFlags.Instance)
                .ForEach(ctor => Methods.Add(new SqfMethod(ctor, this)));

            Type.GetFields(BindingFlags.NonPublic | BindingFlags.Public | BindingFlags.Static | BindingFlags.Instance)
                .ForEach(m => Fields.Add(new SqfFieldVariable(m, this)));
        }

        public IScriptMethod GetScriptMethod(MethodBase methodBase)
        {
            return Methods.First(m => m.Method.Equals(methodBase));
        }

        public void SetTypeName()
        {
            string[] names = Type.Namespace.Split('.');
            string str = string.Empty;
            names.ForEach(m =>
            {
                str = str + m;
            });

            string typeName = Type.Name;
            if (this.Type.IsGenericType && this.Type.IsGenericTypeDefinition)
            {
                typeName = Type.Name.Substring(0, this.Type.Name.IndexOf("`"));
                typeName = "T" + typeName;
            }

            string name = str + "_" + typeName;
            Name = name;
            int id = 0;
            while (Compiler.Classes.Any(m => m.Name == Name))
            {
                Name = name + StringTools.GetName(id++);
            }
        }

        public void Render(IScriptWriter writer)
        {
            Methods.ForEach(methods => methods.Render(writer));
        }
    }
}