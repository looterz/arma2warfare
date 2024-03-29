//--- Nuke destruction.


private ["_destroy","_bo","_target","_array","_blackListed"];
_target = _this select 0;
_array = _target nearObjects ["All", 700];
_blackListed = WFDEPOT + WFCAMP + ["land_nav_pier_c","land_nav_pier_c2","land_nav_pier_c2_end","land_nav_pier_c_270","land_nav_pier_c_90","land_nav_pier_c_big","land_nav_pier_C_L","land_nav_pier_C_L10","land_nav_pier_C_L30","land_nav_pier_C_R","land_nav_pier_C_R10","land_nav_pier_C_R30","land_nav_pier_c_t15","land_nav_pier_c_t20","land_nav_pier_F_17","land_nav_pier_F_23","land_nav_pier_m","land_nav_pier_m_1","land_nav_pier_m_end","land_nav_pier_M_fuel","land_nav_pier_pneu","land_nav_pier_uvaz"];
_destroy = _array;
{if ((typeOf _x) in _blackListed) then {_destroy = _destroy - [_x]}} forEach _array;
{_bo = "BO_GBU12_LGB" createVehicle [random 1000,random 1000,500];_bo setPos [getPos _x select 0, getPos _x select 1, getPos _x select 2]} forEach _destroy;

[_target] Spawn {
	private ["_dammageable","_dammages","_range","_target","_array","_u"];
	_target = _this select 0;
	_dammageable = ["Man","Car","Motorcycle","Tank","Ship","Air","StaticWeapon"];
	_range = 800;
	_dammages = 1;
	for [{_u = 0},{_u < 4},{_u = _u + 1}] do {
		_array = _target nearEntities [_dammageable, _range];
		{
			_x setDammage (getDammage _x + _dammages);
			{_x setDammage  (getDammage _x + _dammages)} forEach crew _x;
		} forEach _array;
		_range = _range + 300;
		_dammages = _dammages - 0.2;
		sleep 3;
	};
	//--- Radiations.
	[_target] Spawn NukeRadiation;
};