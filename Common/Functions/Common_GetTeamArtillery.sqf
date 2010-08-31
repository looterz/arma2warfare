Private["_artillery","_count","_destination","_ignoreAmmo","_index","_position","_search","_team","_units","_vehicle","_x","_y"];

_team = _this select 0;
_destination = _this select 1;
_ignoreAmmo = _this select 2;
_index = _this select 3;

_units = units _team;
_artillery = [];

{
	_vehicle = if ((typeOf (vehicle _x)) == (artilleryNames select _index)) then {vehicle _x} else {objNull};
	_type = artilleryNames find typeOf _vehicle;

	if (_type != -1 && !IsNull gunner _vehicle && !(_vehicle In _artillery)) then {
		if (!isPlayer gunner _vehicle) then	{
			_weapon = artilleryWeapons select _type;

			if (_ignoreAmmo || (_vehicle ammo _weapon > 0)) then {
				_artillery = _artillery + [_vehicle];
			};
		};
	};
} forEach _units;

_artillery