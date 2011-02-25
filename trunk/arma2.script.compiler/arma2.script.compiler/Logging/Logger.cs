using System;
using System.Collections.Generic;
using System.Linq;

namespace ArmA2.Script
{
    public class Logger
    {
        public static LogLevel Level = LogLevel.High;

        public static List<int> WarningDisabled = new List<int>();

        public static List<string> Warnings = new List<string>();
        public static List<string> Errors = new List<string>();

        private static string _padding = "";

        public static void IncPadding()
        {
            _padding = _padding + "    ";
        }

        public static void DecPadding()
        {
            if (_padding.Length >= 4)
            _padding = _padding.Remove(_padding.Length - 4);
        }

        public static void ResetError()
        {
            Errors.Clear();
            Warnings.Clear();
        }

        public static void Log(LogLevel level, string message, params object[] args)
        {
            Log(level, CompileCode.None, message, args);
        }

        public static void Log(LogLevel level, CompileCode compileCode, string message, params object[] args)
        {
            if (level == LogLevel.Warning && WarningDisabled.Any(m => m == (int)compileCode))
                return;
            
            if (args.Length > 0)
                message = string.Format(message, args);

            message = _padding + message;

            if (level >= LogLevel.Trace)
            {
                if (compileCode == CompileCode.None)
                    message = string.Format("{0}: {1}", level.ToString().ToUpper(), message);
                else
                {
                    int code = 0;
                    string hint = level.ToString().ToUpper() + "-";
                    if (compileCode >= CompileCode.Error)
                    {
                        code = compileCode - CompileCode.Error;
                        hint = "Error E";
                    }

                    else if (compileCode >= CompileCode.Warning)
                    {
                        code = compileCode - CompileCode.Warning;
                        hint = "Warning W";
                    }

                    message = string.Format("{0}{1:d4}({2}): {3}", hint, code, compileCode, message);
                }
            }

            if (level == LogLevel.Error)
                Errors.Add(message);

            if (level == LogLevel.Warning)
                Warnings.Add(message);

            if (level >= Level)
                Console.WriteLine(message);
        }
    }
}