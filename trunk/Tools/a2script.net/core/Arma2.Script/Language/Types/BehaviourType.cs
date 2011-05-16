using Arma2.Script.Compiler.Sqf.Attributes;

namespace Arma2.Script.Language.Types
{
    public enum BehaviourType
    {
        [InlineMethod("\"CARELESS\"")]
        Main,
        [InlineMethod("\"SAFE\"")]
        Red,
        [InlineMethod("\"AWARE\"")]
        Green,
        [InlineMethod("\"COMBAT\"")]
        Blue,
        [InlineMethod("\"STEALTH\"")]
        Yellow
    }
}