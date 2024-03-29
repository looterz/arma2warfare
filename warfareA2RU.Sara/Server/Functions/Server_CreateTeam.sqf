Private ['_commander','_crews','_ctype','_driver','_gunner','_list','_lockVehicles','_position','_side','_team','_type','_unit','_units','_vehicle','_vehicles'];

_list = _this select 0;
_position = _this select 1;
_side = _this select 2;
_lockVehicles = _this select 3;
_team = if (count _this > 4) then {_this select 4} else {objNull};
_units = [];
_vehicles = [];
_crews = [];

//--- Create a group if none are given as a parameter.
if (isNull _team) then {_team = createGroup _side};

_ctype = switch (_side) do {case West: {'WEST'}; case East: {'EAST'}; case Resistance: {'GUER'}};

//--- Create.
{
	if (_x isKindOf 'Man') then {
		_unit = [_x,_team,_position,_side] Call CreateMan;
		_units = _units + [_unit];
	} else {
		_vehicle = [_x,_position,_side,_lockVehicles] Call CreateVehi;
		_type = if (_vehicle isKindOf 'Man') then {Format ['WFBE_%1SOLDIER',_ctype] Call GetNamespace} else {if (_vehicle isKindOf 'Air') then {Format ['WFBE_%1PILOT',_ctype] Call GetNamespace} else {Format ['WFBE_%1CREW',_ctype] Call GetNamespace}};
		if (_vehicle emptyPositions 'driver' > 0) then {_driver = [_type,_team,_position,_side] Call CreateMan;_driver moveInDriver _vehicle;_crews = _crews + [_driver]};
		if (_vehicle emptyPositions 'gunner' > 0) then {_gunner = [_type,_team,_position,_side] Call CreateMan;_gunner moveInGunner _vehicle;_crews = _crews + [_gunner]};
		if (_vehicle emptyPositions 'commander' > 0) then {_commander = [_type,_team,_position,_side] Call CreateMan;_commander moveInCommander _vehicle;_crews = _crews + [_commander]};
		_vehicles = _vehicles + [_vehicle];
	};
} forEach _list;

//--- Add vehicles.
{
	_team addVehicle _x;
} forEach _vehicles;

[_units,_vehicles,_team,_crews]