using System;
using System.Linq;
using Arma2.Script.Compiler.Sqf.Visitors;
using Reflector.CodeModel;
using Reflector.CodeModel.Memory;

namespace Arma2.Script.Compiler.Sqf.Adapters
{
    public class BaseAdapter : IVisitor
    {
        public Type GetAdaptingType()
        {
            return null;
        }

        public bool WritePropertyReferenceExpression(IPropertyReferenceExpression expression, ILanguageWriterEx languageWriter, IFormatter formatter)
        {
            IVisitor successed = VisitorFactory.GetVisitor(expression.Property.DeclaringType)
                .FirstOrDefault(visitor => visitor.WritePropertyReferenceExpression(expression, languageWriter, formatter));

            return (successed != null);
        }

        public bool WriteFieldReferenceExpression(IFieldReferenceExpression expression, ILanguageWriterEx languageWriter, IFormatter formatter)
        {
            IVisitor successed = VisitorFactory.GetVisitor(expression.Field.DeclaringType)
                .FirstOrDefault(visitor => visitor.WriteFieldReferenceExpression(expression, languageWriter, formatter));

            return (successed != null);
        }

        public bool WriteMethodInvokeExpression(IMethodInvokeExpression methodInvoke, ILanguageWriterEx languageWriter, IFormatter formatter)
        {

            var methodReferenceExpression = methodInvoke.Method as IMethodReferenceExpression;
            if (methodReferenceExpression != null)
            {
                var target = methodReferenceExpression.Method.DeclaringType;
                if (target != null)
                {
                    ITypeReference typeRef = target as ITypeReference;
                    IVisitor successed = VisitorFactory.GetVisitor(typeRef)
                        .FirstOrDefault(visitor => visitor.WriteMethodInvokeExpression(methodInvoke, languageWriter, formatter));

                    if (successed != null)
                        return true;
                }
            }

            return false;
        }
    }
}