﻿using System;
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
                GlobalSettings.ExcludeLines.Add("PROFILER_BEGIN");
                GlobalSettings.ExcludeLines.Add("PROFILER_END");
                GlobalSettings.ExcludeLines.Add(@"profiler.sqf");
                GlobalSettings.ExcludeLines.Add(@"profiler.h");
                GlobalSettings.ExcludeLines.Add(@"!isNil ""initProfiler""");

                GlobalSettings.ExcludeLines.Add(@"call Log(High|Inform|Medium|Warning|Trace)");
                GlobalSettings.ExcludeLines.Add(@"""(?:[^""\\]|\\.|\""\"")*""\s*call Log(High|Inform|Medium|Warning|Trace)");
                GlobalSettings.ExcludeLines.Add(@"'(?:[^'\\]|\\.|'')*'\s*call Log(High|Inform|Medium|Warning|Trace)");
                Compiler compiler = new Compiler();
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
