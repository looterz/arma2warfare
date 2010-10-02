_location = _this Select 0;
_locationName = _this Select 1;
_resistanceTeamTypes = ["Group","Group"];
_probability = 70;
_startingSupplyValue = 10;
_maxSupplyValue = 50;
_range = 400;

if (count _this > 3) then {_startingSupplyValue = _this Select 2};
if (count _this > 4) then {_maxSupplyValue = _this Select 3};
if (count _this > 5) then {_range = _this Select 4};
if (count _this > 6) then {_resistanceTeamTypes = _this Select 5};
if (count _this > 7) then {_probability = _this Select 6};

_location setVariable ["name",_locationName];
_location setVariable ["range",_range];
_location setVariable ["startingSupplyValue",_startingSupplyValue];
_location setVariable ["maxSupplyValue",_maxSupplyValue];

if (local player) then {
	_marker = Format["%1Depot",str _location];
	createMarkerLocal [_marker,getPos _location];
	_marker setMarkerTypeLocal "Depot";
	_marker setMarkerColorLocal "ColorBlue";
};

diag_log Format["[WFBE (INIT)] Init_Location: Town '%1' (%2) initialization - [Done]",str _location,_locationName];

waitUntil {commonInitComplete};

if (isServer) then {
	//--- Don't pause.
	[_location,_startingSupplyValue,_range,_resistanceTeamTypes,_probability] Spawn {
		Private ["_isSet","_location","_probability","_range","_resistanceTeamTypes","_startingSupplyValue"];
		_location = _this select 0;
		_startingSupplyValue = _this select 1;
		_range = _this select 2;
		_resistanceTeamTypes = _this select 3;
		_probability = _this select 4;
		
		/* OA Depots are made of kryptonite */
		if (WF_A2_Arrowhead || WF_A2_CombinedOps) then {_location addEventHandler ['handleDamage',{false}]};
		_isSet = _location getVariable 'sideID';
		if (isNil '_isSet') then {_location setVariable ["sideID",RESISTANCEID,true]};
		_location setVariable ["supplyValue",_startingSupplyValue,true];
		sleep (random 1);
		waitUntil {serverInitComplete && townInit};
		[_location,_range] ExecFSM "Server\FSM\updatetown.fsm";
		if (paramRes && ('WFBE_TOWNSTARTINGMODE' Call GetNamespace) != 1) then {
			[_location,_resistanceTeamTypes,_probability,_range] ExecFSM "Server\FSM\updatetowndefenses.fsm";
		} else {
			_defenses = _location NearEntities['WFBE_RESISTANCEDEFENSENAMES' Call GetNamespace,_range];
			{deleteVehicle _x} forEach _defenses;
		};
		if (paramOccup) then {[_location,_probability,_range] ExecFSM "Server\FSM\updatetownoccupation.fsm"};
	};
};

towns = towns + [_location];