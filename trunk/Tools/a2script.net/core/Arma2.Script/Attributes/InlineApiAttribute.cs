using System;

namespace Arma2.Script.Compiler.Sqf.Attributes
{
    public class InlineMethodAttribute : Attribute
    {
        public string Text { get; set; }

        public InlineMethodAttribute(string text)
        {
            Text = text;
        }
    }
}