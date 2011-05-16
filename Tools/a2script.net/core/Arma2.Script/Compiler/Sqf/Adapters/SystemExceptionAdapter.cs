using Arma2.Script.Compiler.Sqf.Visitors;
using Reflector.CodeModel;
using System;

namespace Arma2.Script.Compiler.Sqf.Adapters
{
    public class SystemExceptionhAdapter : IVisitor
    {
        public Type GetAdaptingType()
        {
            return typeof (Exception);
        }

        public bool WritePropertyReferenceExpression(IPropertyReferenceExpression expression, ILanguageWriterEx languageWriter, IFormatter formatter)
        {
            if (expression.Property.Name == "Message")
            {
                formatter.Write("_exception");
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
            return false;
        }
    }
}