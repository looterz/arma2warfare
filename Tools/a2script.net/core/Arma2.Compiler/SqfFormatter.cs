using System.IO;
using Reflector.CodeModel;

namespace Arma2.Compiler
{
    public class SqfFormatter : StreamWriter, IFormatter
    {
        private int _ident = 0;
        private bool _renderIdent = true;

        public SqfFormatter(string filePath)
            : base(filePath)
        {
        }

        public SqfFormatter(Stream stream)
            : base(stream)
        {
        }

        public void WriteKeyword(string value)
        {
            this.Write(value);
        }

        public void WriteLiteral(string value)
        {
            this.Write(value);
        }

        public void WriteComment(string value)
        {
            this.Write(value);
        }

        public void WriteDeclaration(string value)
        {
            this.Write(value);
        }

        public void WriteDeclaration(string value, object target)
        {
            this.Write(value);
        }

        public void WriteReference(string value, string description, object target)
        {
            this.Write(value);
        }

        public override void Write(string value)
        {
            if (value.Contains("{0} select 1"))
                value = "{0} select 1";

            if (_renderIdent)
            {
                base.Write(new string(' ', _ident * 4));
                _renderIdent = false;
            }
            base.Write(value);
        }

        
        public void WriteIndent()
        {
            _ident++;
        }

        public void WriteOutdent()
        {
            _ident--;
        }

        public override void WriteLine()
        {
            base.WriteLine();
            _renderIdent = true;
        }

        public void WriteProperty(string name, string value)
        {
            //this.Write(string.Format("{0} = \"{1}\"", name, value));
        }
    }
}