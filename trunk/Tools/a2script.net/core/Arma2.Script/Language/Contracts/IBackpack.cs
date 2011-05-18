using Arma2.Script.Attributes;
using Arma2.Script.Language.Contracts;

namespace Arma2.Script.Language.Contracts
{
    [Script]
    public interface IBackpack
    {
        [InlineMethod("{0} backpackSpaceFor {1}")]
        IBackpackSpace backpackSpaceFor(string weaponName);
    }
}