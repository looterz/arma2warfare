Private ["_factoryType", "_building","_built","_cpt","_commander","_crew","_currentUnit","_description","_direction","_distance","_driver","_factoryType","_group","_gunner","_index","_isMan","_locked","_longest","_position","_queu","_queu2","_ret","_soldier","_waitTime","_type","_unique","_unit","_vehi","_vehicle","_vehicles"];

_factoryType = _this select 0;
_building = _this select 1;
_unit = _this select 2;
_vehi = _this select 3;

_cpt = 0;
_isMan = false;
if (_unit isKindOf "Man") then {
	_cpt = 1;
	_isMan = true;
} else {
	_driver = _vehi select 0;
	_gunner = _vehi select 1;
	_commander = _vehi select 2;
	if (_driver) then {_cpt = _cpt + 1};
	if (_gunner) then {_cpt = _cpt + 1};
	if (_commander) then {_cpt = _cpt + 1};
};
unitQueu = unitQueu + _cpt;

_distance = 0;
_direction = 0;
_longest = 0;
_position = 0;
_waitTime = 0;
_description = "";

_type = typeOf _building;

_index = (Format ["WFBE_%1STRUCTURENAMES",sideJoinedText] Call GetNamespace) find _type;
if (_index != -1) then {
	_distance = (Format ["WFBE_%1STRUCTUREDISTANCES",sideJoinedText] Call GetNamespace) select _index;
	_direction = (Format ["WFBE_%1STRUCTUREDIRECTIONS",sideJoinedText] Call GetNamespace) select _index;
	_currentUnit = _unit Call GetNamespace;
	_waitTime = _currentUnit select QUERYUNITTIME;
	_description = _currentUnit select QUERYUNITLABEL;
	_position = [getPos _building,_distance,getDir _building + _direction] Call GetPositionFrom;
	_longest = Format ["WFBE_LONGEST%1BUILDTIME",_factoryType] Call GetNamespace;
} else {
	if (_type in WFDEPOT) then {
		_distance = depotDistance;
		_direction = depotDirection;;
	};
	if (_type in WFHANGAR) then {
		_distance = airportDistance;
		_direction = airportDirection;
	};
	_currentUnit = _unit Call GetNamespace;
	_waitTime = _currentUnit select QUERYUNITTIME;
	_description = _currentUnit select QUERYUNITLABEL;
	_position = [getPos _building,_distance,getDir _building + _direction] Call GetPositionFrom;
	_longest = Format ["WFBE_LONGEST%1BUILDTIME",_factoryType] Call GetNamespace;
};

_unique = varQueu;
varQueu = random(10)+random(100)+random(1000);
_queu = _building getVariable "queu";
if (isNil "_queu") then {_queu = []};
_queu = _queu + [_unique];
_building setVariable ["queu",_queu,true];

_ret = 0;
_queu2 = [0];

if (count _queu > 0) then {_queu2 = _building getVariable "queu"};

_show = false;
while {_unique != _queu select 0 && alive _building && !isNull _building} do {
	sleep 4;
	_show = true;
	_ret = _ret + 4;
	_queu = _building getVariable "queu";
	
	if (_queu select 0 == _queu2 select 0) then {
		if (_ret > _longest) then {
			if (count _queu > 0) then {
				_queu = _building getVariable "queu";
				_queu = _queu - [_queu select 0];
				_building setVariable ["queu",_queu,true];
			};	
		};
	};
	if (count _queu != count _queu2) then {
		_ret = 0;
		_queu2 = _building getVariable "queu";
	};
};

if (_show) then {_txt = parseText(Format [localize "STR_WF_BuyEffective",_description]);hint _txt};

if (WF_DEBUG) then { _waitTime = 5; };
sleep _waitTime;

_queu = _building getVariable "queu";
_queu = _queu - [_unique];
_building setVariable ["queu",_queu,true];

_group = group player;
if (!(alive _building)|| isNull _building) exitWith {
	if (_isMan) then {
		unitQueu = unitQueu - 1;
	} else {
		if (_vehi select 0) then {unitQueu = unitQueu - 1};
		if (_vehi select 1) then {unitQueu = unitQueu - 1};
		if (_vehi select 2) then {unitQueu = unitQueu - 1};
	};
};

