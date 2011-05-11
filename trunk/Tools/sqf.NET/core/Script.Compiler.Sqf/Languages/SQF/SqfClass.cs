using System;
using System.Collections.Generic;
using System.Linq;
using System.Reflection;
using Script.Compiler.Core.ExtensionMethods;
using Script.Compiler.Core.ScriptModel;
using Script.Compiler.Core.ScriptWriter;
using Script.Compiler.Languages.SQF.ScriptBuilder;

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
                .Where(method => method.DeclaringType.Equals(type))
                .ForEach(ctor => Methods.Add(new SqfMethod(ctor, this)));

            Type.GetFields(BindingFlags.NonPublic | BindingFlags.Public | BindingFlags.Static | BindingFlags.Instance)
                .Where(field => field.DeclaringType.Equals(type))
                .ForEach(field => Fields.Add(new SqfFieldVariable(field, this)));
        }

        public IScriptMethod GetScriptMethod(MethodBase methodBase)
        {
            var method = Methods.FirstOrDefault(m => m.Method.EqualsSignature(methodBase));
            if (method == null && Type.BaseType != null)
            {
                method = Compiler.GetScriptClass(Type.BaseType).GetScriptMethod(methodBase);
            }

            if (method == null)
                throw new MissingMethodException(this.Type.FullName, methodBase.Name);

            return method;
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
            var staticFields = Fields.Where(m => m.FieldInfo.IsStatic);

            if (staticFields.Count() > 0)
            {
                writer.WriteLine("///<summary>");
                writer.WriteLine("/// Static Fields Declaration");
                writer.WriteLine("///<summary>");
                Fields.Where(m => m.FieldInfo.IsStatic).ForEach(staticField =>
                {
                    var value = staticField.FieldInfo.GetValue(null);
                    if (value != null && value is string)
                    {
                        writer.WriteLine("{0} = \"{1}\";", staticField.Name, value);
                    }
                    else
                    {
                        if (value == null)
                            value = "objNull";

                        writer.WriteLine("{0} = {1};", staticField.Name, value);
                    }
                });
                writer.WriteLine("");
            }

            Methods.ForEach(methods => methods.Render(writer));
        }
    }
}