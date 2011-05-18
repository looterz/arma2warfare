using Arma2.Script.Attributes;
using Arma2.Script.Language.Types;

namespace Arma2.Script.Language.Contracts
{
    [Script]
    public interface IUnit : IObject
    {
        [InlineMethod("{0} action[{1}, {2}]")]
        double action(string actionName, object arg0);

        [InlineMethod("{0} action[{1}, {2}, {3}]")]
        double action(string actionName, object arg0, object arg1);

        [InlineMethod("{0} action[{1}, {2}, {3}, {4}]")]
        double action(string actionName, object arg0, object arg1, object arg2);

        [InlineMethod("{0} addAction[{1}, {2}, {3}, {4}, {5}, {6}, {7}, {8}]")]
        int addAction(string title, string fileName, object arguments, int priority, bool showWindow, bool hideOnUse, string shortCut, string condition);

        [InlineMethod("{0} addBackpack {1}")]
        void addBackpack(string packClassName);

        [InlineMethod("{0} addLiveStats {1}")]
        void addLiveStats(int score);

        [InlineMethod("{0} addMagazine {1}")]
        void addMagazine(string magazineName);

        [InlineMethod("{0} addRating {1}")]
        void addRating(int rating);

        [InlineMethod("{0} addRating {1}")]
        int addResources(object teamMember, object[] resources);

        [InlineMethod("{0} addScore {1}")]
        void addScore(int score);

        [InlineMethod("{0} addWeapon {1}")]
        void addWeapon(string weaponName);

        [InlineMethod("{0} allowFleeing {1}")]
        void allowFleeing(double cowardice);

        [InlineMethod("[{0}] allowGetIn {1}")]
        void allowGetIn(bool allowGetIn);

        [InlineMethod("{0} ammo {1}")]
        int ammo(string weaponName);

        [InlineMethod("animationState {0}")]
        string animationState();

        [InlineMethod("assignedVehicle {0}")]
        IVehicle assignedVehicle();

        [InlineMethod("assignedVehicleRole {0}")]
        string[] assignedVehicleRole();

        [InlineMethod("attackEnabled {0}")]
        bool attackEnabled();

        [InlineMethod("backpack {0}")]
        IBackpack backpack();

        [InlineMethod("behaviour {0}")]
        BehaviourType behaviour();

        [InlineMethod("canFire {0}")]
        bool canFire();

        [InlineMethod("canMove {0}")]
        bool canMove();

        [InlineMethod("canStand {0}")]
        bool canStand();

        [InlineMethod("captive {0}")]
        bool captive();

        [InlineMethod("captiveNum {0}")]
        int captiveNum();

        [InlineMethod("(getPos {0})")]
        IPosition getPos();

        [InlineMethod("{0} setPos {1}")]
        void setPos(IPosition pos);

        [InlineMethod("vehicle {0}")]
        IVehicle vehicle();
    }
}