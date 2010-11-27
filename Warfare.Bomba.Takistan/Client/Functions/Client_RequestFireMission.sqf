private['_destination', '_index', '_type', '_units', '_reloadTime', '_burst', '_u', "_fired"];

_destination = _this Select 0;
_index = _this Select 1;
_type = 0;

ScopeName "FireMission";

_units = [Group player,_destination,false,_index] Call GetTeamArtillery;

if (count _units < 1) exitWith {};
_type = (artilleryNames select _index) find (typeOf (_units select 0));

if (_type < 0) exitWith {_type};
_reloadTime = artilleryReloadTimes select _index;
_burst = artilleryBurst select _index;

{[_x] Call ARTY_Prep} forEach _units;

while { !(_burst == 0) } do {
	_burst = _burst - 1;
	
	_units = [Group player,_destination,false,_index] Call GetTeamArtillery;
	
	_u = count _units;
	if (_u < 1) then {BreakTo "FireMission"};
	
	while { !(_u == 0) } do {
		_u = _u - 1;
		[_units select _u, _destination, side player, artyRange, _index] call FireArtillery;
	};

	sleep _reloadTime;
};

{ (gunner _x) DoWatch [0, 0, 0]; } forEach _units;

//Keep weapons reloaded.
_units = [Group player,_destination,true,_index] Call GetTeamArtillery;
{if (!someAmmo _x) then {_x Call RearmVehicle}} ForEach _units;

{[_x] Call ARTY_Finish} forEach _units;