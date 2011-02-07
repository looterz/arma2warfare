using System.Collections.Generic;
using System.Text.RegularExpressions;

namespace ArmA2.Script
{
    public class GlobalVars
    {
        public static List<Variable> PublicVariables = new List<Variable>();
        public static List<string> ExcludePhrases = new List<string>();
        public static List<string> ExcludeLines = new List<string>();
    }
}