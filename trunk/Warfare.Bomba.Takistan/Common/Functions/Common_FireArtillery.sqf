#include "profiler.h"
PROFILER_BEGIN("Common_FireArtillery");

Private["_R", "_bWait", "_timeout", "_gunner", "_weaponDir", "_weaponDir1", "_weapon", "_magazine", "_ammo","_angle","_arcDistance","_artillery","_destination","_direction","_distance","_minRange","_maxRange","_position","_radius","_shell","_side","_type","_velocity","_weapon","_x","_y"];

_artillery = _this Select 0;
_destination = _this Select 1;
_side = _this Select 2;
_radius = _this Select 3;
_index = _this select 4;

if (_index == -1) exitWith {
	Format ["Common_FireArtillery.sqf: No artillery types were found for '%1'.",_artillery] call LogError;
};

_minRange = artilleryMinRanges Select _index;
_maxRange = artilleryMaxRanges Select _index;
_weapon = artilleryWeapons Select _index;
_ammo = artilleryAmmos Select _index;
_velocity = artilleryVelocities Select _index;
_dispersion = artilleryDispersions Select _index;

_magazine = currentMagazine _artillery;
_ammo = getText (configFile >> "CfgMagazines" >> _magazine >> "ammo");

if (IsNull Gunner _artillery) exitWith {
	Format ["Common_FireArtillery.sqf: Artillery '%1' gunner is null.",_artillery] call LogHigh;
};
if (IsPlayer Gunner _artillery) exitWith {
	Format ["Common_FireArtillery.sqf: Artillery '%1' gunner is player.",_artillery] call LogHigh;
};

_position = getPosASL _artillery;
_x = (_destination Select 0) - (_position Select 0);
_y = (_destination Select 1) - (_position Select 1);

_direction =  -(((_y atan2 _x) + 270) % 360);
if (_direction < 0) then {_direction = _direction + 360};

_distance = sqrt ((_x ^ 2) + (_y ^ 2)) - _minRange;

if (_distance < 0 || _distance + _minRange > _maxRange) ExitWith {};

_watchPosition = [(_position Select 0) + (sin _direction) * 50,(_position Select 1) + (cos _direction) * 50, 75];

_gunner = (Gunner _artillery);
_gunner DoWatch _watchPosition;

_weapon = (weapons _artillery) select 0;
_weaponDir = _artillery weaponDirection _weapon;
_bWait = true;

_timeout = time + 10;
while { _bWait && _timeout < time  } do {
	sleep 0.1;
	_weaponDir1 = _artillery weaponDirection _weapon;
	_R = _weaponDir distance _weaponDir1;	
	
	_bWait = if (_R == 0 && ((_weaponDir1 select 2) > 0.8) ) then { false } else { true };	
	_weaponDir = _weaponDir1;
};

_amount = _artillery Ammo _weapon;

if (_amount > 0) then {

	_radialR = Random (_distance / _maxRange * 100) + Random _radius;
	_radialAlpha = Random 360;
	_destination = [(_destination Select 0)+((sin _radialAlpha)*_radialR),(_destination Select 1)+((cos _radialAlpha)*_radialR), 2000];
	
	_ehFired = _artillery addEventHandler ["Fired", { (_this select 0) setVariable ["FireArtillery", _this select 6] } ];
		
	_artillery setVariable ["FireArtillery", objNull];
	_artillery Fire _weapon;
	
	_timeout = time + 5;
	waitUntil { !(isNull (_artillery getVariable "FireArtillery")) || _timeout < time };

	
	_shell = _artillery getVariable "FireArtillery";
	if ( !(isNull _shell) ) then {
		[_artillery, _shell, _destination] spawn FireArtilleryTraceTraectory;
	};

	_artillery removeEventHandler ["Fired", _ehFired];
};

if (WF_DEBUG) then {
	_artillery call RearmVehicle;
};

PROFILER_END();
