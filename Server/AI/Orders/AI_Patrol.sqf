Private ["_commander","_destination","_maxWaypoints","_pos","_radius","_side","_team","_type","_update"];
_team = _this select 0;
_destination = _this select 1;
_radius = 30;
if (count _this > 2) then {_radius = _this select 2};
if (typeName _destination == 'OBJECT') then {_destination = getPos _destination};

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
	_team setBehaviour "SAFE";
	_team setSpeedMode "LIMITED";
	_team setCombatMode "YELLOW";
};

_maxWaypoints = 8;
for [{_x=0},{_x<=_maxWaypoints},{_x=_x+1}] do {
	_rand1 = random _radius - random _radius;
	_rand2 = random _radius - random _radius;
	_pos = [(_destination select 0)+_rand1,(_destination select 1)+_rand2,0];
	while {surfaceIsWater _pos} do {
		_rand1 = random _radius - random _radius;
		_rand2 = random _radius - random _radius;
		_pos = [(_destination select 0)+_rand1,(_destination select 1)+_rand2,0];
	};
	_wp = _team addWaypoint [_pos,10];
	_type = "MOVE";
	if (_x == _maxWaypoints) then {_type = "CYCLE"};
	[_team,_x] setWaypointType _type;
	[_team,_x] setWaypointCompletionRadius 30;
	if (_x == 0) then {_team setCurrentWaypoint [_team, _x]};
};