#include "profiler.h"
PROFILER_BEGIN("Server_AIOrders_MoveTo");

private['_destination','_mission','_radius','_team','_update'];
_team = _this select 0;
_destination = _this select 1;
_mission = _this select 2;
_radius = if (count _this > 3) then {_this select 3} else {30};

_update = true;
if (side _team == west || side _team == east) then {
	_update = (_team) Call CanUpdateTeam;
};

//--- Override.
if (_update) then {_team Call UpdateTeam};

Format["AI_MoveTo: The %1 %2 Team is moving to %3",side _team,_team,_destination] call LogInform;

[_team,true,[[_destination, _mission, _radius, 20]]] Call AIWPAdd;

PROFILER_END();