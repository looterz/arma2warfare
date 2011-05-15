using System;
using Arma2.Script.Language;
using Arma2.Script.Language.Contracts;

namespace Arma2.Script.Language
{
    public class Vehicle : Mission, IVehicle
    {
        public int addEventHandler(string eventName, Contracts.EventHandler action)
        {
            throw new NotImplementedException();
        }

        public int addMPEventHandler(string eventName, Contracts.EventHandler action)
        {
            throw new NotImplementedException();
        }

        public bool alive()
        {
            throw new NotImplementedException();
        }

        public void allowDamage(bool allowDamage)
        {
            throw new NotImplementedException();
        }

        public void animate(string animationName, double phase)
        {
            throw new NotImplementedException();
        }

        public double animationPhase(string animationName, int phase)
        {
            throw new NotImplementedException();
        }

        public void attachTo(IObject attachTo)
        {
            throw new NotImplementedException();
        }

        public void attachTo(IObject attachTo, IPosition offset)
        {
            throw new NotImplementedException();
        }

        public void attachTo(IObject attachTo, IPosition offset, string memPoint)
        {
            throw new NotImplementedException();
        }

        public void addBackpackCargo(string packClassName, int count)
        {
            throw new NotImplementedException();
        }

        public void addMagazineCargo(string magazineName, int count)
        {
            throw new NotImplementedException();
        }

        public void addMagazineCargoGlobal(string magazineName, int count)
        {
            throw new NotImplementedException();
        }

        public void addMagazineTurret(string magazineName, string[] turretPath)
        {
            throw new NotImplementedException();
        }

        public void addWeaponCargo(string weaponName, int count)
        {
            throw new NotImplementedException();
        }

        public void addWeaponCargoGlobal(string weaponName, int count)
        {
            throw new NotImplementedException();
        }

        public double aimedAtTarget(IObject target)
        {
            throw new NotImplementedException();
        }

        public double aimedAtTarget(IObject target, string weapon)
        {
            throw new NotImplementedException();
        }

        public void assignAsCargo(IUnit unit)
        {
            throw new NotImplementedException();
        }

        public void assignAsCommander(IUnit unit)
        {
            throw new NotImplementedException();
        }

        public void assignAsGunner(IUnit unit)
        {
            throw new NotImplementedException();
        }

        public IUnit[] assignedCargo()
        {
            throw new NotImplementedException();
        }

        public IUnit assignedCommander()
        {
            throw new NotImplementedException();
        }

        public IUnit assignedDriver()
        {
            throw new NotImplementedException();
        }

        public IUnit assignedGunner()
        {
            throw new NotImplementedException();
        }

        public IObject assignedTarget()
        {
            throw new NotImplementedException();
        }

        public void assignTeam(TeamType team)
        {
            throw new NotImplementedException();
        }

        public double fuel()
        {
            throw new NotImplementedException();
        }
    }
}