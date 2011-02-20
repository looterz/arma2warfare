using System;
using System.IO;
using System.Text;
using System.Web;
using ArmA2.Script;
using ArmA2.Script.ScriptProcessor;

//using Microsoft.VisualStudio.TestTools.UnitTesting;

namespace ArmA2.Script.UnitTests
{
    class Program
    {
        static void Main(string[] args)
        {
            //string s = HttpUtility.UrlEncode("arestic@mail.ru");

            string[] files = args;
            if (args.Length == 0)
                files = new[] { "aiteam.fsm" };

            foreach (var fileName in files)
            {
                string content = File.ReadAllText(fileName);
                GlobalSettings.ExcludeLines.Add("PROFILER_BEGIN");
                GlobalSettings.ExcludeLines.Add("PROFILER_END");
                GlobalSettings.ExcludeLines.Add(@"profiler.sqf");
                GlobalSettings.ExcludeLines.Add(@"profiler.h");
                GlobalSettings.ExcludeLines.Add(@"!isNil ""initProfiler""");

                GlobalSettings.ExcludeLines.Add(@"call Log(High|Inform|Medium|Warning|Trace)");
                GlobalSettings.ExcludeLines.Add(@"""(?:[^""\\]|\\.|\""\"")*""\s*call Log(High|Inform|Medium|Warning|Trace)");
                GlobalSettings.ExcludeLines.Add(@"'(?:[^'\\]|\\.|'')*'\s*call Log(High|Inform|Medium|Warning|Trace)");
                Compiler obfuscate = new Compiler();
                obfuscate.FileName = fileName;
                obfuscate.HideVars = false;
                obfuscate.FsmContent = (Path.GetExtension(fileName).ToLower() == ".fsm");

                GlobalSettings.AllowMinimize = false;
                GlobalSettings.StringQuote = "\"";
                content = obfuscate.Compile(content);

                string newFileName = Path.GetFileNameWithoutExtension(fileName) + ".a" + Path.GetExtension(fileName);
                File.WriteAllText(newFileName, content);

                Processor processor = new Processor();
                var code = processor.CompileToByteCode(content);
                content = code.ToString();
            }

            Console.ReadKey();
        }
    }
}
