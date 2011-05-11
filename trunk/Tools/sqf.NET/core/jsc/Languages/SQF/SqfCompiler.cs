using System;
using System.Collections.Generic;
using System.Linq;
using System.Reflection;
using Script.Compiler.Core.ScriptModel;

namespace Script.Compiler.Languages.SQF
{
    class SqfCompiler : IScriptCompiler
    {
        #region Методы класса

        private string _output;
        public List<IScriptClass> Classes { get; private set; }

        public SqfCompiler(string outputFolder)
        {
            _output = outputFolder;
            Classes = new List<IScriptClass>();
        }

        public IScriptClass GetScriptClass(Type type)
        {
            IScriptClass sqfClass = Classes.FirstOrDefault(m => m.Type.Equals(type));
            if (sqfClass == null)
            {
                sqfClass = new SqfClass(type, this);
                Classes.Add(sqfClass);
            }
            return sqfClass;
        }

        public IScriptVariable GetVariable(MethodBase method, LocalVariableInfo varInfo)
        {
            return GetScriptClass(method.DeclaringType)
                .GetScriptMethod(method).Locals.Where(m => m is ILocalVariable).First(m => ((ILocalVariable)m).LocalVariable.LocalIndex == varInfo.LocalIndex);
        }

        public IScriptVariable GetVariable(MethodBase method, ParameterInfo paramInfo)
        {
            var scriptMethod = GetScriptClass(method.DeclaringType).GetScriptMethod(method);

            return scriptMethod.Locals.Where(m => m is IParameterVariable).First(m => ((IParameterVariable)m).ParameterInfo.Name == paramInfo.Name);
        }

        public IFieldVariable GetField(FieldInfo field)
        {
            return GetScriptClass(field.DeclaringType).Fields.First(m => m.FieldInfo.Name == field.Name);            
        }

        public IScriptMethod ResolveMethod(MethodBase sourceMethod, Type targetType, string matchMethodName)
        {
            foreach (IScriptMethod targetMethod in GetScriptClass(targetType).Methods)
            {
                if (targetMethod.Method.Name == (matchMethodName ?? sourceMethod.Name))
                {
                    ParameterInfo[] targetArguments = targetMethod.Method.GetParameters();
                    ParameterInfo[] sourceArguments = sourceMethod.GetParameters();

                    if (targetArguments.Length != sourceArguments.Length)
                        continue;

                    if (sourceMethod.IsConstructor && !targetMethod.Method.IsStatic)
                        continue;

                    if (!sourceMethod.IsConstructor && targetMethod.Method.IsStatic != sourceMethod.IsStatic)
                        continue;

                    int zz = targetArguments.Length;
                    int zf = 0;

                    while (zz-- > 0)
                    {
                        if (targetArguments[zz].ParameterType.Equals(sourceArguments[zz].ParameterType))
                        {
                            zf++;
                        }
                    }

                    if (zf == targetArguments.Length)
                    {
                        return targetMethod;
                    }
                }
            }
            return null;
        }


        public void Compile(Type[] argTypes)
        {
            Type[] types = argTypes;

            types.ForEach(type => GetScriptClass(type));

            foreach(Type type in types)
            {
                IScriptClass sqfClass = GetScriptClass(type);
                using (ScriptWriter writer = new ScriptWriter(_output + "/" + sqfClass.Name + ".sqf"))
                {
                    writer.Ident++;
                    sqfClass.Render(writer);
                    writer.Flush();
                }
            }
            
        }
        #endregion
    }
}