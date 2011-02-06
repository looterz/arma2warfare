#include "profiler.h"
PROFILER_BEGIN("Server_AIOrders_Patrol");

private['_destination','_maxWaypoints','_pos','_radius','_radius2','_team','_type','_update','_wps','_u'];
_team = _this select 0;
_destination = _this select 1;
_radius = if (count _this > 2) then {_this select 2} else {30};
if (typeName _destination == 'OBJECT') then {_destination = getPos _destination};

_update = true;
if (side _team == west || side _team == east) then {
	_update = (_team) Call CanUpdateTeam;
};

//--- Override.
if (_update) then {_team Call UpdateTeam};

_maxWaypoints = 8;
_wps = [];

_u = _maxWayPoints;
_radius2 = _radius * 2;
_pos = [];

while { !(_u == 0) } do {
	_u = _u - 1;
	
	_pos = [_townPos, 5, _radius] call GetRandomPosition;

	_type = if (_u != 0) then {'MOVE'} else {'CYCLE'};
	_wps = _wps + [[_pos,_type,35,40]];
};

Format["AI_Patrol: The %1 %2 Team is patrolling at %3",side _team,_team,_destination] call LogHigh;

[_team, true, _wps] Call AIWPAdd;

PROFILER_END();