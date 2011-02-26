using System.Collections.Generic;
using System.Linq;
using ArmA2.Script.ScriptProcessor;

namespace ArmA2.Script.Compile.Collections
{
    internal class NamedList<T> : List<T> where T : INamedItem
    {
        internal T this[string name]
        {
            get { return this.FirstOrDefault(m => m.GetName().Equal(name)); }
        }
    }
}