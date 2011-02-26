using System.Collections.Generic;
using System.ComponentModel;
using System.Linq;

namespace ArmA2.Script.ScriptProcessor
{
    internal class CmdElementCollectionBase<T> :List<T>, IScriptRenderer where T : CmdBase
    {
        private int _position = 0;

        internal void SetPosition(int position)
        {
            _position = position;
        }

        internal CmdElementCollectionBase<T1> Select<T1>() where T1 : CmdBase
        {
            var items = new CmdElementCollectionBase<T1>();

            foreach(T item in this)
            {
                if (item is T1)
                    items.Add(((T1)(object)item));
            }

            return items;
        }

        internal T1 Get<T1>(int offset) where T1 : CmdBase
        {
            int pos = _position + offset;
            if (pos >= 0 && pos < this.Count())
            {
                CmdBase item = this[pos];
                if (item is T1) 
                    return (T1)item;
            }
            return null;
        }

        public override string ToString()
        {
            string txt = "";
            this.ForEach(m => txt = txt + m);
            return txt;
        }

        public void Render(ScriptWriter writer)
        {
            foreach (var item in this)
                ((IScriptRenderer)item).Render(writer);
        }
    }
}