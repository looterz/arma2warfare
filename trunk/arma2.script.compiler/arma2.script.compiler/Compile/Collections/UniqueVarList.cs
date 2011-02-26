using System.Collections.Generic;
using System.Linq;

namespace ArmA2.Script.Compile.Collections
{
    internal class UniqueVarList : List<string>
    {
        private readonly Compiler _compiler;

        internal UniqueVarList(Compiler compiler)
        {
            _compiler = compiler;
        }

        internal bool IsDeclared(string varName)
        {
            bool declared = _compiler.Context.ReservedNameLocalVariable.Any(m => m.Equal(varName));
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