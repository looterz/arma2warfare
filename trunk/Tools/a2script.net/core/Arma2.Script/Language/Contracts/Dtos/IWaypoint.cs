namespace Arma2.Script.Language.Contracts
{
    public interface IWaypoint
    {
        IUnitGroup Group { get; }
        int Index { get; }
    }
}