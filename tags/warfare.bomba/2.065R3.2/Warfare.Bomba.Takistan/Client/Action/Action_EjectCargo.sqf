_vehicle = _this select 0;

_cargo = (crew _vehicle) - [driver _vehicle, gunner _vehicle, commander _vehicle];

{
	if (alive _x && _vehicle == vehicle _x && local _x) then {
		unassignVehicle _x;
		_x action ["EJECT", _vehicle];
};
	sleep 1;
} forEach _cargo;