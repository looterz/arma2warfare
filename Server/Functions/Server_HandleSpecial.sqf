Private["_action","_client","_args","_side"];

_side = _this Select 0;
_client = _this Select 1;
_action = _this Select 2;
_args = [];
if (count _this > 3) then {_args = _this select 3};

switch (_action) do {
	case "Paratroops": {
		//--- TODO: Add Radio Message (That works for both side).
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
		_pilot doMove _args;
		_built = _built + 1;
		[_grp,_args,"MOVE",10] Call AIMoveTo;
		Call Compile Format ["_vehicle addEventHandler ['Killed',{[_this select 0,_this select 1,%1] Spawn UnitKilled}]",_side];
		_vehicle setVehicleInit Format["[this,%1] ExecVM 'Common\Common_InitUnit.sqf';",_side];
		processInitCommands;
		_playerTeam = [_side,_client] Call GetClientTeam;
		_vehicle flyInHeight (300 + random(75));
		_currentUpgrades = WF_Logic getVariable Format ["%1Upgrades",Str _side];
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
			if (!isPlayer leader _playerTeam || time - _timeStart > 500) exitWith {{_x setDammage 1} forEach _cargo;_pilot setDammage 1;_vehicle setDammage 1;deleteGroup _grp;};
			_vehicleCoord = [getPos _pilot select 0,getpos _pilot select 1];
			_positionCoord = [_args select 0,_args select 1];
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
	};
	
	case "RespawnST": {
		_st = Call Compile Format ["%1AISupplyTrucks",Str _side];
		{if (!isNull (driver _x)) then {driver _x setDammage 1};_x setDammage 1} forEach _st;
	};
	
	case "uav": {
		_uav = _args;
		_exit = false;
		_driver = driver _uav;
		_gunner = gunner _uav;
		_playerTeam = [_side,_client] Call GetClientTeam;
		while {!_exit} do {
			sleep 5;
			if (!isPlayer leader _playerTeam || !alive _uav) then {_exit = true};
		};
		_trashed = [];
		if (!isNull _driver) then {if (alive _driver) then {_driver setDammage 1};if (!(_driver in trashQueu)) then {_trashed = _trashed + [_driver]}};
		if (!isNull _gunner) then {if (alive _gunner) then {_gunner setDammage 1};if (!(_gunner in trashQueu)) then {_trashed = _trashed + [_gunner]}};
		if (!isNull _uav) then {if (alive _uav) then {_uav setDammage 1};if (!(_uav in trashQueu)) then {_trashed = _trashed + [_uav]}};
		if (count _trashed > 0) then {
			_objects = (WF_Logic getVariable "trash") + _trashed;
			WF_Logic setVariable ["trash",_objects,true];
		};
	};
	
	case "upgrade": {["NewIntelAvailable","",_side,""] Spawn SideMessage};
	
	case "ICBM": {
		_base = _args select 0;
		_target = _args select 1;
		if (isNull _target || !alive _target) exitWith {};
		_dropPosX = getPos _base select 0;
		_dropPosY = getPos _base select 1;
		_dropPosZ = getPos _base select 2;
		_droppos1 = [_dropPosX + 4, _dropPosY + 4, _dropPosZ];
		_droppos2 = [_dropPosX + 8, _dropPosY + 8, _dropPosZ];
		waitUntil {!alive _target || isNull _target};
		det1 = "BO_GBU12_LGB" createVehicle [(getpos _target select 0),(getpos _target select 1), 0];
		det2 =  createVehicle ["BO_GBU12_LGB",_droppos1,[], 0, "None"];
		det3 =  createVehicle ["BO_GBU12_LGB",_droppos2,[], 0, "None"];
		[_base] Spawn NukeDammage;
	};
};