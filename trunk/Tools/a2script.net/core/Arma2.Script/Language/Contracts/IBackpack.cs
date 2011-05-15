using Arma2.Script.Language.Contracts;
using Arma2.Script.Compiler.Sqf.Attributes;

namespace Arma2.Script.Language.Contracts
{
    public interface IBackpack
    {
        [InlineMethod("{0} backpackSpaceFor {1}")]
        IBackpackSpace backpackSpaceFor(string weaponName);
    }
}