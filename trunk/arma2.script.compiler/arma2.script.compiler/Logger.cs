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

        public static void Clear()
        {
            Errors.Clear();
            Warnings.Clear();
        }

        public static void Log(LoggingLevel level, string message, params string[] args)
        {
            if (args.Length > 0)
                message = string.Format(message, args);

            if (level == LoggingLevel.Error)
                Errors.Add(message);

            if (level == LoggingLevel.Warning)
                Warnings.Add(message);

            if (level >= Level)
                Console.WriteLine("{0}: {1}", level, message);
        }
    }
}