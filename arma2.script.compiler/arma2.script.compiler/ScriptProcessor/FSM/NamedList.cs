using System.Collections.Generic;
using System.Linq;

namespace ArmA2.Script.ScriptProcessor
{
    internal class NamedList<T> : List<T> where T : INamedItem
    {
        internal T this[string name]
        {
            get { return this.FirstOrDefault(m => m.GetName().Equal(name)); }
        }
    }
}