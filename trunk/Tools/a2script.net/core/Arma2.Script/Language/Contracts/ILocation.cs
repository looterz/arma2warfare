using Arma2.Script.Attributes;

namespace Arma2.Script.Language.Contracts
{
    [Script]
    public interface ILocation
    {
        [InlineMethod("attachedObject {0}")]
        IObject attachedObject();

        [InlineMethod("{0} attachObject {1}")]
        void attachObject(IObject obj); 
    }
}