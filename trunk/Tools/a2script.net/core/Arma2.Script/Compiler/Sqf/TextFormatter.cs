using System;
using System.Globalization;
using System.IO;
using Reflector.CodeModel;

namespace Arma2.Script.Compiler.Sqf
{
    internal class TextFormatter : IFormatter
    {
        #region Поля класса

        private readonly StringWriter writer = new StringWriter(CultureInfo.InvariantCulture);
        private int indent;
        private bool newLine;

        #endregion

        #region Интерфейсы класса

        #region IFormatter Members

        public void Write(string text)
        {
            if (text.Contains("[]"))
                text = "[]";

            ApplyIndent();
            writer.Write(text);
        }

        public void WriteDeclaration(string text)
        {
            WriteBold(text);
        }

        public void WriteDeclaration(string text, object target)
        {
            WriteBold(text);
        }

        public void WriteComment(string text)
        {
            WriteColor(text, 0x808080);
        }

        public void WriteLiteral(string text)
        {
            WriteColor(text, 0x800000);
        }

        public void WriteKeyword(string text)
        {
            WriteColor(text, 0x000080);
        }

        public void WriteIndent()
        {
            indent++;
        }

        public void WriteLine()
        {
            writer.WriteLine();
            newLine = true;
        }

        public void WriteOutdent()
        {
            indent--;
        }

        public void WriteReference(string text, string toolTip, Object reference)
        {
            ApplyIndent();
            writer.Write(text);
        }

        public void WriteProperty(string propertyName, string propertyValue)
        {
        }

        #endregion

        #endregion

        #region Методы класса

        public override string ToString()
        {
            return writer.ToString();
        }

        private void WriteBold(string text)
        {
            ApplyIndent();
            writer.Write(text);
        }

        private void WriteColor(string text, int color)
        {
            ApplyIndent();
            writer.Write(text);
        }

        private void ApplyIndent()
        {
            if (newLine)
            {
                for (int i = 0; i < indent; i++)
                {
                    writer.Write("    ");
                }

                newLine = false;
            }
        }

        #endregion
    }
}