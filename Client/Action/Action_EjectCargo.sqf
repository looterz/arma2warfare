_vehicle = _this select 0;
_unit = _this select 1;

_cargo = (crew _vehicle) - [driver _vehicle, gunner _vehicle, commander _vehicle];

_i = 0;
_c = count _cargo;

while {_i < _c} do {
	_u = _cargo select _i;
	_group = group _u;
	if ((alive _u) && _vehicle == (vehicle _u)) then {if (local _u) then {unassignVehicle _u; _u action ["EJECT", _vehicle]}};
	sleep 1;
	_i = _i + 1;
};