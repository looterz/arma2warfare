#include "profiler.h"
PROFILER_BEGIN("BuyUnit_OrderComplete");

Private ["_order", "_vehicle", "_unitType", "_side", "_vehInfo", "_upgrades", "_init"];

	waitUntil { !isNil "LogInited" };

	//--- _clientId = _order select 0;
	//--- _building = _order select 1;
	//--- _unitType = _order select 2; 
	//--- _side	  	= _order select 3; 
	//--- _team     = _order select 4; 
	//--- _vehInfo  = _order select 5; 

	_order 	 = _this select 0;
	_vehicle = _this select 1;
	
	format ["BuyUnit_OrderComplete: Order %1", _order] call LogHigh;
	format ["BuyUnit_OrderComplete: Vehicle %1", _vehicle] call LogHigh;

	_unitType = _order select 2;
	_side	  = _order select 3;
	_vehInfo  = _order select 5;
	
	if ( (count _vehInfo) > 0 ) then {  if (_vehInfo select 0) then { unitQueu = unitQueu - 1; }; };	//-- buy crew driver
	if ( (count _vehInfo) > 1 ) then {  if (_vehInfo select 1) then { unitQueu = unitQueu - 1; }; };	//-- buy crew gunner
	if ( (count _vehInfo) > 2 ) then {  if (_vehInfo select 2) then { unitQueu = unitQueu - 1; }; };	//-- buy crew commander;
	if (_unitType isKindOf "Man") then { unitQueu = unitQueu - 1; };	//-- buy soldier
	
	if (unitQueu < 0) then { unitQueu = 0; };	//-- just fix errors with unit queue;

	
	if (_unitType isKindOf "Man") exitWith {
	
		PROFILER_END();
	};
	
	if ( (count _vehInfo) > 3 ) then {  if (_vehInfo select 3) then {  _vehicle lock (_vehInfo select 3)  }; };	//-- lock vehicle;

	_upgrades = (_side) Call GetSideUpgrades;
	clientTeam reveal _vehicle;
	
	//--- Vehicles Init Start.
	if (_unitType in Zeta_Lifter) then {
		if (_upgrades select 8 > 0) then {
			_vehicle addAction [localize "STR_WF_Lift","Client\Module\ZetaCargo\Zeta_Hook.sqf"]
		};
	};
	
	_vehicle addAction [localize "STR_WF_Unlock","Client\Action\Action_ToggleLock.sqf", [], 95, false, true, '', 'alive _target && locked _target'];
	_vehicle addAction [localize "STR_WF_Lock","Client\Action\Action_ToggleLock.sqf", [], 94, false, true, '', 'alive _target && !(locked _target)'];

	if (_unitType in (Format['WFBE_%1REPAIRTRUCKS', _side] Call GetNamespace)) then {
		if (('WFBE_VICTORYCONDITION' Call GetNamespace) != 1) then {
			_vehicle setVehicleInit Format ["this addAction [localize 'STR_WF_BuildMenu_Repair','Client\Action\Action_BuildRepair.sqf', [], 99, false, true, '', 'side player == side _target && alive _target && player distance _target <= %1'];this addAction [localize 'STR_WF_Repair_MHQ','Client\Action\Action_RepairMHQ.sqf', [], 98, false, true, '', 'alive _target']",'WFBE_REPAIRTRUCKRANGE' Call GetNamespace];
		} else {
			_vehicle setVehicleInit Format ["this addAction [localize 'STR_WF_BuildMenu_Repair','Client\Action\Action_BuildRepair.sqf', [], 99, false, true, '', 'side player == side _target && alive _target && player distance _target <= %1']",'WFBE_REPAIRTRUCKRANGE' Call GetNamespace];
		};
		processInitCommands;
	};
	
	if (_unitType in (Format['WFBE_%1SUPPLYTRUCKS',sideJoinedText] Call GetNamespace)) then {
		[_vehicle, _side] ExecFSM "Client\FSM\updatesupply.fsm";
	};
	
	if (_unitType in cargoHolder) then {
		_vehicle setVehicleInit Format["this AddAction ['HALO','Client\Action\Action_HALO.sqf', [], 97, false, true, '', 'getPos _target select 2 >= %1 && alive _target'];this addAction [localize 'STR_WF_Cargo_Eject','Client\Action\Action_EjectCargo.sqf', [], 99, false, true, '', 'driver _target == _this && alive _target']",('WFBE_HALOJUMPHEIGHT' Call GetNamespace)];
		processInitCommands
	};
	
	if (_unitType isKindOf "Ship") then {
		_vehicle addAction [localize "STR_WF_Push","Client\Action\Action_Push.sqf", [], 93, false, true, "", "driver _target == _this && alive _target && speed _target < 30"];
	};
	
	if (_unitType isKindOf "Air") then {
		_init = "";
		if (paramCounterMeasures) then {
			if (_upgrades select 9 > 0) then {_init = "nullReturn = [this] ExecVM 'Client\Module\CM\CM_Init.sqf';this addEventHandler ['incomingMissile',{_this Spawn CM_Countermeasures}];"};
		};
		
		if (paramAARadar) then {
			_init = _init + Format["nullReturn = [this,%1] ExecVM 'Common\Common_AARadarMarkerUpdate.sqf';", _side];	//--- TODO OPTIMISE AARadarMarkerUpdate;
		};
		
		if (_unitType isKindOf "Plane") then {
			_vehicle addAction [localize "STR_WF_TaxiReverse","Client\Action\Action_TaxiReverse.sqf", [], 92, false, true, "", "driver _target == _this && alive _target && speed _target < 4 && getPos _target select 2 < 4"];
		};
		
		if (_init != "") then {
			_vehicle setVehicleInit _init; 
			processInitCommands;
		};
		
		if (paramMissleCamera) then {
			[_vehicle] call Action_MissleCam;
		};
	};
	if (_unitType in ('WFBE_BALANCEDUNITS' Call GetNamespace) && paramBalancing) then {
		[_vehicle] call BalanceInit;
		_vehicle Call RemoveFlares;
	};
	
PROFILER_END();	