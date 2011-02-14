using System.IO;

namespace ArmA2.Script.ScriptProcessor
{
    public class CmdBase : IScriptRenderer
    {
        /// <summary>
        /// Скоп которому принадлежит элемент {}, [], ()
        /// </summary>
        public CmdScopeBase Scope
        {
            get
            {
                CmdBase p = Parent;
                while (p != null)
                {
                    if (p is CmdScopeBase)
                        return ((CmdScopeBase)p);
                    p = p.Parent;
                }
                return null;
            }
        }

        public CmdElement Parent { get; set; }
        public virtual void Render(ScriptWriter writer)
        {
        }

        public int IndexId
        {
            get { return (Parent != null) ? Parent.Items.IndexOf(this) : -1; }
        }

        public int CmdId
        {
            get { return (Parent != null) ? Parent.Commands.IndexOf(this) : -1; }
        }

        public CmdBase NextItem(int pos)
        {
            var id = IndexId + pos;
            return (0 <= id && id < Parent.Items.Count) ? Parent.Items[id] : null;
        }

        public CmdBase NextCmd(int pos)
        {
            var id = CmdId + pos;
            return (0 <= id && id < Parent.Commands.Count) ? Parent.Commands[id] : null;
        }

        public override string ToString()
        {
            using(var ms = new MemoryStream())
            {
                var writer = new ScriptWriter(ms);
                writer.AutoFlush = true;
                Render(writer);
                writer.Flush();

                ms.Flush();
                ms.Position = 0;
                return (new StreamReader(ms)).ReadToEnd();
            }
        }
    }
}