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
                files = new[] { "GUI_Market.sqf" };

            foreach (var fileName in files)
            {
                string content = File.ReadAllText(fileName);
                Compiler compiler = new Compiler();
                var excluded = compiler.Context.ExcludeLines;

                excluded.Add("PROFILER_BEGIN");
                excluded.Add("PROFILER_END");
                excluded.Add(@"profiler.sqf");
                excluded.Add(@"profiler.h");
                excluded.Add(@"!isNil ""initProfiler""");

                excluded.Add(@"call Log(High|Inform|Medium|Warning|Trace)");
                excluded.Add(@"""(?:[^""\\]|\\.|\""\"")*""\s*call Log(High|Inform|Medium|Warning|Trace)");
                excluded.Add(@"'(?:[^'\\]|\\.|'')*'\s*call Log(High|Inform|Medium|Warning|Trace)");

                compiler.Settings.FileName = fileName;
                compiler.Settings.FsmContent = (Path.GetExtension(fileName).ToLower() == ".fsm");
                compiler.Settings.EnableMinimization = false;
                compiler.Settings.StringQuote = "\"";

                content = compiler.Compile(content);

                string newFileName = Path.GetFileNameWithoutExtension(fileName) + ".a" + Path.GetExtension(fileName);
                File.WriteAllText(newFileName, content);
            }

            Console.ReadKey();
        }
    }
}
