using System.Collections.Generic;
using System.Linq;

namespace ArmA2.Script.ScriptProcessor
{
    public class UniqueVarList : List<string>
    {
        public bool IsDeclared(string varName)
        {
            bool declared = Compiler.ReservedLocalVarNames.Any(m => StringExtension.Equal(m, varName));
            return (declared || this.Any(m => m.Equal(varName)));
        }

        public void VarAdd(string varName)
        {
            if (!IsDeclared(varName))
            {
                Add(varName);
            }
        }
    }
}