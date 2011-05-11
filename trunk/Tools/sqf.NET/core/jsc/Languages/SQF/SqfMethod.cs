using System;
using System.Collections.Generic;
using System.Linq;
using System.Reflection;
using jsc.Languages.SQF.ScriptBuilder;

namespace jsc.Languages.SQF
{
    class SqfMethod : IScriptMethod
    {
        public MethodBase Method { get; set; }
        public string Name { get; private set; }
        public IScriptClass Class { get; private set; }

        public List<IScriptVariable> Locals { get; private set; }

        public SqfMethod(MethodBase method, IScriptClass sqfClass)
        {
            Locals = new List<IScriptVariable>();

            Class = sqfClass;
            Method = method;
            SetTypeName();

            Locals.Add(new SqfSysVariable("_this", this));
            Method.GetParameters().ForEach(local => Locals.Add(new SqfParameterVariable(local, this)));

            var methodBody = Method.GetMethodBody();
            if (methodBody != null)
            {
                methodBody.LocalVariables.ForEach(local => Locals.Add(new SqfLocalVariable(local, this)));
            }
        }

        public ILocalVariable GetVariable(LocalVariableInfo localVariableInfo)
        {
            return (ILocalVariable) Locals.Where(m => m is ILocalVariable).First(m => ((ILocalVariable) m).LocalVariable.LocalIndex == localVariableInfo.LocalIndex);
        }

        public IParameterVariable GetVariable(ParameterInfo parameterInfo)
        {
            return (IParameterVariable)Locals.Where(m => m is IParameterVariable).First(m => ((IParameterVariable)m).ParameterInfo.Name == parameterInfo.Name);
        }

        public void SetTypeName()
        {
            string name = Method.Name.Replace(".", "");

            name = name.Replace("_", "");

            name = char.ToUpper(name[0]) + name.Substring(1);
            if (name == "Ctor")
            {
                name = Class.Name + "Create";
            }
            else
            {
                name = Class.Name + name;
            }

            Name = name;
            int id = 0;
            while (Class.Methods.Any(m => m.Name == Name))
            {
                Name = name + StringTools.GetName(id++).ToUpper();
            }
        }

        public void Render(ScriptWriter writer)
        {
            writer.WriteLine("/// <summary>");
            writer.WriteLine("/// {0}.{1}({2})", (Class.Type.FullName), Method.Name, GetArguments());
            writer.WriteLine("/// </summary>");
            writer.Write("{0} = ", Name);
            using(writer.Scope("{", "};"))
            {
                using (var scope = writer.GetScopeWriter())
                {
                    RenderArguments(scope);

                    RenderPrivateVariables(writer);
                    scope.Commit();
                }

                RenderMethodCode(writer);
            }
            writer.WriteLine();
        }

        public SqfMethodBodyWriter GetBodyWriter(ScriptWriter writer)
        {
            return new SqfMethodBodyWriter(Class.Compiler, writer);
        }

        public virtual void RenderMethodCode(ScriptWriter writer)
        {
            GetBodyWriter(writer).EmitBody(Method, false);
        }

        private string GetArguments()
        {
            string args = "";
            int id = 0;
            Method.GetParameters().ForEach(m =>
            {
                if (id != 0)
                    args = args + ", ";

                args = args + string.Format("{0} {1}", m.ParameterType.Name, m.Name);
                id++;
            });
            return args;
        }

        public static string[] IgnoredLocalNames = {"_this"};

        public void RenderPrivateVariables(ScriptWriter writer)
        {
            if (Locals.Count() > 0)
            {
                using (var scopeWriter = writer.GetScopeWriter())
                {
                    int id = 0;
                    scopeWriter.Write("Private[");
                    for (int i = 0; i < Locals.Count; i++)
                    {
                        if (IgnoredLocalNames.Any(ignoredName => ignoredName == Locals[i].Name) == false)
                        {
                            if (id != 0)
                            scopeWriter.Write(", ");

                            scopeWriter.Write("\"{0}\"", Locals[i].Name);
                            id++;
                        }
                    }
                    scopeWriter.WriteLine("];");

                    if (id > 0)
                        scopeWriter.Commit();
                }
            }
        }

        public void RenderArguments(ScriptWriter writer)
        {
            string dataName = "_this";

            var paramList = Method.GetParameters();
            if (Method.IsConstructor || Method.IsStatic)
            {
                RenderArguments(writer, "_this");
            }
            else
            {
                if (paramList.Length > 0)
                {
                    writer.WriteLine("_args = _this select 1;");
                    Locals.Add(new SqfSysVariable("_args", this));

                    RenderArguments(writer, "_args");
                    writer.WriteLine("_this = _this select 0;");
                }
            }
        }

        private void RenderArguments(ScriptWriter writer, string dataName)
        {
            int id = 0;
            Locals.Where(m => m is IParameterVariable).ForEach(param => 
                writer.WriteLine("{0} = {1} select {2};", param.Name, dataName, id++));
        }
    }
}