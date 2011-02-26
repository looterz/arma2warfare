using System.Collections.Generic;
using System.Linq;

namespace ArmA2.Script.ScriptProcessor
{
    internal class UniqueVarList : List<string>
    {
        internal bool IsDeclared(string varName)
        {
            bool declared = Compiler.ReservedLocalVarNames.Any(m => m.Equal(varName));
            return (declared || this.Any(m => m.Equal(varName)));
        }

        internal void VarAdd(string varName)
        {
            if (!IsDeclared(varName))
            {
                Add(varName);
            }
        }
    }
}