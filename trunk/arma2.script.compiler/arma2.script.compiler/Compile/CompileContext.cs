using System.Collections.Generic;

namespace ArmA2.Script.Compile
{
    public class CompileContext
    {
        public List<Variable> PublicVariables = new List<Variable>();
        public List<string> ExcludePhrases = new List<string>();
        public List<string> ExcludeLines = new List<string>();
    }
}