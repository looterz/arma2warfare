using Arma2.Script.Compiler.Sqf.Attributes;

namespace Arma2.Script.Language.Contracts.Dtos
{
    public interface IBoundingBox
    {
        [InlineMethod("({0} select 0)")]
        IPosition Min
        {
            [InlineMethod("({0} select 0)")]
            get;
        }
        [InlineMethod("({0} select 1)")]
        IPosition Max
        {
            [InlineMethod("({0} select 1)")]
            get;
        }
    }
}