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

            var refMethod = expression.Method as IMethodReferenceExpression;
            var method = (refMethod != null) ? Helper.ResolveMethod(refMethod.Method) : null;

            if (WriteInlineMethod(method, (refMethod != null) ? refMethod.Target : null, expression.Arguments, formatter))
                return;

            bool isTargetDelegate1 = false;

            if (refMethod != null && refMethod.Target is ArgumentReferenceExpression)
            {
                var argumentRef = ((ArgumentReferenceExpression)refMethod.Target);
                ITypeReference typeRef = argumentRef.Parameter.Resolve().ParameterType as ITypeReference;

                if (Helper.IsDelegate(typeRef))
                {
                    isTargetDelegate1 = true;
                }
            }

            ExpressionCollection arguments = new ExpressionCollection();
            if (!isTargetDelegate1 && method != null && !method.Static)
            {
                arguments.Add(refMethod.Target);
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

            if (refMethod != null)
            {
                if (!isTargetDelegate1)
                {
                    WriteMethodReferenceExpression(refMethod, formatter);
                }
                else
                {
                    formatter.Write("call ");
                    WriteExpression(refMethod.Target);
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

        private bool WriteInlineMethod(
            IMethodDeclaration method, IExpression target, IExpressionCollection arguments, IFormatter formatter)
        {
            if (method == null)
                return false;

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
                string format = (string)((ILiteralExpression)inlineAttribute.Arguments[0]).Value;

                var expressions = arguments.Cast<IExpression>().ToList();
                if (!method.Static && target != null)
                    expressions.Insert(0, target);

                var args = expressions.Select(exp =>
                {
                    TextFormatter sb = new TextFormatter();
                    WriteExpression(exp, sb);
                    return sb.ToString();
                }).ToArray();

                string text = (args.Count() > 0) ? string.Format(format, args) : format;
                formatter.Write(text);
                return true;
            }
            return false;
        }
    }
}