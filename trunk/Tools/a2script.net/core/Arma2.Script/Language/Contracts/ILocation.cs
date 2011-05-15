using Arma2.Script.Compiler.Sqf.Attributes;

namespace Arma2.Script.Language.Contracts
{
    public interface ILocation
    {
        [InlineMethod("attachedObject {0}")]
        IObject attachedObject();

        [InlineMethod("{0} attachObject {1}")]
        void attachObject(IObject obj); 
    }
}