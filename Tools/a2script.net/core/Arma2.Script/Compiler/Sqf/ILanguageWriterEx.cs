using Reflector.CodeModel;

namespace Arma2.Script.Compiler.Sqf
{
    public interface ILanguageWriterEx : ILanguageWriter
    {
        void WriteExpression(IExpression value, IFormatter formatter);
        void WriteExpressionList(IExpressionCollection expressions, IFormatter formatter);
    }
}