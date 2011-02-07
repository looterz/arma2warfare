Private["_artillery","_artyTypes","_count","_destination","_ignoreAmmo","_index","_position","_search","_side","_team","_units","_vehicle","_x","_y"];

_team = _this select 0;
_destination = _this select 1;
_ignoreAmmo = _this select 2;
_index = _this select 3;
_side = _this select 4;

_units = units _team;
_artyTypes = (Format ["WFBE_%1_ARTILLERY_NAMES",_side] Call GetNamespace) select _index;
_artyWeapons = Format ["WFBE_%1_ARTILLERY_WEAPONS",_side] Call GetNamespace;

_artillery = [];

{
	_vehicle = vehicle _x;

	if (typeOf(_vehicle) in _artyTypes) then {
		if (!(isNull(gunner _vehicle)) && !(_vehicle in _artillery) && !(isPlayer(gunner _vehicle))) then {
			if !(isPlayer(gunner _vehicle)) then {
				_weapon = _artyWeapons select _index;

				if (_ignoreAmmo || (_vehicle ammo _weapon > 0)) then {
					_artillery = _artillery + [_vehicle];
				};
			};
		};
	};
} forEach _units;

_artillery