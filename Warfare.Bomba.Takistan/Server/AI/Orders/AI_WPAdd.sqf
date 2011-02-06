/* 
	Author: Benny
	Name: AI_WPAdd.sqf
	Parameters:
	  0 - Team
	  1 - Clear (Remove WPs)
	  2 - Waypoints (given in an Array)
	Description:
	  This file is used to give a detailed WP system.
	Exemple:
	  [_team, true, [[getPos _camp, 'MOVE', 10, 20],[[1560,2560,0], 'SAD', 50, 70]...]] Call AddWP;
*/

#include "profiler.h"
PROFILER_BEGIN("Server_AIOrders_WPAdd");

private['_clear','_completionRadius','_position','_radius','_team','_type','_waypoint','_waypoints','_index'];
_team = _this select 0;
_clear = _this select 1;
_waypoints = _this select 2;

if (_clear) then {_team Call AIWPRemove};

_index = count (waypoints _team);
{
	_position = _x select 0;
	_type = _x select 1;
	_radius = if (count _x > 2) then {_x select 2} else {10};
	_completionRadius = if (count _x > 3) then {_x select 3} else {25};
	if (typeName _position == 'OBJECT') then {_position = getPos _position};
	
	_waypoint = _team addWaypoint [_position,_radius];
	[_team, _index] setWaypointType _type;
	[_team, _index] setWaypointCompletionRadius _completionRadius;
	
	if (_index == 0) then {
		_team setCurrentWaypoint [_team, _index];
	};
	_index = _index + 1;
} forEach _waypoints;

PROFILER_END();