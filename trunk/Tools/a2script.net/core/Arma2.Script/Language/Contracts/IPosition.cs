using Arma2.Script.Attributes;

namespace Arma2.Script.Language.Contracts
{
    [Script]
    public interface IPosition
    {
        double X
        {
            [InlineMethod("{0} select 0")]
            get;
            [InlineMethod("{0} set[0, {1}]")]
            set;
        }

        double Y
        {
            [InlineMethod("{0} select 1")]
            get;
            [InlineMethod("{0} set[1, {1}]")]
            set;
        }

        double Z
        {
            [InlineMethod("{0} select 2")]
            get;
            [InlineMethod("{0} set[2, {1}]")]
            set;
        }
    }
}