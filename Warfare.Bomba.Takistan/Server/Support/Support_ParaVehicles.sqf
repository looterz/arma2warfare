#include "profiler.h"
PROFILER_BEGIN("Support_ParaVehicles");

private['_args', '_bd', '_cargo', '_cargoVehicle', '_exit', '_grp', '_pilot', '_playerTeam', '_positionCoord', '_ran', '_ranDir', '_ranPos', '_side', '_timeStart', '_vehicle', '_vehicleCoord'];
_args = _this;
_side = _args select 1;

_playerTeam = (_args select 3);
Format["Server_HandleSpecial: The %1 %2 Team (Leader: %3) has called a Vehicle Paradroping",str _side,_playerTeam,name leader _playerTeam] call LogInform;

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
_vehicle = [Format ["WFBE_%1PARAVEHI",str _side] Call GetNamespace,(_ranPos select _ran), _side, false, [], (_ranDir select _ran), "FLY"] call CreateVehi;


_pilot = [Format ["WFBE_%1PILOT",str _side] Call GetNamespace,_grp,[100,12000,0],_side] Call CreateMan;
_pilot moveInDriver _vehicle;
_pilot doMove (_args select 2);
_grp setBehaviour 'CARELESS';
_grp setCombatMode 'STEALTH';
_pilot disableAI 'AUTOTARGET';
_pilot disableAI 'TARGET';

[_grp,(_args select 2),"MOVE",10] Call AIMoveTo;

_vehicle flyInHeight (300 + random(75));
_exit = false;

_cargo = (crew _vehicle) - [driver _vehicle, gunner _vehicle, commander _vehicle];
_cargoVehicle = [Format ["WFBE_%1PARAVEHICARGO",str _side] Call GetNamespace,[0,0,50],_side,false] Call CreateVehi;
_cargoVehicle attachTo [_vehicle,[0,0,-3]];

while {!_exit} do {
	sleep 1;
	if (!alive _pilot || !alive _vehicle || isNull _vehicle || isNull _pilot || !alive _cargoVehicle) exitWith {};
	if (!isPlayer leader _playerTeam || time - _timeStart > 500) exitWith {{_x setDammage 1} forEach (_cargo+[_pilot,_vehicle,_cargoVehicle]);deleteGroup _grp};
	_vehicleCoord = [getPos _pilot select 0,getpos _pilot select 1];
	_positionCoord = [(_args select 2) select 0,(_args select 2) select 1];
	if (_vehicleCoord distance _positionCoord < 100) then {_exit = true};
};
detach _cargoVehicle;
[_cargoVehicle, _side]spawn
{
    private['_chute', '_side', '_vehicle'];
	_vehicle = _this select 0;
	_side = _this select 1;
	sleep 2;
	if (!alive _vehicle) exitWith {};
	_chute = (Format['WFBE_%1PARACHUTE',str _side] Call GetNamespace) createVehicle [0,0,20];
	_chute setPos [getPos _vehicle select 0, getPos _vehicle select 1, (getPos _vehicle select 2) - 11];
	_chute setDir (getDir _vehicle);
	_vehicle attachTo [_chute,[0,0,0]];
	while {getPos _vehicle select 2 > 10 && alive _vehicle} do {
		sleep 0.5;
	};
	detach _vehicle;
	sleep 10;
	deleteVehicle _chute;
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