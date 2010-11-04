_camp = _this Select 0;
_town = _this Select 1;


waitUntil { !isNil "LogInited" };
waitUntil {townModeSet};

if (isNull _town) exitWith {
	if (isServer && !isNull _camp) then {
		(getPos _camp) Spawn {
			waitUntil {commonInitComplete};
			_defenses = _this nearEntities[('WFBE_RESISTANCEDEFENSENAMES' Call GetNamespace),250];
		{deleteVehicle _x} forEach _defenses;
		};
		deleteVehicle _camp;
	};
};
if ((str _town) in TownTemplate) exitWith {
	if (isServer) then {
		Format ["Init_Camp.sqf: Removing camp %1 (%2) since the town is removed in the towns templates.",_camp,str _town] call LogHigh;
		(getPos _camp) Spawn {
			waitUntil {commonInitComplete};
			_defenses = _this nearEntities[('WFBE_RESISTANCEDEFENSENAMES' Call GetNamespace),250];
		{deleteVehicle _x} forEach _defenses;
		};
		deleteVehicle _camp;
	};
};

_camps = _town getVariable "camps";
if (isNil "_camps") then {_town setVariable ["camps",[]]};
_camps = _town getVariable "camps";
_camps = _camps + [_camp];
_town setVariable ["camps",_camps];

_index = _camps Find _camp;
_marker = Format["%1Camp%2",str _town,_index];
createMarkerLocal [_marker,getPos _camp];
_marker setMarkerTypeLocal "Strongpoint";
_marker setMarkerColorLocal "ColorBlue";
_marker setMarkerSizeLocal [0.5,0.5];

Format["Init_Camp: Camp '%1' of town '%2' initialization - [Done]",str _camp,str _town] call LogHigh;

waitUntil {commonInitComplete};

sleep 10;

if (isServer) then {
	_supplyValue = 0;
	_check = _camp getVariable "sideID";
	if (isNil "_check") then {_camp setVariable ["sideID",RESISTANCEID,true]};
	/* OA Camps are made of kryptonite */
	if (WF_A2_Arrowhead || WF_A2_CombinedOps) then {_camp addEventHandler ['handleDamage',{false}]};
	_check = _camp getVariable "supplyValue";
	if (isNil "_check") then {
		waitUntil {_supplyValue = _town getVariable "supplyValue"; !isNil "_supplyValue"};
		_camp setVariable ["supplyValue",_supplyValue,true];
		_flagPole = WFFLAG createVehicle getPos _camp;
		waitUntil {serverInitComplete && townInit};
		[_camp,_town,_flagPole] ExecFSM 'Server\FSM\updatecamp.fsm';
	};
};