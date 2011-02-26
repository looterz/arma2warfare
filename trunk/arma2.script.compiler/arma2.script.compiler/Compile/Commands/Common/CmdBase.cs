using System.IO;
using ArmA2.Script.Compile.Exceptions;
using ArmA2.Script.Compile.TextWriters;
using ArmA2.Script.ScriptProcessor;

namespace ArmA2.Script.Compile.Commands.Common
{
    internal class CmdBase : IScriptRenderer
    {
        /// <summary>
        /// Скоп которому принадлежит элемент {}, [], ()
        /// </summary>
        internal CmdScopeBase ParentScope
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

        internal CmdGroup Parent { get; set; }
        public virtual void Render(ScriptWriter writer)
        {
        }

        internal virtual Processor Processor
        {
            get { return Parent.Processor; }
        }

        internal int IndexId
        {
            get { return (Parent != null) ? Parent.Items.IndexOf(this) : -1; }
        }

        internal int CmdId
        {
            get { return (Parent != null) ? Parent.Commands.IndexOf(this) : -1; }
        }

        internal CmdBase NextItem(int pos)
        {
            var id = IndexId + pos;
            return (0 <= id && id < Parent.Items.Count) ? Parent.Items[id] : null;
        }

        internal CmdBase NextElement(int pos)
        {
            var id = CmdId + pos;
            return (Parent != null && 0 <= id && id < Parent.Commands.Count) ? Parent.Commands[id] : null;
        }

        internal T NextElement<T>(int pos) where T : CmdBase
        {
            var id = CmdId + pos;
            CmdBase base1 = (0 <= id && id < Parent.Commands.Count) ? Parent.Commands[id] : null;

            return (base1 is T) ? (T)base1 : null;
        }

        internal string ShortTerm
        {
            get
            {
                string s = GetScript(false);
                return (s.Length > 150) ? s.Remove(150)+"\n..." : s;
            }
        }

        internal string ShortTermEnd
        {
            get
            {
                string s = GetScript(false);
                return (s.Length > 150) ? "\n..." + s.Substring(s.Length - 150) : s;
            }
        }

        internal string GetScript(bool minimized)
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

        internal void Compile(Compiler compiler)
        {
            CompileInternal(compiler);
        }

        internal void CompileSafe(Compiler compiler)
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