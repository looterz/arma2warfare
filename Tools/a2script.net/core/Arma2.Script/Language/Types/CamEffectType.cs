using Arma2.Script.Attributes;

namespace Arma2.Script.Language.Types
{
    public enum CamEffectType
    {
        [InlineMethod("\"Internal\"")]
        Internal,
        [InlineMethod("\"External\"")]
        External,
        [InlineMethod("\"Fixed\"")]
        Fixed,
        [InlineMethod("\"FixedWithZoom\"")]
        FixedWithZoom,
        [InlineMethod("\"Terminate\"")]
        Terminate       
    }
}