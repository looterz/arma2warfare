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
        private bool _writeCatchClause = false;

        private void WriteTryCatchFinallyStatement(ITryCatchFinallyStatement statement, IFormatter formatter)
        {
            WriteStatementSeparator(formatter);

            formatter.WriteKeyword("try");
            WriteOptionalSpace();
            formatter.Write("{");
            formatter.WriteLine();
            formatter.WriteIndent();

            if (statement.Try != null)
            {
                WriteStatement(statement.Try, formatter);
            }
            WritePendingOutdent(formatter);
            formatter.WriteLine();
            formatter.WriteOutdent();
            formatter.Write("}");
            WriteOptionalSpace();

            if (statement.CatchClauses.Count > 0)
            {
                formatter.WriteKeyword("catch");
                WriteOptionalSpace();
                formatter.Write("{");
                formatter.WriteLine();
                formatter.WriteIndent();
                formatter.Write("Private['_handledException'];"); formatter.WriteLine();
                formatter.Write("_handledException = false;"); formatter.WriteLine();
                
                foreach (ICatchClause catchClause in statement.CatchClauses)
                {
                    formatter.Write(string.Format("if (_exception == \"{0}\") then {{", 
                        Helper.GetTypeName(catchClause.Variable.VariableType as ITypeReference)));
                    formatter.WriteLine();
                    formatter.WriteIndent();

                    catchClause.Variable.Name = "_exception";
                    if (catchClause.Body != null)
                    {
                        _writeCatchClause = true;
                        WriteStatement(catchClause.Body, formatter);
                        WriteStatementSeparator(formatter);
                        _writeCatchClause = false;
                    }

                    formatter.Write("_handledException = true;"); 
                    formatter.WriteLine();
                    formatter.WriteOutdent();
                    formatter.WriteLine();
                    formatter.Write("};");
                    formatter.WriteLine();
                }

                if (statement.Finally != null)
                {
                    formatter.Write("if(!_handledException) then {");
                    formatter.WriteLine();
                    formatter.WriteIndent();

                    WriteStatement(statement.Finally, formatter);
                    WriteStatementSeparator(formatter);
                    formatter.Write("throw _exception;");

                    formatter.WriteOutdent();
                    formatter.WriteLine();
                    formatter.Write("};");
                }

                WritePendingOutdent(formatter);
                formatter.WriteLine();
                formatter.WriteOutdent();
                formatter.Write("};");
            }
        }

        private void WriteThrowExceptionStatement(IThrowExceptionStatement statement, IFormatter formatter)
        {
            WriteStatementSeparator(formatter);
            formatter.WriteKeyword("throw");
            formatter.Write(" ");
            if (statement.Expression != null)
            {
                if (statement.Expression is IObjectCreateExpression)
                {
                    var type = ((IObjectCreateExpression)statement.Expression).Type;
                    formatter.Write("\"");
                    formatter.Write(Helper.GetTypeName(type as ITypeReference));
                    formatter.Write("\"");
                }
            }
            else
            {
                if (_writeCatchClause)
                {
                    formatter.Write("_exception");
                }
                else
                {
                    throw new ApplicationException("Exception rethrow is not supported");
                }
            }
        }
    }
}