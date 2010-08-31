Private ["_commander","_destination","_mission","_radius","_side","_team","_update"];
_team = _this select 0;
_destination = _this select 1;
_mission = _this select 2;
_radius = 30;
if (count _this > 3) then {_radius = _this select 3};

_team Call AIWPRemove;

//--- Detect whether a human commander exist or not.
_update = true;
if (_team in ('WFBE_WESTTEAMS' Call GetNamespace) || _team in ('WFBE_EASTTEAMS' Call GetNamespace)) then {
	_side = side _team;
	if (_side == west || _side == east) then {
		_commander = (_side) Call GetCommanderTeam;
		if (!isNull _commander) then {_update = false};
	};
};

//--- Override.
if (_update) then {
	_team setFormation "LINE";
	_team setBehaviour "AWARE";
	_team setSpeedMode "FULL";
	_team setCombatMode "YELLOW";
};

_wp = _team addWaypoint [_destination,_radius];
[_team, 0] setWaypointType _mission;
_team setCurrentWaypoint [_team, 0];