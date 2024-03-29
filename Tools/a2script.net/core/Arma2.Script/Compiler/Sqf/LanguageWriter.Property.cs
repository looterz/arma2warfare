﻿using Arma2.Script.Compiler.Sqf;
using Arma2.Script.Compiler.Sqf.Visitors;
using Reflector.CodeModel;
using Reflector.CodeModel.Memory;

namespace Arma2.Script.Compiler.Sqf
{
    internal partial class LanguageWriter : ILanguageWriterEx
    {


        private void WritePropertyReferenceExpression(IPropertyReferenceExpression expression, IFormatter formatter)
        {
            if (VisitorFactory.BaseVisitor.WritePropertyReferenceExpression(expression, this, formatter))
                return;
            
            var propertyInfo = expression.Property.Resolve();
            if (WriteInlineMethod(propertyInfo.GetMethod.Resolve(), expression.Target, new ExpressionCollection(), formatter))
                return;

            formatter.Write("(");
            var getMethod = expression.Property.Resolve().GetMethod;
            if (!getMethod.Resolve().Static)
            {
                bool isTargetThis = (expression.Target is IThisReferenceExpression ||
                                     expression.Target is IBaseReferenceExpression);

                if (isTargetThis)
                {
                    WriteExpression(expression.Target, formatter);
                    formatter.Write(" ");
                }
                else
                {
                    formatter.Write("(");
                    WriteExpression(expression.Target, formatter);
                    formatter.Write(")");
                }
            }
            formatter.Write("call ");
            WriteMethodReference(getMethod, formatter);
            formatter.Write(")");
        }
    }
}