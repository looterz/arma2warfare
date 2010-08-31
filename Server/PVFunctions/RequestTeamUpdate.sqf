Private["_properties","_side","_sideTeam","_team"];

_side = _this select 0;
_properties = _this select 2;
_team = _this select 3;

//--- One team.
if (typeName _team == "GROUP") then {
	_team setBehaviour (_properties select 0 );
	_team setCombatMode (_properties select 1);
	_team setFormation (_properties select 2 );
	_team setSpeedMode (_properties select 3 );
};

//--- The whole team.
if (typeName _team == "SIDE") then {
	_sideTeam = (Format["WFBE_%1TEAMS",str _side] Call GetNamespace);
	{
		_x setBehaviour (_properties select 0 );
		_x setCombatMode (_properties select 1);
		_x setFormation (_properties select 2 );
		_x setSpeedMode (_properties select 3 );		
	} forEach _sideTeam;
};