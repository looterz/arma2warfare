using System.Collections.Generic;
using System.Text.RegularExpressions;

namespace ArmA2.Script
{
    public class GlobalSettings
    {
        public static bool ApplyMinimize = true;
        public static string StringQuote = "'";

        public static List<Variable> PublicVariables = new List<Variable>();
        public static List<string> ExcludePhrases = new List<string>();
        public static List<string> ExcludeLines = new List<string>();
    }
}