using Arma2.Script.Compiler.Sqf.Attributes;

namespace Arma2.Script.Language.Types
{
    public enum CamCommandType
    {
        [InlineMethod("\"manual on\"")]
        ManualOn,
        [InlineMethod("\"manual off\"")]
        ManualOff,
        [InlineMethod("\"inertia on\"")]
        InertiaOn,
        [InlineMethod("\"inertia off\"")]
        InertiaOff,
        [InlineMethod("\"landed\"")]
        Landed,
        [InlineMethod("\"airborne\"")]
        Airborne
    }
}