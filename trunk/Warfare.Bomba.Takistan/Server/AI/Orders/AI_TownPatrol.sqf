/* 
	Author: Benny
	Modified: Bomba - perfomance optimisation
	
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

private['_wppos','_pos','_u','_wpid','_type','_target','_patrolTargetNext','_team','_town','_radius','_camps','_partolTargets','_partolTargetsCount','_maxWaypoints','_wps','_patrolTargetNextStep','_wpradius','_wpcompletionRadius','_patrolTarget','_townpos'];
_team = _this select 0;
_town = _this select 1;
_radius = if (count _this > 2) then {_this select 2} else {30};
if (typeName _town != 'OBJECT') exitWith {
	Format ["AI_TownPatrol: Object expected, %1 given",_town] call LogError;
	PROFILER_END();
};

if (isNull _team) exitWith {
	Format ["AI_TownPatrol: Null Groups cannot be used (Town: %1)",_town] call LogError;
};
_townPos = getPos _town;

_camps = _town getVariable 'camps';

_partolTargets = [_town] + _camps;
_partolTargetsCount = count _partolTargets;
_maxWaypoints = _partolTargetsCount + ('WFBE_TOWNPATROLHOPS' Call GetNamespace);

_wps = [];

//--- Randomize the behaviours.
if (random 100 > 50) then {_team setFormation "DIAMOND"} else {_team setFormation "STAG COLUMN"};
if (random 100 > 50) then {_team setCombatMode "YELLOW"} else {_team setCombatMode "RED"};
if (random 100 > 50) then {_team setBehaviour "AWARE"} else {_team setBehaviour "COMBAT"};
if (random 100 > 50) then {_team setSpeedMode "NORMAL"} else {_team setSpeedMode "LIMITED"};

//--- Dyn insert.
_patrolTargetNextStep = if (_partolTargetsCount != 0 && _maxWaypoints != 0) then { floor(_maxWaypoints / _partolTargetsCount) } else {-1};

_wpradius = -1;
_wpcompletionRadius = -1;
_wppos = [];

_u = _maxWaypoints;

_patrolTarget = objNull;
_patrolTargetNext = _maxWaypoints - _patrolTargetNextStep;

_pos = getPos _town;

while { _u != 0 } do {
	_u = _u - 1;

	if (_partolTargetsCount != 0 && _u == _patrolTargetNext) then {
	
		_patrolTargetNext = _patrolTargetNext - _patrolTargetNextStep;
		_wpid = floor(random(_partolTargetsCount));
		_target = _partolTargets select _wpid;
		_partolTargets set [_wpid, objNull ];
		
		_partolTargets = _partolTargets - [ objNull ];
		_partolTargetsCount = count _partolTargets;
		
		_wppos = getPos _target;
		_wpradius = 35;
		_wpcompletionRadius = 68;	
		
	} else {
	
		_wppos = [_pos, 10, _radius] call GetRandomPosition;		
		_wpradius = 32;
		_wpcompletionRadius = 44;
	};
	
	_type = if (_u != 0) then {'MOVE'} else {'CYCLE'};
	_wps = _wps + [[_wppos,_type,_wpradius,_wpcompletionRadius]];
};

[_team, true, _wps] spawn AIWPAdd;
Format["AI_TownPatrol: The %1 %2 Team is patrolling the %3 town",side _team, _team, _town] call LogHigh;
PROFILER_END();