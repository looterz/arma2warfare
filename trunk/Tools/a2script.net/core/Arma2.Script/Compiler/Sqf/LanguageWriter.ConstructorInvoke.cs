using System;
using System.Linq;
using Arma2.Script.Compiler.Sqf;
using Arma2.Script.Compiler.Sqf.Visitors;
using Reflector.CodeModel;
using Reflector.CodeModel.Memory;

namespace Arma2.Script.Compiler.Sqf
{
    internal partial class LanguageWriter : ILanguageWriterEx
    {
        private void WriteObjectCreateExpression(IObjectCreateExpression value, IFormatter formatter)
        {
            if (value.Constructor != null)
            {
                IMethodDeclaration method = Helper.ResolveMethod(value.Constructor);
                if (WriteInlineMethod(method, null, value.Arguments, formatter))
                    return;

                ExpressionCollection arguments = new ExpressionCollection();
                arguments.AddRange(value.Arguments);

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

                formatter.Write("call");
                formatter.Write(" ");
                WriteMethodReference(value.Constructor, formatter);
                return;
            }

            throw new ApplicationException("try create object that not has constuctor");
        }
    }
}