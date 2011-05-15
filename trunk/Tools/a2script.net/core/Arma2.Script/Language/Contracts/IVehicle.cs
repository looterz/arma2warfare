using Arma2.Script.Language;
using Arma2.Script.Compiler.Sqf.Attributes;

namespace Arma2.Script.Language.Contracts
{
    public interface IVehicle : IObject
    {
        [InlineMethod("{0} addBackpackCargo[{1}, {2}]")]
        void addBackpackCargo(string packClassName, int count);

        /// <summary>
        /// Add magazines to the cargo space of vehicles, which can be taken out by infantry units
        /// Once the magazine cargo space is filled up, any further addMagazineCargo commands are ignored
        /// </summary>
        /// <param name="magazineName">Magazine name</param>
        /// <param name="count">Number of magazines to add</param>
        [InlineMethod("{0} addMagazineCargo[{1}, {2}]")]
        void addMagazineCargo(string magazineName, int count);

        /// <summary>
        /// Add magazines to the cargo space of vehicles, which can be taken out by infantry units.
        /// </summary>
        /// <param name="magazineName">Magazine name</param>
        /// <param name="count">Number of magazines to add</param>
        [InlineMethod("{0} addMagazineCargoGlobal[{1}, {2}]")]
        void addMagazineCargoGlobal(string magazineName, int count);

        /// <summary>
        /// Add icon to a group. Returns icon ID
        /// </summary>
        [InlineMethod("{0} addMagazineTurret[{1}, {2}]")]
        void addMagazineTurret(string magazineName, string[] turretPath);

        [InlineMethod("{0} addWeaponCargo[{1}, {2}]")]
        void addWeaponCargo(string weaponName, int count);

        [InlineMethod("{0} addWeaponCargoGlobal[{1}, {2}]")]
        void addWeaponCargoGlobal(string weaponName, int count);

        [InlineMethod("{0} aimedAtTarget[{1}}]")]
        double aimedAtTarget(IObject target);

        [InlineMethod("{0} aimedAtTarget[{1}, {2}]")]
        double aimedAtTarget(IObject target, string weapon);


        [InlineMethod("{1} assignAsCargo {0}")]
        void assignAsCargo(IUnit unit);

        [InlineMethod("{1} assignAsCommander {0}")]
        void assignAsCommander(IUnit unit);

        [InlineMethod("{1} assignAsGunner {0}")]
        void assignAsGunner(IUnit unit);

        [InlineMethod("assignedCargo {0}")]
        IUnit[] assignedCargo();

        [InlineMethod("assignedCommander {0}")]
        IUnit assignedCommander();

        [InlineMethod("assignedDriver {0}")]
        IUnit assignedDriver();

        [InlineMethod("assignedGunner {0}")]
        IUnit assignedGunner();

        [InlineMethod("assignedTarget {0}")]
        IObject assignedTarget();

        [InlineMethod("{0} assignTeam {1}")]
        void assignTeam(TeamType team);

        [InlineMethod("fuel {0}")]
        double fuel();
    }
}