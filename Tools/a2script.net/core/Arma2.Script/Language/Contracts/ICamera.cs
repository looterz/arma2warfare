using Arma2.Script.Attributes;
using Arma2.Script.Language.Types;

namespace Arma2.Script.Language.Contracts
{
    [Script]
    public interface ICamera
    {
        [InlineMethod("{0} camCommand {1}")]
        void camCommand(CamCommandType camCommand);

        [InlineMethod("{0} camCommit {1}")]
        void camCommit(double timeInSecs);

        [InlineMethod("{0} camCommitPrepared {1}")]
        void camCommitPrepared(double timeInSecs);

        [InlineMethod("(camCommitted {0})")]
        bool camCommitted();

        [InlineMethod("{0} camConstuctionSetParams[{1}, {2}, {3}]")]
        void camConstuctionSetParams(IPosition pos, double radius, double maxAboveLand);

        [InlineMethod("camDestroy {0}")]
        void camDestroy();

        [InlineMethod("{0} cameraEffect[{0}, {1}]")]
        void cameraEffect(CamEffectType effectType, CamEffectPosition position);

        [InlineMethod("{0} camPreload {1}")]
        void camPreload(double time);

        [InlineMethod("(camPreloaded {0})")]
        bool camPreloaded();

        [InlineMethod("{0} camPrepareBank {1}")]
        void camPrepareBank(double bank);

        [InlineMethod("{0} camPrepareDir {1}")]
        void camPrepareDir(double dir);

        [InlineMethod("{0} camPrepareDive {1}")]
        void camPrepareDive(double dive);

        [InlineMethod("{0} camPrepareFocus [{1}, {2]}")]
        void camPrepareFocus(double distance, double blur);

        [InlineMethod("{0} camPrepareFocus [-1, 1]}")]
        void camPrepareFocusReset();

        [InlineMethod("{0} camPrepareFov {1}")]
        void camPrepareFov(double fieldOfView);

        [InlineMethod("{0} camPrepareFovRange [{1}, {2}]")]
        void camPrepareFovRange(double rangeMin, double rangeMax);

        [InlineMethod("{0} camPreparePos {1}")]
        void camPreparePos(IPosition position);

        [InlineMethod("{0} camPrepareRelPos {1}")]
        void camPrepareRelPos(IPosition position);

        [InlineMethod("{0} camPrepareTarget {1}")]
        void camPrepareTarget(IPosition position);

        [InlineMethod("{0} camSetBank {1}")]
        void camSetBank(double bank);

        [InlineMethod("{0} camSetDir {1}")]
        void camSetDir(double bank);

        [InlineMethod("{0} camSetDive {1}")]
        void camSetDive(double bank);

        [InlineMethod("{0} camSetFocus [{1}, {2]}")]
        void camSetFocus(double distance, double blur);

        [InlineMethod("{0} camSetFov {1}")]
        void camSetFov(double fieldOfView);

        [InlineMethod("{0} camSetFovRange [{1}, {2}]")]
        void camSetFovRange(double rangeMin, double rangeMax);

        [InlineMethod("{0} camSetPos {1}")]
        void camSetPos(IPosition position);

        [InlineMethod("{0} camSetRelPos {1}")]
        void camSetRelPos(IPosition position);

        [InlineMethod("{0} camSetTarget {1}")]
        void camSetTarget(IPosition position);

        [InlineMethod("(camTarget {0})")]
        IObject camTarget();
    }
}