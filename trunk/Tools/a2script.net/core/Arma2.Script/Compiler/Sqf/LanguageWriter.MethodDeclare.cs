using System.Linq;
using Arma2.Script.Compiler.Sqf;
using Reflector.CodeModel;

namespace Arma2.Script.Compiler.Sqf
{
    internal partial class LanguageWriter : ILanguageWriterEx
    {
        public void WriteContructorDeclaration(IConstructorDeclaration constructor)
        {
            WriteMethodDeclarationHeader(constructor);

            formatter.Write("{");
            formatter.WriteIndent();
            WriteMethodDeclarationParameters(constructor);

            if (!constructor.Static)
            {
                formatter.WriteLine();
                formatter.Write("if (isNil \"_this\") then {");
                formatter.Write("_this = 'objectBase' createVehicle [0, 0, 0]};");
            }

            if (constructor.Initializer != null)
            {
                formatter.WriteLine();
                formatter.Write("_this");
                WriteOptionalSpace();
                formatter.Write("=");
                WriteOptionalSpace();
                WriteExpression(constructor.Initializer, formatter);
                formatter.Write(";");

                _hasSeparator = true;
            }

            WriteMethodDeclarationBody(constructor);

            if (!constructor.Static)
            {
                WriteStatementSeparator(formatter);
                formatter.Write("_this");
            }

            formatter.WriteOutdent();
            formatter.WriteLine();
            formatter.Write("}");
            formatter.Write(";");
        }

        public void WriteMethodDeclaration(IMethodDeclaration method)
        {
            if (method.Static && Helper.GetInlineAttribute(method.Resolve().Attributes) != null)
                return; 
            
            if (method is IConstructorDeclaration)
            {
                WriteContructorDeclaration((IConstructorDeclaration) method);
                return;
            }

            WriteMethodDeclarationHeader(method);
            formatter.Write("{");
            formatter.WriteIndent();
            WriteMethodDeclarationParameters(method);

            WriteMethodDeclarationBody(method);

            formatter.WriteOutdent();
            formatter.WriteLine();
            formatter.Write("}");
            formatter.Write(";");
        }

        public void WriteMethodDeclarationHeader(IMethodDeclaration method)
        {
            formatter.Write("/// <summary>"); formatter.WriteLine();
            if (method.Documentation != null)
            {
                formatter.Write("///");
                formatter.Write(method.Documentation); formatter.WriteLine();
            }
            formatter.Write("/// </summary>"); formatter.WriteLine();
            
            formatter.Write(Helper.GetMethodName(method));
            WriteOptionalSpace();
            formatter.Write("=");
            WriteOptionalSpace();
        }

        public void WriteMethodDeclarationBody(IMethodDeclaration method)
        {
            var body = method.Body as IBlockStatement;
            if (body != null)
            {
                if (body.Statements.Count > 0)
                {
                    formatter.WriteLine();
                    WriteStatement(body, formatter);
                }
            }
        }

        private void WriteMethodDeclarationParameters(IMethodDeclaration method)
        {
            WriteMethodDeclarationParameters(method, false);
        }

        private void WriteMethodDeclarationParameters(IMethodDeclaration method, bool anonymousMethod)
        {
            var methodBody = method.Body as IBlockStatement;
            if (methodBody == null)
                return;

            var expressions = methodBody.Statements.Cast<IStatement>()
                .Where(statement => statement is IExpressionStatement)
                .Select(s => ((IExpressionStatement) s).Expression);

            var locals = expressions
                .Where(s => s is IAssignExpression && ((IAssignExpression) s).Target is IVariableDeclarationExpression)
                .Select(s => ((IVariableDeclarationExpression) ((IAssignExpression) s).Target).Variable).ToList();

            var declaration = expressions
                .Where(s => s is IVariableDeclarationExpression)
                .Select(s => (IVariableDeclarationExpression)s);

            locals.AddRange(expressions.Where(s => s is IVariableDeclarationExpression).Select(m => ((IVariableDeclarationExpression)m).Variable));

            if (method.Parameters.Count > 0 || locals.Count() > 0) 
            {
                formatter.WriteLine();
                formatter.Write("Private[");
                int count = 0;

                foreach (IParameterDeclaration parameter in method.Parameters)
                {
                    if (parameter.Name.StartsWith("_") == false)
                    {
                        parameter.Name = "_" + parameter.Name;
                    }

                    if (count++ != 0)
                    {
                        formatter.Write(",");
                        WriteOptionalSpace();
                    }
                    formatter.Write("\"" + parameter.Name + "\"");
                }

                foreach (IVariableDeclaration local in locals)
                {
                    if (local.Name.StartsWith("_") == false)
                    {
                        local.Name = "_" + local.Name;
                    }

                    if (count++ != 0)
                    {
                        formatter.Write(",");
                        WriteOptionalSpace();
                    }
                    formatter.Write("\"" + local.Name + "\"");
                }

                formatter.Write("];");

                bool isStatic = (method.Static || anonymousMethod);

                int paramId = isStatic ? 0 : 1;

                if (method.Parameters.Count == 1 && isStatic)
                {
                    formatter.WriteLine();
                    formatter.Write(method.Parameters[0].Name);
                    WriteOptionalSpace();
                    formatter.Write("=");
                    WriteOptionalSpace();
                    formatter.Write("_this");
                    formatter.Write(";");
                }
                else
                {
                    method.Parameters.Cast<IParameterDeclaration>().ForEach(parameter =>
                    {
                        formatter.WriteLine();
                        formatter.Write(parameter.Name);
                        WriteOptionalSpace();
                        formatter.Write("=");
                        WriteOptionalSpace();
                        formatter.Write("_this select ");
                        formatter.Write(paramId.ToString());
                        formatter.Write(";");
                        paramId++;
                    });
                }

                if (!isStatic)
                {
                    formatter.WriteLine();
                    formatter.Write("_this = _this select 0;");
                }

                declaration.ForEach(decl =>
                {
                    formatter.WriteLine();
                    formatter.Write(decl.Variable.Name);
                    WriteOptionalSpace();
                    formatter.Write("=");
                    WriteOptionalSpace();
                    formatter.Write("nil;");
                });

            }
        }
    }
}