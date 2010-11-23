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

_fnTownPatrol_BuildGrid = {
private['_centerPos', '_radius', '_grid', '_gridStep', '_posX', '_posY', '_uX', '_uY', '_pos' ];

PROFILER_BEGIN("Server_AIOrders_TownPatrol::BuildGrid");

	_centerPos = _this select 0;
	_radius = _this select 1;

	_grid = [];
	_gridStep = (_radius * 2) / 32;

	_posY = (_centerPos select 1) - _radius;
	_uY = 32;
	while { _uY != 0 } do {
		_uY = _uY - 1;
		
		_posX = (_centerPos select 0) - _radius;
		_uX = 32;
		while { _uX != 0} do {
			_uX = _uX - 1;
			
			_pos = [_posX, _posY, 0];
			if ( !(surfaceIsWater _pos) ) then {
				_grid = _grid + [ _pos ];				
			};
			_posX = _posX + _gridStep;
		};
		_posY = _posY + _gridStep;
	};
	
PROFILER_END();	
	_grid;
};

_fnTownPatrol_GetWaypointGrid = {
private["_radius", "_town", "_grid", "_waypointGridData", "_u", "_gridItem", "_gridRadius", "_bFound" ];

PROFILER_BEGIN("Server_AIOrders_TownPatrol::GetWaypointGrid");

	_town = _this select 0;
	_radius = _this select 1;
	_grid = objNull;

	format["GetWaypointGrid Town:%1 R:%2", _town, _radius] call LogHigh;
	
	_waypointGridData = _town getVariable 'WaypointGridData';
	if (isNil "_waypointGridData") then {
		_waypointGridData = [];
		_town setVariable ['WaypointGridData', _waypointGridData];
	};
	
	format["GetWaypointGrid :: _waypointGridData.count=%1", (count _waypointGridData) ] call LogHigh;
	
	_bFound = false;
	_u = count _waypointGridData;
	while { _u != 0 } do {
		_u = _u - 1;
		_gridItem = _waypointGridData select _u;
		
		_gridRadius = _gridItem select 0;
		if (_gridRadius == _radius) then {
		
			waitUntil { (typeName (_gridItem select 1)) == 'ARRAY' };
			_grid = _gridItem select 1;
			_u = 0;
			_bFound = true;
		};
	};
	
	if (!_bFound) then {

		_gridItem = [ _radius, objNull ];
		
		_waypointGridData = _town getVariable 'WaypointGridData';	// get again grid data array, becouse it can be change at another thread;
		_waypointGridData = _waypointGridData + [ _gridItem ];
		_town setVariable ['WaypointGridData', _waypointGridData];

		_grid = [(position _town), _radius] call _fnTownPatrol_BuildGrid;
		_gridItem = _gridItem set [1, _grid];

	};
	
PROFILER_END();	
	_grid;
};


Private ["_wppos", "_u", "_wpid", "_type", "_target",  "_patrolTargetNext", "_waypointGridData", "_waypointGridDataNodeCount",  "_team", "_town", "_radius", "_camps", "_partolTargets", "_partolTargetsCount", "_maxWaypoints", "_wps", "_patrolTargetNextStep", "_wpradius", "_wpcompletionRadius", "_patrolTarget"];
_team = _this select 0;
_town = _this select 1;
_radius = if (count _this > 2) then {_this select 2} else {30};

if (typeName _town != 'OBJECT') exitWith {
	Format ["AI_TownPatrol: Object expected, %1 given",_town] call LogError;
	PROFILER_END();
};

_camps = _town getVariable 'camps';

_partolTargets = [_town] + _camps;
_partolTargetsCount = count _partolTargets;
_maxWaypoints = _countPatrolTargets + ('WFBE_TOWNPATROLHOPS' Call GetNamespace);

_wps = [];

if (random 100 > 50) then {_team setFormation "DIAMOND"} else {_team setFormation "STAG COLUMN"};
_team setBehaviour "AWARE";
_team setSpeedMode "LIMITED";
_team setCombatMode "YELLOW";

//--- Dyn insert.
_patrolTargetNextStep = if (_partolTargetsCount != 0 && _maxWaypoints != 0) then { floor(_maxWaypoints / _partolTargetsCount) } else {-1};

_wpradius = -1;
_wpcompletionRadius = -1;
_wppos = [];

_u = _maxWaypoints;

_patrolTarget = objNull;
_patrolTargetNext = _patrolTargetNextStep;

_waypointGridData = [_town, _radius] call _fnTownPatrol_GetWaypointGrid;
_waypointGridDataNodeCount = count _waypointGridData;

while { _u != 0 } do {
	_u = _u - 1;

	if (_partolTargetsCount != 0 && _u == _patrolTargetNext) then {
	
		_patrolTargetNext = _patrolTargetNext - _patrolTargetNextStep;
		_wpid = round(random(_partolTargetsCount - 1));
		_target = _partolTargets select _wpid;
		_partolTargets set [_wpid, objNull ];
		
		_partolTargets = _partolTargets - [ objNull ];
		_partolTargetsCount = count _partolTargets;
		
		_wppos = getPos _target;
		_wpradius = 35;
		_wpcompletionRadius = 68;	
		
	} else {
	
		_wpid = round( random( _waypointGridDataNodeCount - 1 ) );
		_wppos = _waypointGridData select _wpid;
		
		_wpradius = 32;
		_wpcompletionRadius = 44;
	};
	
	_type = if (_u != 0) then {'MOVE'} else {'CYCLE'};
	_wps = _wps + [[_wppos,_type,_wpradius,_wpcompletionRadius]];
};

Format["AI_TownPatrol: The %1 %2 Team is patrolling the %3 town",side _team, _team, _town] call LogInform;
[_team, true, _wps] spawn AIWPAdd;
PROFILER_END();