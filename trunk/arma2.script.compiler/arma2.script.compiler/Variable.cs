using System.Text.RegularExpressions;

namespace ArmA2.Script
{
    public class Variable
    {
        public string VarName;
        public string ObfuscateName;
        public int UsageCount = 0;

        internal Regex Regex;

        public override string ToString()
        {
            return string.Format("{0} -> {1}, Usage:{2}", VarName, ObfuscateName, UsageCount);
        }
    }
}