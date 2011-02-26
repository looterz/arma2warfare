using System.Collections.Generic;
using ArmA2.Script.Utility;

namespace ArmA2.Script.Compile
{
    public class CompileContext
    {
        public List<Variable> PublicVariables = new List<Variable>();
        public StringCollection ExcludePhrases = new StringCollection();
        public StringCollection ExcludeLines = new StringCollection();

        public StringCollection ReservedLocalVarNames = new StringCollection();
        public char[] AllowedVarChars;

        public CompileContext()
        {
            ReservedLocalVarNames.AddRange(new[]{ "_this", "_x" });
            AllowedVarChars = "abcdefghijklmnopqrstuvwxyz".ToCharArray();
        }
    }
}