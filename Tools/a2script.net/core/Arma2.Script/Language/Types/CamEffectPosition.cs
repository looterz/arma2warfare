using Arma2.Script.Attributes;

namespace Arma2.Script.Language.Types
{
    public enum CamEffectPosition
    {
        [InlineMethod("\"TOP\"")]
        Top,
        [InlineMethod("\"LEFT\"")]
        Left,
        [InlineMethod("\"RIGHT\"")]
        Right,
        [InlineMethod("\"FRONT\"")]
        Front,
        [InlineMethod("\"BACK\"")]
        Back
    }
}