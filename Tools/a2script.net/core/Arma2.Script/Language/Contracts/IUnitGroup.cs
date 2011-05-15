using System;
using Arma2.Script.Compiler.Sqf.Attributes;

namespace Arma2.Script.Language.Contracts
{
    public interface IUnitGroup
    {
        [InlineMethod("{0} addGroupIcon[{1}]")]
        int addGroupIcon(string name);

        [InlineMethod("{0} addGroupIcon[{1}, [{2}, {3}]]")]
        int addGroupIcon(string name, double offsetX, double offsetY);

        [InlineMethod("{0} addVehicle {1}")]
        void addVehicle(string vehicleName);

        [InlineMethod("{0} addWaypoint [{1}, {2}]")]
        IWaypoint[] addWaypoint(IPosition pos, double radius);

        [InlineMethod("{0} addWaypoint [{1}, {2}, {3}]")]
        IWaypoint[] addWaypoint(IPosition pos, double radius, int index);

        [InlineMethod("{0} addWaypoint [{1}, {2}]")]
        IWaypoint[] addWaypoint(double[] pos, double radius);

        [InlineMethod("{0} addWaypoint [{1}, {2}, {3}]")]
        IWaypoint[] addWaypoint(double[] pos, double radius, int index);

        [InlineMethod("{0} allowFleeing {1}")]
        void allowFleeing(double cowardice);

        [InlineMethod("attackEnabled {0}")]
        bool attackEnabled();
    }
}