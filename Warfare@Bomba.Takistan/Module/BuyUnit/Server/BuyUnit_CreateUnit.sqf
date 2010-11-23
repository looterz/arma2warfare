#include "profiler.h"
PROFILER_BEGIN("BuyUnit_CreateUnit");

Private ["_clientId", "_building", "_unitType", "_side", "_team", "_vehInfo", "_isAITeam", "_sideTeam", "_vehicleCreated", "_unitsCreated", "_unitCreated", "_distance", "_direction", "_type", "_index", "_position", "_driver", "_gunner", "_comander", "_locked", "_factoryPosition", "_crew", "_crewUnit", "_config", "_turrets" ];	

	_clientId = _this select 0;
	_building = _this select 1;
	_unitType = _this select 2;
	_side	  = _this select 3;
	_team 	  = _this select 4;
	_vehInfo  = _this select 5;

	_isAITeam = if (isPlayer(leader _team)) then { false } else { true };
	_sideText = str _side;

	_vehicleCreated = 0;
	_unitsCreated = 0;
	
	
	_unitCreated = objNull;	
	//-- --------------------------
	_distance  = 0;
	_direction = 0;

	_type = typeOf _building;
	_index = (Format ["WFBE_%1STRUCTURENAMES", _sideText] Call GetNamespace) find _type;
	if (_index != -1) then {
		_distance 	 = (Format ["WFBE_%1STRUCTUREDISTANCES", _sideText] call GetNamespace) select _index;
		_direction 	 = (Format ["WFBE_%1STRUCTUREDIRECTIONS", _sideText] call GetNamespace) select _index;
		
	} else {
		if (_type in WFDEPOT) then {
			_distance = depotDistance;
			_direction = depotDirection;
		};
		if (_type in WFHANGAR) then {
			_distance = airportDistance;
			_direction = airportDirection;
		};
	};

	_position = [getPos _building, _distance, getDir _building + _direction] Call GetPositionFrom;

	if (_unitType isKindOf "Man") then {

		_unitCreated = [_unitType,_team,_position,_side] Call CreateMan;
		[_unitCreated] allowGetIn true;
		[_unitCreated] orderGetIn true;		
		
		_unitsCreated = _unitsCreated + 1;
		
	} else {

		_driver   = false;
		_gunner   = false;
		_comander = false;
		_locked   = true;
	
		if ( (count _vehInfo) > 0 ) then {  _driver   = _vehInfo select 0; };
		if ( (count _vehInfo) > 1 ) then {  _gunner   = _vehInfo select 1; };
		if ( (count _vehInfo) > 2 ) then {  _comander = _vehInfo select 2; };
		if ( (count _vehInfo) > 3 ) then {  _locked   = _vehInfo select 3; };

		_unitCreated = [_unitType, _position, _side, _locked] Call CreateVehi;
		
		_vehicle = _unitCreated;
		_vehicle spawn HandleEmptyVehicle;
		_vehicleCreated = _vehicleCreated + 1;	
		
		if (_unitType in ('WFBE_BALANCEDUNITS' Call GetNamespace) && paramBalancing) then {
			[_vehicle] spawn BalanceInit;
		};
		
		//-- Clear the vehicle
		clearWeaponCargo _vehicle;
		clearMagazineCargo _vehicle;	
		
		//-- set vehicle direction
		_factoryPosition = getPos _building;
		_vehicle setDir -((((_position select 1) - (_factoryPosition select 1)) atan2 ((_position select 0) - (_factoryPosition select 0))) - 90);
		_vehicle setVelocity [0,0,-1];
	
		//-- get crew unit type
		_crew = Format ["WFBE_%1SOLDIER",_sideText] Call GetNamespace;
		if (_unitType isKindOf "Tank") then {_crew = Format ["WFBE_%1CREW", _sideText] Call GetNamespace };
		if (_unitType isKindOf "Air")  then {_crew = Format ["WFBE_%1PILOT",_sideText] Call GetNamespace };
		
		if (_driver) then {
			_crewUnit = [_crew,_team,_position,_side] Call CreateMan;
			[_crewUnit] allowGetIn true;
			[_crewUnit] orderGetIn true;
			_crewUnit assignAsDriver _vehicle;
			_crewUnit moveInDriver _vehicle;		
			_unitsCreated = _unitsCreated + 1;
		};
		
		if (_gunner) then {
			_crewUnit = [_crew,_team,_position,_side] Call CreateMan;
			[_crewUnit] allowGetIn true;
			[_crewUnit] orderGetIn true;
			_crewUnit assignAsGunner _vehicle;
			_crewUnit moveInGunner _vehicle;
			_unitsCreated = _unitsCreated + 1;
		};
		
		if (_isAITeam && (_vehicle distance (leader _team) < 200) ) then {
			(units _team) allowGetIn true;
			_team addVehicle _vehicle;
				
			if ( (vehicle leader _team) == (leader _team) && alive leader _team) then {
				[leader _team] allowGetIn true;
				[leader _team] orderGetIn true;
				(leader _team) assignAsCommander _vehicle;
				(leader _team) moveInCommander _vehicle;

				_comander = false;
			};
		};
	
		if (_comander) then {
		
			_crewUnit = [_crew,_team,_position,_side] Call CreateMan;
			[_crewUnit] allowGetIn true;
			[_crewUnit] orderGetIn true;
			_crewUnit assignAsCommander _vehicle;
			_crewUnit moveInCommander _vehicle;
			_unitsCreated = _unitsCreated + 1;		
		};
		
		//-- Init AI Specific 
		//
		if (_isAITeam) then {
			
			if (_vehicle isKindOf "Air") then {
				_vehicle flyInHeight 120;
				if (_vehicle isKindOf "Plane") then {
					_vehicle setPos [_position select 0,_position select 1,1500];
					_vehicle setVelocity [sin _dir * 250,cos _dir * 250,0];
				};
			};	
			
			_config = configFile >> "CfgVehicles" >> _unitType >> "Turrets";
			_turrets = [_config] call BIS_fnc_returnVehicleTurrets;
			if (count _turrets > 0) then {
				[_turrets, [], _vehicle, _crew, _team] call SpawnTurrets;
			};
		};
	};

	//-- Update Side Stats
	//
	if (_unitsCreated != 0) then {
		_unitsCreated = _unitsCreated + (WF_Logic getVariable Format ["%1UnitsCreated",_sideText]);
		WF_Logic setVariable [Format["%1UnitsCreated",_sideText], _unitsCreated, true];
	};

	if (_vehicleCreated != 0) then {
		_vehicleCreated = _vehicleCreated + (WF_Logic getVariable Format ["%1VehiclesCreated",_sideText]);
		WF_Logic setVariable [Format ["%1VehiclesCreated",_sideText], _vehicleCreated, true];
	};

PROFILER_END();
_unitCreated;