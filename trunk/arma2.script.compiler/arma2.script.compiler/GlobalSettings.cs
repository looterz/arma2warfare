using System.Collections.Generic;
using System.Text.RegularExpressions;

namespace ArmA2.Script
{
    public class GlobalSettings
    {
        //internal static bool ApplyMinimize = true;
        //internal static string StringQuote = "'";

        public static List<Variable> internalVariables = new List<Variable>();
        public static List<string> ExcludePhrases = new List<string>();
        public static List<string> ExcludeLines = new List<string>();
    }
}