if (_isMan) then {
	_soldier = [_unit,_group,_position,sideJoined] Call CreateMan;
	unitQueu = unitQueu - 1;
	_built = WF_Logic getVariable Format ["%1UnitsCreated",sideJoinedText];
	_built = _built + 1;
	WF_Logic setVariable [Format["%1UnitsCreated",sideJoinedText],_built,true];
} else {
	_driver = _vehi select 0;
	_gunner = _vehi select 1;
	_commander = _vehi select 2;
	_locked = _vehi select 3;
	_vehicle = [_unit,_position,sideJoined,_locked] Call CreateVehi;
	clientTeam reveal _vehicle;
	_factoryPosition = getPos _building;
	_vehicle setDir -((((_position select 1) - (_factoryPosition select 1)) atan2 ((_position select 0) - (_factoryPosition select 0))) - 90);
	_vehicle setVelocity [0,0,-1];
	_vehicles = (WF_Logic getVariable "emptyVehicles") + [_vehicle];
	WF_Logic setVariable ["emptyVehicles",_vehicles,true];
	
	/* Clear the vehicle */
	clearWeaponCargo _vehicle;
	clearMagazineCargo _vehicle;
	
	//--- Vehicles Init Start.
	if (_unit in Zeta_Lifter) then {
		_upgrades = WF_Logic getVariable Format ["%1Upgrades",sideJoinedText];
		if (_upgrades select 8 > 0) then {_vehicle addAction [localize "STR_WF_Lift","Client\Module\ZetaCargo\Zeta_Hook.sqf"]};
	};
	_vehicle addAction [localize "STR_WF_Unlock","Client\Action\Action_ToggleLock.sqf", [], 95, false, true, '', 'alive _target && locked _target'];
	_vehicle addAction [localize "STR_WF_Lock","Client\Action\Action_ToggleLock.sqf", [], 94, false, true, '', 'alive _target && !(locked _target)'];
	if (_unit in (Format['WFBE_%1REPAIRTRUCKS',sideJoinedText] Call GetNamespace)) then {
		if (('WFBE_VICTORYCONDITION' Call GetNamespace) != 1) then {
			_vehicle setVehicleInit Format ["this addAction [localize 'STR_WF_BuildMenu_Repair','Client\Action\Action_BuildRepair.sqf', [], 99, false, true, '', 'side player == side _target && alive _target && player distance _target <= %1'];this addAction [localize 'STR_WF_Repair_MHQ','Client\Action\Action_RepairMHQ.sqf', [], 98, false, true, '', 'alive _target']",'WFBE_REPAIRTRUCKRANGE' Call GetNamespace];
		} else {
			_vehicle setVehicleInit Format ["this addAction [localize 'STR_WF_BuildMenu_Repair','Client\Action\Action_BuildRepair.sqf', [], 99, false, true, '', 'side player == side _target && alive _target && player distance _target <= %1']",'WFBE_REPAIRTRUCKRANGE' Call GetNamespace];
		};
		processInitCommands;
	};
	if (_unit in (Format['WFBE_%1SUPPLYTRUCKS',sideJoinedText] Call GetNamespace)) then {[_vehicle,sideJoined] ExecFSM "Client\FSM\updatesupply.fsm"};
	if (_unit in cargoHolder) then {
		_vehicle setVehicleInit Format["this AddAction ['HALO','Client\Action\Action_HALO.sqf', [], 97, false, true, '', 'getPos _target select 2 >= %1 && alive _target'];this addAction [localize 'STR_WF_Cargo_Eject','Client\Action\Action_EjectCargo.sqf', [], 99, false, true, '', 'driver _target == _this && alive _target']",('WFBE_HALOJUMPHEIGHT' Call GetNamespace)];
		processInitCommands
	};
	if (_unit isKindOf "Ship") then {_vehicle addAction [localize "STR_WF_Push","Client\Action\Action_Push.sqf", [], 93, false, true, "", "driver _target == _this && alive _target && speed _target < 30"]};
	if (_unit isKindOf "Air") then {
		_init = "";
		if (paramCounterMeasures) then {
			_upgrades = WF_Logic getVariable Format ["%1Upgrades",sideJoinedText];
			if (_upgrades select 9 > 0) then {_init = "nullReturn = [this] ExecVM 'Client\Module\CM\CM_Init.sqf';this addEventHandler ['incomingMissile',{_this Spawn CM_Countermeasures}];"};
		};
		if (paramAARadar) then {_init = _init + Format["nullReturn = [this,%1] ExecVM 'Common\Common_AARadarMarkerUpdate.sqf';",sideJoined]};
		if (_unit isKindOf "Plane") then {_vehicle addAction [localize "STR_WF_TaxiReverse","Client\Action\Action_TaxiReverse.sqf", [], 92, false, true, "", "driver _target == _this && alive _target && speed _target < 4 && getPos _target select 2 < 4"]};
		if (_init != "") then {_vehicle setVehicleInit _init; processInitCommands};
		
		_vehicle Call RemoveFlares;
	};
	if (_unit in ('WFBE_BALANCEDUNITS' Call GetNamespace) && paramBalancing) then {[_vehicle] Spawn BalanceInit};
	//--- Vehicles Init End.
	
	_built = WF_Logic getVariable Format ["%1VehiclesCreated",sideJoinedText];
	_built = _built + 1;
	WF_Logic setVariable [Format["%1VehiclesCreated",sideJoinedText],_built,true];
	_built = WF_Logic getVariable Format ["%1UnitsCreated",sideJoinedText];
	_group addVehicle _vehicle;
	if (!_driver && !_gunner && !_commander) exitWith {};
	_crew = Format ["WFBE_%1SOLDIER",sideJoinedText] Call GetNamespace;
	if (_unit isKindOf "Tank") then {_crew = Format ["WFBE_%1CREW",sideJoinedText] Call GetNamespace};
	if (_unit isKindOf "Air") then {
		_unit Spawn RearmVehicle;
		_crew = Format ["WFBE_%1PILOT",sideJoinedText] Call GetNamespace
	};
	if (_driver) then {
		_soldier = [_crew,_group,_position,sideJoined] Call CreateMan;
		[_soldier] allowGetIn true;
		_soldier moveInDriver _vehicle;
		unitQueu = unitQueu - 1;
		_built = _built + 1;
	};
	if (_gunner) then {
		_soldier = [_crew,_group,_position,sideJoined] Call CreateMan;
		[_soldier] allowGetIn true;
		_soldier moveInGunner _vehicle;
		unitQueu = unitQueu - 1;
		_built = _built + 1;
	};
	if (_commander) then {
		_soldier = [_crew,_group,_position,sideJoined] Call CreateMan;
		[_soldier] allowGetIn true;
		_soldier moveInCommander _vehicle;
		unitQueu = unitQueu - 1;
		_built = _built + 1;
	};
	WF_Logic setVariable [Format["%1UnitsCreated",sideJoinedText],_built,true];
};

hint parseText(Format [localize "STR_WF_Build_Complete",_description]);