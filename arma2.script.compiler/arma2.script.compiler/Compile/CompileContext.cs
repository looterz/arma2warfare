using System.Collections.Generic;
using System.Text.RegularExpressions;

namespace ArmA2.Script
{
    public class CompileContext
    {
        public List<Variable> PublicVariables = new List<Variable>();
        public List<string> ExcludePhrases = new List<string>();
        public List<string> ExcludeLines = new List<string>();
    }
}