using Arma2.Script.Compiler.Sqf.Visitors;
using Reflector.CodeModel;
using System;

namespace Arma2.Script.Compiler.Sqf.Adapters
{
    public class SystemMathAdapter : IVisitor
    {
        public Type GetAdaptingType()
        {
            return typeof (Math);
        }

        public bool WritePropertyReferenceExpression(IPropertyReferenceExpression expression, ILanguageWriterEx languageWriter, IFormatter formatter)
        {
            if (expression.Property.Name == "PI")
            {
                formatter.Write("3.1415926");
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
            if (methodReferenceExpression.Method.Name == "Abs")
            {
                WriteStaticFunc("abs", methodInvoke.Arguments, languageWriter, formatter);
                return true;
            }
            if (methodReferenceExpression.Method.Name == "Acos")
            {
                WriteStaticFunc("acos", methodInvoke.Arguments, languageWriter, formatter);
                return true;
            }            
            if (methodReferenceExpression.Method.Name == "Asin")
            {
                WriteStaticFunc("asin", methodInvoke.Arguments, languageWriter, formatter);
                return true;
            }

            if (methodReferenceExpression.Method.Name == "Atan")
            {
                WriteStaticFunc("atan", methodInvoke.Arguments, languageWriter, formatter);
                return true;
            }

            if (methodReferenceExpression.Method.Name == "Atan2")
            {
                WriteStaticFunc("atan2", methodInvoke.Arguments, languageWriter, formatter);
                return true;
            }

            if (methodReferenceExpression.Method.Name == "Cos")
            {
                WriteStaticFunc("cos", methodInvoke.Arguments, languageWriter, formatter);
                return true;
            }

            if (methodReferenceExpression.Method.Name == "Sin")
            {
                WriteStaticFunc("sin", methodInvoke.Arguments, languageWriter, formatter);
                return true;
            }

            if (methodReferenceExpression.Method.Name == "Tan")
            {
                WriteStaticFunc("tan", methodInvoke.Arguments, languageWriter, formatter);
                return true;
            }

            if (methodReferenceExpression.Method.Name == "Ceiling")
            {
                WriteStaticFunc("ceil", methodInvoke.Arguments, languageWriter, formatter);
                return true;
            }

            if (methodReferenceExpression.Method.Name == "Floor")
            {
                WriteStaticFunc("floor", methodInvoke.Arguments, languageWriter, formatter);
                return true;
            }

            if (methodReferenceExpression.Method.Name == "Round")
            {
                WriteStaticFunc("round", methodInvoke.Arguments, languageWriter, formatter);
                return true;
            }

            return false;
        }

        private void WriteStaticFunc(string funcName, IExpressionCollection args, ILanguageWriterEx languageWriter, IFormatter formatter)
        {
            formatter.Write(funcName);
            formatter.Write("(");
            languageWriter.WriteExpressionList(args, formatter);
            formatter.Write(")");
        }
    }
}