Private["_args","_side"];

_args = _this;
_side = _args select 1;

_playerTeam = (_args select 3);
diag_log Format["[WFBE (INFORMATION)] Server_HandleSpecial: The %1 %2 Team (Leader: %3) has called a Paratroops Reinforcement",str _side,_playerTeam,name leader _playerTeam];
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
_vehicle = createVehicle [Format ["WFBE_%1PARACARGO",str _side] Call GetNamespace,(_ranPos select _ran), [], (_ranDir select _ran), "FLY"];
_built = WF_Logic getVariable Format ["%1VehiclesCreated",str _side];
_built = _built + 1;
WF_Logic setVariable [Format["%1VehiclesCreated",str _side],_built,true];
_built = WF_Logic getVariable Format ["%1UnitsCreated",str _side];
_pilot = [Format ["WFBE_%1PILOT",str _side] Call GetNamespace,_grp,[100,12000,0],_side] Call CreateMan;
_pilot moveInDriver _vehicle;
_pilot doMove (_args select 2);
_grp setBehaviour 'CARELESS';
_grp setCombatMode 'STEALTH';
_pilot disableAI 'AUTOTARGET';
_pilot disableAI 'TARGET';
_built = _built + 1;
[_grp,(_args select 2),"MOVE",10] Call AIMoveTo;
Call Compile Format ["_vehicle addEventHandler ['Killed',{[_this select 0,_this select 1,%1] Spawn UnitKilled}]",_side];
_vehicle setVehicleInit Format["[this,%1] ExecVM 'Common\Common_InitUnit.sqf';",_side];
processInitCommands;
_vehicle flyInHeight (300 + random(75));
_currentUpgrades = (str _side) Call GetSideUpgrades;
_currentLevel = _currentUpgrades select 4;
_units = Format ["WFBE_%1PARACHUTELEVEL%2",Str _side,_currentLevel] Call GetNamespace;
{
	_unit = [_x,_grp,[100,12000,0],_side] Call CreateMan;
	_unit moveInCargo _vehicle;
	_built = _built + 1;
} forEach _units;
_exit = false;
WF_Logic setVariable [Format["%1UnitsCreated",str _side],_built,true];
_cargo = (crew _vehicle) - [driver _vehicle, gunner _vehicle, commander _vehicle];
while {!_exit} do {
	sleep 1;
	if (!alive _pilot || !alive _vehicle || isNull _vehicle || isNull _pilot) exitWith {};
	if (!isPlayer leader _playerTeam || time - _timeStart > 500) exitWith {{_x setDammage 1} forEach (_cargo+[_pilot,_vehicle]);deleteGroup _grp};
	_vehicleCoord = [getPos _pilot select 0,getpos _pilot select 1];
	_positionCoord = [(_args select 2) select 0,(_args select 2) select 1];
	if (_vehicleCoord distance _positionCoord < 200) then {_exit = true};
};
_delay = 1;
if (_side == WEST) then {_delay = 0.3};
{_x action ["EJECT",_vehicle];sleep _delay;[_x] join (leader _playerTeam)} forEach _cargo;
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