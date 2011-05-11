using System;
using System.Collections.Generic;
using System.Diagnostics;
using System.IO;
using System.Linq;
using System.Reflection;
using System.Xml;
using jsc.Languages;
using jsc.Languages.SQF;
using jsc.Loader;
using ScriptCoreLib;
using ScriptCoreLib.CSharp.Extensions;

namespace jsc
{
    public class Program
    {
        public static void Main(string[] args)
        {
            Assembly assembly = Assembly.LoadFrom(args[0]);

            var types = LoadReferencedAssamblies(ScriptType.Sqf, assembly);

            string outputPath = Path.GetDirectoryName(assembly.Location) + "\\sqf";
            if (!Directory.Exists(outputPath))
            {
                Directory.CreateDirectory(outputPath);
            }

            var compiler = new SqfCompiler(outputPath);
            compiler.Compile(types);
        }

        private static Type[] LoadReferencedAssamblies(ScriptType type, Assembly assamblyLoaded)
        {
            List<Type> types = new List<Type>();

            types.AddRange(ScriptAttribute.FindTypes(assamblyLoaded, type));

            foreach (Assembly xa in SharedHelper.LoadReferencedAssemblies(assamblyLoaded, false))
            {
                ScriptAttribute sa = ScriptAttribute.OfProvider(xa);

                if (sa == null)
                {
                    continue;
                }
                types.AddRange(ScriptAttribute.FindTypes(xa, type));
            }
            return types.ToArray();
        }
    }
}