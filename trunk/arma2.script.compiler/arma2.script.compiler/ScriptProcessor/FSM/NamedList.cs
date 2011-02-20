using System.Collections.Generic;
using System.Linq;

namespace ArmA2.Script.ScriptProcessor
{
    public class NamedList<T> : List<T> where T : INamedItem
    {
        public T this[string name]
        {
            get { return this.FirstOrDefault(m => m.GetName().Equal(name)); }
        }
    }
}