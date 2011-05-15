using System;
using System.Collections.Generic;
using System.IO;
using System.Linq;
using Arma2.Script.Compiler.Sqf;
using Reflector;
using Reflector.CodeModel;
using SqfCompiler;

namespace Arma2.Compiler
{
    class Program
    {
        static void Main(string[] args)
        {
            string outputFolder = Environment.CurrentDirectory + "\\" + Path.GetFileNameWithoutExtension(args[0]);
            if (!Directory.Exists(outputFolder))
                Directory.CreateDirectory(outputFolder);

            CompileSqf(args[0], outputFolder);
        }

        private static string[] ignoredAssemblies = {"Reflector", "mscorlib", "System.", "Microsoft."};

        private static ITypeDeclaration[] AssemblyLoad(IAssemblyManager assemblyManager, ITranslator translator, string location)
        {
            IAssembly assembly1 = assemblyManager.LoadFile(location);
            IAssembly assembly = translator.TranslateAssembly(assembly1, true);

            List<ITypeDeclaration> types = new List<ITypeDeclaration>();

            foreach (IModule module1 in assembly.Modules)
            {
                var module = translator.TranslateModule(module1, true);
                types.AddRange(module.Types.Cast<ITypeDeclaration>());

                module.AssemblyReferences.Cast<IAssemblyReference>().
                    ForEach(assemlyRef =>
                    {
                        if (ignoredAssemblies.Any(ignoreName => assemlyRef.Name.StartsWith(ignoreName)) == false)
                        {
                            types.AddRange(AssemblyLoad(assemblyManager, translator, assemlyRef.Resolve().Location));
                        }
                    });
            }
            return types.ToArray();
        }

        private static void CompileSqf(string assemblyPath, string outputFolder)
        {
            var serviceProvider = new ApplicationManager(null);
            var assemblyManager = (IAssemblyManager) serviceProvider.GetService(typeof (IAssemblyManager));
            var languageManager = (ILanguageManager) serviceProvider.GetService(typeof (ILanguageManager));
            var translatorManager = (ITranslatorManager) serviceProvider.GetService(typeof (ITranslatorManager));
            var visibilityConfiguration = (IVisibilityConfiguration) serviceProvider.GetService(typeof (IVisibilityConfiguration));

            assemblyManager.Resolver = new AssemblyResolver(assemblyManager);

            ILanguageWriterConfiguration languageConfiguration = ConfigureLangugaeConfiguration(visibilityConfiguration);
            assemblyManager.Resolver = new AssemblyResolver(assemblyManager);

            var translator = translatorManager.CreateDisassembler("true", "");
            ILanguage language = new SqfLanguage();
            var assembly = assemblyManager.LoadFile(assemblyPath);
            var assemblyScript = assemblyManager.LoadFile("Arma2.Script.dll");

            //assembly = assembly.Resolve();
            foreach (IModule module in assembly.Modules)
            {
                module.AssemblyReferences.Cast<IAssemblyReference>().
                    ForEach(m => assemblyManager.LoadFile(m.Resolve().Location));

                //var module = module1.Resolve();
                foreach (ITypeDeclaration typeDeclaration1 in module.Types)
                {
                    if (typeDeclaration1.Interface)
                        continue;

                    if (typeDeclaration1.Name.Contains("<"))
                        continue;

                    //var typeDeclaration = translator.TranslateTypeDeclaration(typeDeclaration1, true, true);
                    var typeDeclaration = typeDeclaration1.Resolve();

                    using(SqfFormatter formatter = new SqfFormatter(outputFolder + "\\" + 
                        typeDeclaration.Namespace + "." + typeDeclaration.Name + ".sqf"))
                    {
                        ILanguageWriter writer = language.GetWriter(formatter, languageConfiguration);
                        var methods = typeDeclaration.Methods.Cast<IMethodDeclaration>()
                            .Where(m => !Helper.GetMethodName(m).Contains("<"))
                            .OrderBy(m => Helper.GetMethodName(m))
                            .OrderBy(m => !Helper.IsConstructor(m));

                        foreach (IMethodDeclaration methodDeclaration in methods)
                        {
                            var methodDeclaration1 = translator.TranslateMethodDeclaration(methodDeclaration);
                            writer.WriteMethodDeclaration(methodDeclaration1.Resolve());
                            formatter.WriteLine();
                        }

                        typeDeclaration.Fields.Cast<IFieldDeclaration>().Where(m => m.Static)
                            .ForEach(field =>
                            {
                                if (Helper.GetFieldName(field).Contains("$") == false)
                                {
                                    writer.WriteFieldDeclaration(field);
                                    formatter.WriteLine();
                                }
                            });                    
                    }
                }
            }
            assemblyManager.Unload(assembly); 

        }

        private static ILanguageWriterConfiguration ConfigureLangugaeConfiguration(IVisibilityConfiguration visibilityConfiguration)
        {
            LanguageWriterConfiguration configuration = new LanguageWriterConfiguration(visibilityConfiguration);
            configuration["ShowCustomAttributes"] = "false";
            configuration["ShowDocumentation"] = "true";
            configuration["ShowMethodDeclarationBody"] = "true";
            configuration["ShowNamespaceImports"] = "true";
            configuration["ShowTypeDeclarationBody"] = "true";
            configuration["NumberFormat"] = "Decimal";

            return configuration;
        }
    }
}
