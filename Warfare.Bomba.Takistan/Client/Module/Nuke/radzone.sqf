//--- Radiation


private ["_target"];
_target = _this select 0;
[_target] Spawn {
	private ["_dammageable","_target","_x","_array"];
	_target = _this select 0;
	_dammageable = ["Man","Car","Motorcycle","Tank","Ship","Air","StaticWeapon"];
	for [{_x = 0},{_x < 300},{_x = _x + 1}] do {
		_array = _target nearEntities [_dammageable, 1000];
		{
			_x setDammage (getDammage _x +  0.03);
			{_x setDammage  (getDammage _x + 0.05)} forEach crew _x;
		} forEach _array;
		sleep (3 + random 3);
	};
	deleteVehicle _target;
};