using System;
using System.Collections.Generic;

namespace ArmA2.Script
{
    public enum LoggingLevel
    {
        Inform,
        High,
        Medium,
        Trace,
        Warning,
        Error,
        None
    }
    
    public class Logger
    {
        public static LoggingLevel Level = LoggingLevel.High;

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

        public static void Clear()
        {
            Errors.Clear();
            Warnings.Clear();
        }

        public static void Log(LoggingLevel level, string message, params string[] args)
        {
            if (args.Length > 0)
                message = string.Format(message, args);

            message = _padding + message;

            if (level >= LoggingLevel.Trace)
                message = string.Format("{0}: {1}", level, message); 
            
            if (level == LoggingLevel.Error)
                Errors.Add(message);

            if (level == LoggingLevel.Warning)
                Warnings.Add(message);

            if (level >= Level)
                Console.WriteLine(message);
        }
    }
}