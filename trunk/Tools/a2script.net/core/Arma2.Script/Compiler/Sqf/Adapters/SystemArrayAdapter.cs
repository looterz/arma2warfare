using Arma2.Script.Compiler.Sqf.Visitors;
using Reflector.CodeModel;
using System;

namespace Arma2.Script.Compiler.Sqf.Adapters
{
    public class SystemArrayAdapter : IVisitor
    {
        public Type GetAdaptingType()
        {
            return typeof (Array);
        }

        public bool WritePropertyReferenceExpression(IPropertyReferenceExpression expression, ILanguageWriterEx languageWriter, IFormatter formatter)
        {
            if (expression.Property.Name == "Length")
            {
                AdapterPropertyGetLength(expression, languageWriter, formatter);
                return true;
            }
            return false;
        }

        public bool WriteFieldReferenceExpression(IFieldReferenceExpression expression, ILanguageWriterEx languageWriter, IFormatter formatter)
        {
            return false;
        }

        public bool WriteMethodInvokeExpression(IMethodInvokeExpression methodInvoke, ILanguageWriterEx languageWriter, IFormatter formatter)
        {
            var methodReferenceExpression = (IMethodReferenceExpression)methodInvoke.Method;
            if (methodReferenceExpression.Method.Name == "get_Length")
            {
                AdapterMethodGetLength(methodReferenceExpression, languageWriter, formatter);
                return true;
            }

            return false;
        }

        private void AdapterPropertyGetLength(IPropertyReferenceExpression expression, ILanguageWriterEx languageWriter, IFormatter formatter)
        {
            formatter.Write("count");
            formatter.Write("(");
            languageWriter.WriteExpression(expression.Target);
            formatter.Write(")");
        }

        private void AdapterMethodGetLength(IMethodReferenceExpression methodReferenceExpression, ILanguageWriter languageWriter, IFormatter formatter)
        {
            formatter.Write("count");
            formatter.Write("(");
            languageWriter.WriteExpression(methodReferenceExpression.Target);
            formatter.Write(")");
        }
    }
}