#include "profiler.h"
PROFILER_BEGIN("Common_RearmVehicleOA");

Private['_amount','_magazines','_turrets','_vehicle'];

_vehicle = _this;

/* Clear the vehicle */
_vehicle setVehicleAmmo 0;

/* Reload all turrets */
_turrets = [];
_config = configFile >> 'CfgVehicles' >> typeOf _vehicle >> 'Turrets';
_turrets = [_config] call GetTurretsMags;
[_vehicle,_turrets] Call SetTurretsMags;
/* Reload the driver (Special) */

_magazines = [configFile >> 'CfgVehicles' >> typeOf _vehicle] call GetVehicleMags;
{_vehicle addMagazineTurret[_x,[-1]]} forEach _magazines;

reload _vehicle;

if (paramCounterMeasures && _vehicle isKindOf 'Air') then {
	_amount = if (_vehicle isKindOf 'Plane') then {'WFBE_COUNTERMEASUREPLANES' Call GetNamespace} else {'WFBE_COUNTERMEASURECHOPPERS' Call GetNamespace};
	_vehicle setVariable ['FlareCount', _amount];
};

if ((typeOf _vehicle) in ('WFBE_BALANCEDUNITS' Call GetNamespace) && paramBalancing) then {[_vehicle] Call BalanceInit};

if (paramEASA) then {
	if ((typeOf _vehicle) in ('WFBE_EASA_Vehicles' Call GetNamespace)) then {
		_get = _vehicle getVariable 'WFBE_EASA_Setup';
		if !(isNil '_get') then {[_vehicle,0] Call EASA_Equip};
	};
};

PROFILER_END();