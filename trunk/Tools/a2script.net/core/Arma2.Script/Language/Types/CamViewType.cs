using Arma2.Script.Attributes;

namespace Arma2.Script.Language.Types
{
    public enum CamViewType
    {
        [InlineMethod("\"INTERNAL\"")]
        Internal,
        [InlineMethod("\"EXTERNAL\"")]
        External,
        [InlineMethod("\"GUNNER\"")]
        Gunner,
        [InlineMethod("\"GROUP\"")]
        Group
    }
}