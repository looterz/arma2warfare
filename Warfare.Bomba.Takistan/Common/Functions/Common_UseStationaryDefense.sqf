#include "profiler.h"
PROFILER_BEGIN("Common_UseStationaryDefense");

private['_count','_defense','_defenseTypes','_emptyDefenses','_range','_total','_totalDefenses','_unit','_units','_defenses'];
_units = _this select 0;
_range = _this select 1;

_total = count _units;
if (_total < 1) exitWith {
	"[WFBE (ERROR)] Common_UseStationaryDefense.sqf: No units were specified" call LogError;
	PROFILER_END();
};

_defenseTypes = Format["WFBE_%1DEFENSENAMES",side leader group (_units select 0)] Call GetNamespace;
_defenses = (leader group (_units select 0)) nearEntities[_defenseTypes,_range];

_emptyDefenses = [];

{if (_x EmptyPositions "gunner" > 0) then {_emptyDefenses = _emptyDefenses + [_x]}} forEach _defenses;

for [{_count = 0},{_count < _total},{_count = _count + 1}] do
{
	_unit = _units select _count;

	_totalDefenses = count _emptyDefenses;
	if (_totalDefenses < 1) exitWith {
		PROFILER_END();
	};

	//If not in a vehicle then check for available defense.
	if (alive _unit && _unit == vehicle _unit) then
	{
		_defense = _emptyDefenses select (_totalDefenses - 1);

		[_unit] allowGetIn true;
		_unit assignAsGunner _defense;
		_emptyDefenses = _emptyDefenses - [_defense];
	};
};

PROFILER_END();