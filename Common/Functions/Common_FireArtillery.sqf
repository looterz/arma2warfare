Private["_magazine", "_ammo","_angle","_arcDistance","_artillery","_destination","_direction","_distance","_minRange","_maxRange","_position","_radius","_shell","_side","_type","_velocity","_weapon","_x","_y"];

_artillery = _this Select 0;
_destination = _this Select 1;
_side = _this Select 2;
_radius = _this Select 3;
_index = _this select 4;

if (_index == -1) ExitWith {diag_log Format ["[WFBE (INFORMATION)] Common_FireArtillery.sqf: No artillery types were found for '%1'.",_artillery]};

_minRange = artilleryMinRanges Select _index;
_maxRange = artilleryMaxRanges Select _index;
_weapon = artilleryWeapons Select _index;
_ammo = artilleryAmmos Select _index;
_velocity = artilleryVelocities Select _index;
_dispersion = artilleryDispersions Select _index;

_magazine = currentMagazine _artillery;
_ammo = getText (configFile >> "CfgMagazines" >> _magazine >> "ammo");

if (IsNull Gunner _artillery) ExitWith {diag_log Format ["[WFBE (INFORMATION)] Common_FireArtillery.sqf: Artillery '%1' gunner is null.",_artillery]};
if (IsPlayer Gunner _artillery) ExitWith {diag_log Format ["[WFBE (INFORMATION)] Common_FireArtillery.sqf: Artillery '%1' gunner is player.",_artillery]};

_position = GetPos _artillery;
_x = (_destination Select 0) - (_position Select 0);
_y = (_destination Select 1) - (_position Select 1);

_direction =  -(((_y atan2 _x) + 270) % 360);
if (_direction < 0) then {_direction = _direction + 360};

_distance = sqrt ((_x ^ 2) + (_y ^ 2)) - _minRange;

if (_distance < 0 || _distance + _minRange > _maxRange) ExitWith {};

_watchPosition = [(_position Select 0) + (sin _direction) * 50,(_position Select 1) + (cos _direction) * 50, 75];
Gunner _artillery DoWatch _watchPosition;
sleep 2;

_amount = _artillery Ammo _weapon;

if (_amount > 0) then {

	_artillery Fire _weapon;

	WaitUntil {_artillery Ammo _weapon < _amount};

	_shell = nearestObject [_artillery, _ammo];

	_shell SetPos [0,0,2000 + Random 20];
	_shell SetVelocity [0,0,0];

	_arcDistance = sqrt((_distance ^ 2) * 2);

	Gunner _artillery DoWatch _watchPosition;

	_distance = Random (_distance / _maxRange * 100) + Random _radius;
	_direction = Random 360;

	_destination = [(_destination Select 0)+((sin _direction)*_distance),(_destination Select 1)+((cos _direction)*_distance), 2000 + Random 20];
	_shell SetPos _destination;
	_shell SetVelocity [0,0,-_velocity];
}