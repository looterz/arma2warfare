using System;
using System.Collections.Generic;
using System.IO;
using System.Linq;
using System.Text;
using ArmA2.Script.Compile;

namespace ArmA2.Script
{
    [Flags]
    internal enum LogFlag
    {
        LogToFile,
        LogToConsole
    }

    public class Logger
    {
        public static string LogFileName = "arma2.script.compile.log";
        public static bool EnableLogToFile = false;

        private static StreamWriter _fileWriter;
        public static LogLevel Level = LogLevel.High;

        public static List<int> WarningDisabled = new List<int>();

        public static List<string> Warnings = new List<string>();
        public static List<string> Errors = new List<string>();

        private static string _padding = "";

        internal static StreamWriter FileWriter
        {
            get
            {
                if (_fileWriter == null)
                {
                    _fileWriter = new StreamWriter(LogFileName, false, Encoding.UTF8);
                    _fileWriter.AutoFlush = true;
                }
                return _fileWriter;
            }
        }

        public static void Clear()
        {
            if (_fileWriter != null)
            {
                _fileWriter.Dispose();
                _fileWriter = null;
            }
            File.Delete(LogFileName);
        }

        internal static void IncPadding()
        {
            _padding = _padding + "    ";
        }

        internal static void DecPadding()
        {
            if (_padding.Length >= 4)
            _padding = _padding.Remove(_padding.Length - 4);
        }

        public static void ResetError()
        {
            Errors.Clear();
            Warnings.Clear();
        }

        internal static void Log(LogLevel level, LogFlag flag, string message, params object[] args)
        {
            Log(level, CompileCode.None, flag, message, args);
        }

        internal static void Log(LogLevel level, string message, params object[] args)
        {
            Log(level, CompileCode.None, message, args);
        }

        internal static void Log(LogLevel level, CompileCode cstate, string message, params object[] args)
        {
            Log(level, cstate, LogFlag.LogToConsole | LogFlag.LogToFile, message, args);
        }

        internal static void Log(LogLevel level, CompileCode cstate, LogFlag flag, string message, params object[] args)
        {
            if (level == LogLevel.Warning && WarningDisabled.Any(m => m == (int)cstate))
                return;
            
            if (args.Length > 0)
                message = string.Format(message, args);

            message = _padding + message;

            if (level >= LogLevel.Trace)
            {
                if (cstate == CompileCode.None)
                {
                    message = string.Format("{0}", message);
                }
                else
                {
                    string strCode = "";
                    int code = 0;
                    string hint = level.ToString().ToUpper() + "-";
                    if (cstate >= CompileCode.Error)
                    {
                        code = (int)cstate;// -CState.Error;
                        hint = "error";
                        strCode = "CS" + string.Format("{0:D3}", code);
                    }

                    else if (cstate >= CompileCode.Warning)
                    {
                        code = (int)cstate;// -CState.Warning;
                        hint = "warning";
                        strCode = "CS" + string.Format("{0:D3}", code);
                    }

                    message = string.Format("{0} {1}: {2}\n{3}", hint, strCode, cstate, message);
                }
            }

            if (level == LogLevel.Error)
                Errors.Add(message);

            if (level == LogLevel.Warning)
                Warnings.Add(message);

            if (level >= Level)
            {
                if ((flag & LogFlag.LogToConsole) == LogFlag.LogToConsole)
                {
                    Console.WriteLine(message);
                }
                //if (EnableLogToFile && (flag & LogFlag.LogToFile) == LogFlag.LogToFile)
                {
                    FileWriter.WriteLine(message);
                }
            }
        }
    }
}