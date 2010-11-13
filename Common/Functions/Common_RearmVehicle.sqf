#include "profiler.h"
PROFILER_BEGIN("Common_RearmVehicle");

Private["_amount","_magazines","_vehicle"];

_vehicle = _this;

//rearming turrets.
{_vehicle RemoveMagazine _x} ForEach Magazines _vehicle;

_magazines = GetArray (configFile >> "CfgVehicles" >> typeOf _vehicle >> "Turrets" >> "MainTurret" >> "Magazines");
_magazines = _magazines + GetArray (configFile >> "CfgVehicles" >> typeOf _vehicle >> "Magazines");

{_vehicle AddMagazine _x} ForEach _magazines;

if (paramCounterMeasures && _vehicle isKindOf "Air") then {
	_amount = if (_vehicle isKindOf "Plane") then {'WFBE_COUNTERMEASUREPLANES' Call GetNamespace} else {'WFBE_COUNTERMEASURECHOPPERS' Call GetNamespace};
	_vehicle setVariable ["FlareCount", _amount];
};

_vehicle setVehicleAmmo 1;
Reload _vehicle;

if ((typeOf _vehicle) in ('WFBE_BALANCEDUNITS' Call GetNamespace) && paramBalancing) then {[_vehicle] Call BalanceInit};
if (paramEASA) then {
	if ((typeOf _vehicle) in ('WFBE_EASA_Vehicles' Call GetNamespace)) then {
		_get = _vehicle getVariable 'WFBE_EASA_Setup';
		if !(isNil '_get') then {[_vehicle,0] Call EASA_Equip};
	};
};

PROFILER_END();