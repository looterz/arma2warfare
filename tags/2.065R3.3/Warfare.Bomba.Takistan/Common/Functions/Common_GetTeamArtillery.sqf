#include "profiler.h"
PROFILER_BEGIN("Common_GetTeamArtillery");

Private["_weapon", "_artyType", "_artillery","_count","_destination","_ignoreAmmo","_index","_position","_search","_team","_units","_vehicle","_x","_y"];

_team = _this select 0;
_destination = _this select 1;
_ignoreAmmo = _this select 2;
_index = _this select 3;

if (isNil "_index") then { _index = 0; };

//format["team=%1 dest=%2 ignoreArrmo=%3 index=%4", _team, _destination, _ignoreAmmo, _index] call LogTrace;

_units = units _team;
_artyType = (artilleryNames select _index) select 0;

_artillery = [];
{
	_vehicle = vehicle _x;

	if (typeOf (_vehicle) == _artyType) then {	 
		if (!isNull (gunner _vehicle) && !(_vehicle in _artillery) && !(isPlayer gunner _vehicle)) then {
			_weapon = artilleryWeapons select _index;
			if (_ignoreAmmo || (_vehicle ammo _weapon != 0)) then {
				_artillery = _artillery + [_vehicle];
			};
		};
	};
} forEach _units;

//format["_artyList=%1", _artillery] call LogTrace;

PROFILER_END();
_artillery;