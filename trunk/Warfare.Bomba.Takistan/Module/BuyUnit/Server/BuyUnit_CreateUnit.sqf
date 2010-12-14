#include "profiler.h"
PROFILER_BEGIN("BuyUnit_CreateUnit");

Private ["_args", "_clientId", "_building", "_unitType", "_side", "_team", "_vehInfo", "_isAITeam", "_sideTeam", "_vehicleCreated", "_unitsCreated", "_unitCreated", "_distance", "_direction", "_type", "_index", "_position", "_driver", "_gunner", "_comander", "_locked", "_factoryPosition", "_crew", "_crewUnit", "_config", "_turrets" ];	

	_clientId = _this select 0;
	_building = _this select 1;
	_unitType = _this select 2;
	_side	  = _this select 3;
	_team 	  = _this select 4;
	_vehInfo  = _this select 5;

	_isAITeam = if (isPlayer(leader _team)) then { false } else { true };
	_sideText = str _side;
	
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
		
	} else {

		_driver   = false;
		_gunner   = false;
		_comander = false;
		_locked   = true;
	
		_args = (count _vehInfo);
		if ( _args > 0 ) then {  _driver   = _vehInfo select 0;  };
		if ( _args > 1 ) then {  _gunner   = _vehInfo select 1;  };
		if ( _args > 2 ) then {  _comander = _vehInfo select 2;  };
		if ( _args > 3 ) then {  _locked   = _vehInfo select 3;  };

		_vehicle = [_unitType, _position, _side, _locked] Call CreateVehi;
		_unitCreated = _vehicle;
		
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
		};
		
		if (_gunner) then {
			_crewUnit = [_crew,_team,_position,_side] Call CreateMan;
			[_crewUnit] allowGetIn true;
			[_crewUnit] orderGetIn true;
			_crewUnit assignAsGunner _vehicle;
			_crewUnit moveInGunner _vehicle;
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
			if (count _turrets != 0) then {
				[_turrets, [], _vehicle, _crew, _team] call SpawnTurrets;
			};
		};
	};

PROFILER_END();
_unitCreated;