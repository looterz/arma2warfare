using System.Linq;
using Arma2.Script.Compiler.Sqf;
using Arma2.Script.Compiler.Sqf.Visitors;
using Reflector.CodeModel;
using Reflector.CodeModel.Memory;

namespace Arma2.Script.Compiler.Sqf
{
    internal partial class LanguageWriter : ILanguageWriterEx
    {
        private void WriteMethodInvokeExpression(IMethodInvokeExpression expression, IFormatter formatter)
        {
            if (VisitorFactory.BaseVisitor.WriteMethodInvokeExpression(expression, this, formatter))
                return;

            var methodReferenceExpression = expression.Method as IMethodReferenceExpression;
            var method = (methodReferenceExpression != null) ? methodReferenceExpression.Method.Resolve() : null;

            if (method == null)
                method = null;


            ICustomAttribute inlineAttribute = (method != null) ? Helper.GetInlineAttribute(method.Attributes) : null;
            var baseMethod = method;
            while(inlineAttribute == null && baseMethod != null)
            {
                baseMethod = Helper.GetBaseMethod(baseMethod);
                if (baseMethod != null)
                {
                    baseMethod = baseMethod.Resolve();
                    inlineAttribute = Helper.GetInlineAttribute(baseMethod.Attributes);
                }
            }

            if (inlineAttribute != null)
            {
                string text = (string)((ILiteralExpression) inlineAttribute.Arguments[0]).Value;

                var expressions = expression.Arguments.Cast<IExpression>().ToList();
                if (!method.Static)
                    expressions.Insert(0, methodReferenceExpression.Target);

                var args = expressions.Select(exp =>
                {
                    TextFormatter sb = new TextFormatter();
                    WriteExpression(exp, sb);
                    return sb.ToString();
                }).ToArray();

                if (args.Count() > 0)
                    text = string.Format(text, args);

                formatter.Write(text);
                return;
            }

            bool isTargetDelegate1 = false;

            if (methodReferenceExpression != null && methodReferenceExpression.Target is ArgumentReferenceExpression)
            {
                var argumentRef = ((ArgumentReferenceExpression)methodReferenceExpression.Target);
                ITypeReference typeRef = argumentRef.Parameter.Resolve().ParameterType as ITypeReference;

                if (Helper.IsDelegate(typeRef))
                {
                    isTargetDelegate1 = true;
                }
            }

            ExpressionCollection arguments = new ExpressionCollection();
            if (!isTargetDelegate1 && method != null && !method.Static)
            {
                arguments.Add(methodReferenceExpression.Target);
            }
            arguments.AddRange(expression.Arguments);

            if (arguments.Count > 0)
            {
                if (arguments.Count > 1)
                {
                    formatter.Write("[");
                    WriteExpressionList(arguments, formatter);
                    formatter.Write("]");
                    WriteOptionalSpace();
                }
                else
                {
                    WriteExpressionList(arguments, formatter);
                    formatter.Write(" ");
                }
            }

            if (methodReferenceExpression != null)
            {
                if (!isTargetDelegate1)
                {
                    WriteMethodReferenceExpression(methodReferenceExpression, formatter);
                }
                else
                {
                    formatter.Write("call ");
                    WriteExpression(methodReferenceExpression.Target);
                }
            }
            else
            {
                formatter.Write("{");
                WriteOptionalSpace();
                WriteExpression(expression.Method, formatter);
                WriteOptionalSpace();
                formatter.Write("}");
            }
        }
    }
}