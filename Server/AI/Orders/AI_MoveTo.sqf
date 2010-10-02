Private ["_destination","_formations","_mission","_radius","_team","_update"];
_team = _this select 0;
_destination = _this select 1;
_mission = _this select 2;
_radius = if (count _this > 3) then {_this select 3} else {30};

_update = true;
if (side _team == west || side _team == east) then {
	_update = (_team) Call CanUpdateTeam;
};

//--- Override.
if (_update) then {
	_formations = ['FILE','DIAMOND','STAG COLUMN','WEDGE'];
	_team setFormation (_formations select round(random(count _formations -1)));
	_team setBehaviour "AWARE";
	_team setSpeedMode "NORMAL";
	_team setCombatMode "YELLOW";
};

diag_log Format["[WFBE (INFORMATION)] AI_MoveTo: The %1 %2 Team is moving to %3",side _team,_team,_destination];

[_team,true,[[_destination, _mission, _radius, 20]]] Call AIWPAdd;