#include "profiler.h"
PROFILER_BEGIN("Common_GetTeamArtillery");
private['_artillery','_artyTypes','_destination','_ignoreAmmo','_index','_side','_team','_units','_vehicle','_artyweapons','_weapon'];

_team = _this select 0;
_destination = _this select 1;
_ignoreAmmo = _this select 2;
_index = _this select 3;
_side = _this select 4;

if (isNil "_index") then { _index = 0; };
_units = units _team;
_artyTypes = (Format ["WFBE_%1_ARTILLERY_NAMES",_side] Call GetNamespace) select _index;
_artyWeapons = Format ["WFBE_%1_ARTILLERY_WEAPONS",_side] Call GetNamespace;

_artillery = [];
{
	_vehicle = vehicle _x;

	if (typeOf (_vehicle) in _artyTypes) then {	 
		if (!(isNull(gunner _vehicle)) && !(_vehicle in _artillery) && !(isPlayer(gunner _vehicle))) then {
			if !(isPlayer(gunner _vehicle)) then {
				_weapon = _artyWeapons select _index;

			if (_ignoreAmmo || (_vehicle ammo _weapon > 0)) then {
				_artillery = _artillery + [_vehicle];
			};
		};
	};
	};
} forEach _units;

//format["_artyList=%1", _artillery] call LogTrace;

PROFILER_END();
_artillery;