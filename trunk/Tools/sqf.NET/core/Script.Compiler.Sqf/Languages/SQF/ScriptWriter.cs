using System.IO;
using System.Text;
using Script.Compiler.Core.ScriptWriter;
using Script.Compiler.Languages.SQF;

namespace Script.Compiler.Languages.SQF
{
    public class ScriptWriter : StreamWriter, IScriptWriter
    {
        public class ScriptScopeWriter : ScriptWriter
        {
            private MemoryStream _ms;
            private ScriptWriter _writer;

            public ScriptScopeWriter(ScriptWriter writer, MemoryStream stream)
                : base(stream)
            {
                _ms = stream;
                _writer = writer;
            }

            public override void Commit()
            {
                base.Commit();
                _ms.Position = 0;

                StreamReader reader = new StreamReader(_ms);
                string content = reader.ReadToEnd();

                if (content.Length > 0)
                {
                    _writer._insIdent = false;
                    _writer.Write(content);
                    _writer._insIdent = true;
                }
            }
        }

        private bool _insIdent = true;
        public int Ident { get; set; }

        public ScriptWriter(string fileName)
            : base(fileName, false, Encoding.UTF8)
        {}

        public ScriptWriter(Stream stream)
            : base(stream, System.Text.Encoding.UTF8)
        { }

        public void WriteLiteral(string text)
        {
            Write("\"");
            Write(text);
            Write("\"");
        }

        public void WriteSelf()
        {
            this.Write("_this");
        }

        public void WriteBeginScope()
        {
            WriteLine("{");
            Ident++;
        }

        public void WriteEndScope()
        {
            Ident--;
            WriteLine("}");
        }

         public void WriteSpace()
         {
             Write(" ");
         }

         public IScriptWriter GetScopeWriter()
         {
            var writer1 = new ScriptScopeWriter(this, new MemoryStream());
            writer1.Ident = this.Ident;

            return writer1;
         }

        public virtual void Commit()
        {
            this.Flush();
        }


        public IScriptWriter Scope(string openChar = null, string closeChar = null)
        {
            return (IScriptWriter)new ScopeScriptWriter(this, openChar, closeChar);
        }

        public void WriteIdent()
        {
            if (_insIdent)
            {
                base.Write(new string(' ', Ident * 4));
                _insIdent = false;
            }
        }

        public override void Write(string value)
        {
            WriteIdent();
            base.Write(value);
        }

        public override void Write(string value, params object[] args)
        {
            WriteIdent();

            if (args.Length > 0)
                value = string.Format(value, args);

            base.Write(value);
            _insIdent = true;
        }

        public override void WriteLine(string value, params object[] args)
        {
            WriteIdent();

            if (args.Length > 0)
                value = string.Format(value, args);

            base.WriteLine(value);
            _insIdent = true;
        }

        public override void WriteLine(string value)
        {
            WriteIdent();
            base.WriteLine(value);
            _insIdent = true;
        }

        public void WriteAssignment()
        {
            WriteSpace();
            Write("=");
            WriteSpace();
        }

        public void WriteDelimiter()
        {
            Write(",");
            WriteSpace();
        }

        public override void WriteLine()
        {
            base.WriteLine();
            _insIdent = true;
        }
    }
}