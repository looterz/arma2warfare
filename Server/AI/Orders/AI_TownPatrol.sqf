/* 
	Author: Benny
	Name: AI_TownPatrol.sqf
	Parameters:
	  0 - Team
	  1 - Town
	  2 - (Radius)
	Description:
	  This file is called upon a resistance / occupation patrol, AI will randomly patrol in towns, including the camps and the depots.
*/

#include "profiler.h"
PROFILER_BEGIN("Server_AIOrders_TownPatrol");

Private ['_u', '_isSufracePos', '_countUsable', '_camps','_insert','_insertObject','_insertStep','_maxWaypoints','_pos','_radius','_radius2''_team','_town','_townPos','_type','_update','_usable','_wpcompletionRadius','_wpradius','_wps'];
_team = _this select 0;
_town = _this select 1;
_radius = if (count _this > 2) then {_this select 2} else {30};
if (typeName _town != 'OBJECT') exitWith {
	Format ["AI_TownPatrol: Object expected, %1 given",_town] call LogError;
};
_townPos = getPos _town;

_camps = _town getVariable 'camps';

_usable = [_town] + _camps;
_countUsable = count _usable;

_maxWaypoints = ('WFBE_TOWNPATROLHOPS' Call GetNamespace) + _countUsable;
_wps = [];

if (random 100 > 50) then {_team setFormation "DIAMOND"} else {_team setFormation "STAG COLUMN"};
_team setBehaviour "AWARE";
_team setSpeedMode "LIMITED";
_team setCombatMode "YELLOW";

//--- Dyn insert.
_insertStep = if (_countUsable != 0) then {floor(_maxWaypoints / _countUsable)} else {-1};
_insert = _insertStep;
_insertObject = objNull;
_wpradius = -1;
_wpcompletionRadius = -1;

_radius2 = _radius * 2;

_u = _maxWaypoints;
_x = 0;

while { !(_u == 0) } do {
	_u = _u - 1;

	if (_x == _insert && _countUsable > 0) then {
		_insert = _insert + _insertStep;
		_insertObject = _usable select (round(random((_countUsable)-1)));
		_usable = _usable - [_insertObject];
		_countUsable = _countUsable - 1;
	};

	if (isNull _insertObject) then {

		_isSufracePos = false;
		while { !_isSufracePos } do {
			_rand1 = (random (_radius2)) - _radius;
			_rand2 = (random (_radius2)) - _radius;
			_pos = [(_townPos select 0)+_rand1, (_townPos select 1)+_rand2, 0];
			
			_isSufracePos = if (surfaceIsWater _pos) then { false } else { true };			
		};
		_wpradius = 32;
		_wpcompletionRadius = 44;
	} else {
		_pos = getPos _insertObject;
		_wpradius = 35;
		_wpcompletionRadius = 68;
	};
	
	_type = if (_u != 0) then {'MOVE'} else {'CYCLE'};
	_wps = _wps + [[_pos,_type,_wpradius,_wpcompletionRadius]];
	
	_x = _x + 1;
};

Format["AI_TownPatrol: The %1 %2 Team is patrolling the %3 town",side _team,_team,_town] call LogInform;
[_team, true, _wps] Call AIWPAdd;
PROFILER_END();