using System;
using Reflector.CodeModel;

namespace Arma2.Script.Compiler.Sqf.Visitors
{
    public interface IVisitor
    {
        bool WriteMethodInvokeExpression(IMethodInvokeExpression methodInvoke, ILanguageWriterEx languageWriter, IFormatter formatter);
        Type GetAdaptingType();
        bool WritePropertyReferenceExpression(IPropertyReferenceExpression expression, ILanguageWriterEx languageWriter, IFormatter formatter);
        bool WriteFieldReferenceExpression(IFieldReferenceExpression expression, ILanguageWriterEx languageWriter, IFormatter formatter);
    }
}