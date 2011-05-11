using System;
using System.Collections.Generic;
using System.IO;
using System.Linq;
using System.Reflection;
using System.Text;
using Script.Compiler.Core;
using Script.Compiler.Languages.SQF;
using ScriptCoreLib;

namespace Script.Compiler
{
    class Program
    {
        static void Main(string[] args)
        {
            Assembly assembly = Assembly.LoadFrom(args[0]);

            var types = SharedHelper.LoadScriptTypes(ScriptType.Sqf, assembly);

            string outputPath = Path.GetDirectoryName(assembly.Location) + "\\sqf";
            if (!Directory.Exists(outputPath))
            {
                Directory.CreateDirectory(outputPath);
            }

            var compiler = new SqfCompiler(outputPath);
            compiler.Compile(types);
        }
    }
}
