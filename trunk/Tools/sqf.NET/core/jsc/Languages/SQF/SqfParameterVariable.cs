using System;
using System.Linq;
using System.Reflection;
using Script.Compiler.Core.ScriptModel;

namespace Script.Compiler.Languages.SQF
{
    class SqfParameterVariable : IParameterVariable
    {
        public string Name { get; private set; }
        public IScriptMethod Method { get; private set; }
        public ParameterInfo ParameterInfo { get; private set; }

        public SqfParameterVariable(ParameterInfo parameterInfo, IScriptMethod method)
        {
            Method = method;
            ParameterInfo = parameterInfo;

            string name = "_" + parameterInfo.Name;
            Name = name;
            int id = 0;
            while (method.Locals.Any(m => m.Name == Name))
            {
                Name = name + StringTools.GetName(id++);
            }
        }
    }
}