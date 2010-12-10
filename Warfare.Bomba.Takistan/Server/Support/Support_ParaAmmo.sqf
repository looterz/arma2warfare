#include "profiler.h"
PROFILER_BEGIN("Support_ParaAmmo");

Private["_args","_side"];

_args = _this;
_side = _args select 1;

_playerTeam = (_args select 3);
Format["Server_HandleSpecial: The %1 %2 Team (Leader: %3) has called an Ammunition Paradroping",str _side,_playerTeam,name leader _playerTeam] call LogInform;

_ranPos = [];
_ranDir = [];
if (paramBoundaries) then {
	_bd = 'WFBE_BOUNDARIESXY' Call GetNamespace;
	_ranPos = [
		[0+random(200),0+random(200),400+random(200)],
		[0+random(200),_bd-random(200),400+random(200)],
		[_bd-random(200),_bd-random(200),400+random(200)],
		[_bd-random(200),0+random(200),400+random(200)]
	];
	_ranDir = [45,145,225,315];
} else {
	_ranPos = [[0+random(200),0+random(200),400+random(200)],[15000+random(200),0+random(200),400+random(200)]];
	_ranDir = [45,315];
};
	_timeStart = time;
	_ran = round(random((count _ranPos)-1));
	_grp = createGroup _side;

	_vehicle = [format ["WFBE_%1PARAVEHI",str _side] Call GetNamespace, (_ranPos select _ran), _side, false, [], (_ranDir select _ran), "FLY" ] call CreateVehi;

	_pilot = [Format ["WFBE_%1PILOT",str _side] Call GetNamespace,_grp,[100,12000,0],_side] Call CreateMan;
	_pilot moveInDriver _vehicle;
	_grp setBehaviour 'CARELESS';
	_grp setCombatMode 'STEALTH';
	_pilot disableAI 'AUTOTARGET';
	_pilot disableAI 'TARGET';
	_built = _built + 1;
	[_grp,(_args select 2),"MOVE",10] Call AIMoveTo;

	_vehicle flyInHeight (200 + random(20));
	_exit = false;

	_cargo = (crew _vehicle) - [driver _vehicle, gunner _vehicle, commander _vehicle];

while {!_exit} do {
	sleep 1;
	if (!alive _pilot || !alive _vehicle || isNull _vehicle || isNull _pilot) exitWith {};
	if (!isPlayer leader _playerTeam || time - _timeStart > 500) exitWith {{_x setDammage 1} forEach (_cargo+[_pilot,_vehicle]);deleteGroup _grp};
	_vehicleCoord = [getPos _pilot select 0,getpos _pilot select 1];
	_positionCoord = [(_args select 2) select 0,(_args select 2) select 1];
	if (_vehicleCoord distance _positionCoord < 100) then {_exit = true};
};

[_vehicle,_side] Spawn {
	Private ['_chopper','_chute','_side'];
	_chopper = _this select 0;
	_side = _this select 1;
	
	_ammos = Format["WFBE_%1PARAAMMO",_side] Call GetNamespace;
	if (typeName _ammos != 'ARRAY') exitWith {
		Format["Server_HandleSpecial: Expected array, given %1 for ammunitions.",typeName _ammos] call LogError;
	};
	
	{
		_ammo = _x createVehicle [0,0,0];
		
		[_chopper,_ammo,_side] Spawn {
			Private ['_ammo','_chopper','_chute','_pos','_type'];
			_chopper = _this select 0;
			_ammo = _this select 1;
			_side = _this select 2;
			
			_chute = (Format['WFBE_%1PARACHUTE',str _side] Call GetNamespace) createVehicle [0,0,20];
			_chute setPos [getPos _chopper select 0, getPos _chopper select 1, (getPos _chopper select 2) - 11];
			_chute setDir (getDir _chopper);
			
			_ammo setPos getPos _chute;
			_ammo attachTo [_chute,[0,0,0]];
			while {getPos _ammo select 2 > 3} do {
				sleep 0.1;
			};
			detach _ammo;
			
			_type = typeOf _ammo;
			_pos = getPos _ammo;
			deleteVehicle _ammo;
			_ammo = _type createVehicle _pos;
			
			[_ammo, _side] spawn SetKilledEventHandler;			
			sleep 5;
			
			deleteVehicle _chute;
		};
		
		sleep 0.8;
	} forEach _ammos;
};

_exit = false;

[_grp,(_ranPos select _ran),"MOVE",10] Call AIMoveTo;
while {!_exit} do {
	sleep 1;
	if (!alive _pilot || !alive _vehicle || isNull _vehicle || isNull _pilot) exitWith {};
	_vehicleCoord = [getPos _pilot select 0,getpos _pilot select 1];
	_positionCoord = [(_ranPos select _ran) select 0,(_ranPos select _ran) select 1];
	if (_vehicleCoord distance _positionCoord < 200) then {_exit = true};
};
deleteVehicle _pilot;
deleteVehicle _vehicle;
deleteGroup _grp;

PROFILER_END();