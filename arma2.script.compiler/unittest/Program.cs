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
                files = new[] { "uav_interface.sqf" };

            foreach (var fileName in files)
            {
                string content = File.ReadAllText(fileName);
                GlobalVars.ExcludeLines.Add("PROFILER_BEGIN");
                GlobalVars.ExcludeLines.Add("PROFILER_END");
                GlobalVars.ExcludeLines.Add(@"profiler.sqf");
                GlobalVars.ExcludeLines.Add(@"profiler.h");
                GlobalVars.ExcludeLines.Add(@"!isNil ""initProfiler""");

                GlobalVars.ExcludeLines.Add(@"call Log(High|Inform|Medium|Warning|Trace)");
                GlobalVars.ExcludeLines.Add(@"""(?:[^""\\]|\\.|\""\"")*""\s*call Log(High|Inform|Medium|Warning|Trace)");
                GlobalVars.ExcludeLines.Add(@"'(?:[^'\\]|\\.|'')*'\s*call Log(High|Inform|Medium|Warning|Trace)");
                Compiler obfuscate = new Compiler();
                obfuscate.FileName = fileName;
                obfuscate.HideVars = false;
                obfuscate.FsmContent = (Path.GetExtension(fileName).ToLower() == ".fsm");
                content = obfuscate.Compile(content);

                string newFileName = Path.GetFileNameWithoutExtension(fileName) + ".a" + Path.GetExtension(fileName);
                File.WriteAllText(newFileName, content);

                Processor processor = new Processor();
                processor.CompileToByteCode(content);
            }

            Console.ReadKey();
        }
    }
}
