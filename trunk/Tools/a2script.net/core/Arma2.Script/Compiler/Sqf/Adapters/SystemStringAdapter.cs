using System.IO;
using System.Text.RegularExpressions;
using Arma2.Script.Compiler.Sqf.Visitors;
using Reflector.CodeModel;
using System;

namespace Arma2.Script.Compiler.Sqf.Adapters
{
    public class SystemStringAdapter : IVisitor
    {
        public Type GetAdaptingType()
        {
            return typeof (String);
        }

        public bool WriteFieldReferenceExpression(IFieldReferenceExpression expression, ILanguageWriterEx languageWriter, IFormatter formatter)
        {
            if (expression.Field.Name == "Empty")
            {
                formatter.Write("\"\"");
                return true;
            }
            return false;
        }

        public bool WritePropertyReferenceExpression(IPropertyReferenceExpression expression, ILanguageWriterEx languageWriter, IFormatter formatter)
        {
            return false;
        }

        public bool WriteMethodInvokeExpression(IMethodInvokeExpression methodInvoke, ILanguageWriterEx languageWriter, IFormatter formatter)
        {
            var methodReferenceExpression = (IMethodReferenceExpression)methodInvoke.Method;
            switch(methodReferenceExpression.Method.Name)
            {
                case "Concat":
                    AdapterMethodConcat(methodInvoke, languageWriter, formatter);
                    return true;

                case "Format":
                    AdapterMethodFormat(methodInvoke, languageWriter, formatter);
                    return true;
            }
            return false;
        }

        private void AdapterMethodConcat(IMethodInvokeExpression methodInvoke, ILanguageWriterEx languageWriter, IFormatter formatter)
        {
            for (int i = 0; i < methodInvoke.Arguments.Count; i++ )
            {
                if (i != 0)
                    formatter.Write(" + ");

                languageWriter.WriteExpression(methodInvoke.Arguments[i]);
            }
        }

        private void AdapterMethodFormat(IMethodInvokeExpression methodInvoke, ILanguageWriterEx languageWriter, IFormatter formatter)
        {
            formatter.Write("format");
            formatter.Write("[");

            TextFormatter sb = new TextFormatter();
            languageWriter.WriteExpression(methodInvoke.Arguments[0], sb);

            var formatString = sb.ToString();
            formatString = formatString.Replace("%", "%%");

            Regex regex = new Regex(@"(?<=[^\{])\{(\d)[^\}]*\}");
            formatString = regex.Replace(formatString, (match) => "%" + (int.Parse(match.Groups[1].Value) + 1));

            formatter.Write(formatString);
            
            for (int i = 1; i < methodInvoke.Arguments.Count; i++)
            {
                formatter.Write(",");
                languageWriter.WriteExpression(methodInvoke.Arguments[i]);
            }
            formatter.Write("]");
        }
    }
}