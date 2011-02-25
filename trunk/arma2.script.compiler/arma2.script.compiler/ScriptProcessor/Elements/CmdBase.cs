using System;
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

        public virtual Processor Processor
        {
            get { return Parent.Processor; }
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

        public CmdBase NextElement(int pos)
        {
            var id = CmdId + pos;
            return (Parent != null && 0 <= id && id < Parent.Commands.Count) ? Parent.Commands[id] : null;
        }

        public T NextElement<T>(int pos) where T : CmdBase
        {
            var id = CmdId + pos;
            CmdBase base1 = (0 <= id && id < Parent.Commands.Count) ? Parent.Commands[id] : null;

            return (base1 is T) ? (T)base1 : null;
        }

        public string ShortTerm
        {
            get 
            { 
                string s = ToString();
                return (s.Length > 150) ? s.Remove(150)+"\n..." : s;
            }
        }

        public string ShortTermEnd
        {
            get
            {
                string s = ToString();
                return (s.Length > 150) ? "\n..." + s.Substring(s.Length - 150) : s;
            }
        }

        public string GetScript(bool minimized)
        {
            using(var ms = new MemoryStream())
            {
                var writer = new ScriptWriter(ms, minimized);
                writer.AutoFlush = true;
                Render(writer);
                writer.Flush();

                ms.Flush();
                ms.Position = 0;
                return (new StreamReader(ms)).ReadToEnd();
            }
        }

        public override string ToString()
        {
            return GetScript(this.Processor.Compiler.Settings.ScriptMinimized);
        }

        protected virtual void CompileInternal(Compiler compiler)
        {
        }

        public void Compile(Compiler compiler)
        {
            CompileInternal(compiler);
        }

        public void CompileSafe(Compiler compiler)
        {
            try
            {
                CompileInternal(compiler);
            }
            catch (CompileException e)
            {
                if (e.Throwable)
                    throw;

                e.WriteToLog();
            }
        }
    }
}