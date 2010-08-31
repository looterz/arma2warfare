Private ["_action","_position","_range","_team"];
_team = _this select 0;
_position = _this select 1;
_range = _this select 2;
_action = _this select 3;

switch (_action) do {
	case "Patrol": {[_team,_position,_range] Call BIS_fnc_taskPatrol};
	case "Defend": {
		_mission = "sad";
		_team setFormation "STAG COLUMN";
		_team setBehaviour "AWARE";
		_team setSpeedMode "NORMAL";
		 _wp = _team addWaypoint [_position, _range];
		[_team, 0] setWaypointType _mission;
		_team setCurrentWaypoint [_team, 0];
	};
	case "CPatrol": {[_team,_position,_range] Spawn AIPatrol};
};