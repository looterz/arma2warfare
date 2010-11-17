#include "profiler.h"
PROFILER_BEGIN("Server_BuyUnitThread::CreateUnit");

Private ["_building","_built","_crew","_direction","_dir","_distance","_factoryType","_gbq","_id","_index","_isVehicle","_longest","_position","_queu","_queu2","_ret","_side","_sideText","_soldier","_team","_type","_unitType","_vehicle","_waitTime"];
_id = _this select 0;
_building = _this select 1;
_unitType = _this select 2;
_side = _this select 3;
_team = _this select 4;
_isVehicle = [];
if (count _this > 4) then {_isVehicle = _this select 5};

_sideText = str _side;

Format["Server_BuyUnit: AI Team %1 has purchased a '%2'",_team,_unitType] call LogInform;

_type = typeOf _building;
_index = (Format ["WFBE_%1STRUCTURENAMES",_sideText] Call GetNamespace) find _type;
_distance = (Format ["WFBE_%1STRUCTUREDISTANCES",_sideText] Call GetNamespace) select _index;
_direction = (Format ["WFBE_%1STRUCTUREDIRECTIONS",_sideText] Call GetNamespace) select _index;
_factoryType = (Format ["WFBE_%1STRUCTURES",_sideText] Call GetNamespace) select _index;
_waitTime = (_unitType Call GetNamespace) select QUERYUNITTIME;
_position = [getPos _building,_distance,getDir _building + _direction] Call GetPositionFrom;
_longest = Format ["WFBE_LONGEST%1BUILDTIME",_factoryType] Call GetNamespace;

if (_unitType isKindOf "Man") then {
	_soldier = [_unitType,_team,_position,_side] Call CreateMan;
	
	_built = WF_Logic getVariable Format ["%1UnitsCreated",_sideText];
	_built = _built + 1;
	WF_Logic setVariable [Format["%1UnitsCreated",_sideText],_built,true];
	
} else {
	_crew = Format ["WFBE_%1SOLDIER",_sideText] Call GetNamespace;
	if (_unitType isKindOf "Tank") then {_crew = Format ["WFBE_%1CREW",_sideText] Call GetNamespace};
	if (_unitType isKindOf "Air") then {_crew = Format ["WFBE_%1PILOT",_sideText] Call GetNamespace};
	_vehicle = [_unitType,_position,_side,true] Call CreateVehi;
	_factoryPosition = getPos _building;
	_dir = -((((_position select 1) - (_factoryPosition select 1)) atan2 ((_position select 0) - (_factoryPosition select 0))) - 90);
	_vehicle setDir _dir;
	_vehicle setVelocity [0,0,-1];
	//--- AI Can fly.
	if (_vehicle isKindOf "Air") then {
		_vehicle flyInHeight 120;
		if (_vehicle isKindOf "Plane") then {
			_vehicle setPos [_position select 0,_position select 1,1500];
			_vehicle setVelocity [sin _dir * 250,cos _dir * 250,0];
		};
	};

	_vehicle Spawn HandleEmptyVehicle;
	if (_vehicle distance (leader _team) < 200) then {(units _team) allowGetIn true;_team addVehicle _vehicle};
	
	/* Clear the vehicle */
	clearWeaponCargo _vehicle;
	clearMagazineCargo _vehicle;
	
	_soldier = [_crew,_team,_position,_side] Call CreateMan;
	[_soldier] allowGetIn true;
	[_soldier] orderGetIn true;
	if (_unitType in ('WFBE_BALANCEDUNITS' Call GetNamespace) && paramBalancing) then {[_vehicle] Spawn BalanceInit};
	_soldier assignAsDriver _vehicle;
	_soldier moveInDriver _vehicle;
	_built = WF_Logic getVariable Format ["%1VehiclesCreated",_sideText];
	_built = _built + 1;
	WF_Logic setVariable [Format["%1VehiclesCreated",_sideText],_built,true];
	_built = WF_Logic getVariable Format ["%1UnitsCreated",_sideText];
	_built = _built + 1;
	if (_isVehicle select 1) then {
		_soldier = [_crew,_team,_position,_side] Call CreateMan;
		[_soldier] allowGetIn true;
		[_soldier] orderGetIn true;
		_soldier assignAsGunner _vehicle;
		_soldier moveInGunner _vehicle;
		_built = _built + 1;
	};
	if (_isVehicle select 2) then {
		if (vehicle leader _team == leader _team && leader _team distance _vehicle < 200 && alive leader _team) then {
			[leader _team] allowGetIn true;
			[leader _team] orderGetIn true;
			(leader _team) assignAsCommander _vehicle;
			(leader _team) moveInCommander _vehicle;
		} else {
			_soldier = [_crew,_team,_position,_side] Call CreateMan;
			[_soldier] allowGetIn true;
			[_soldier] orderGetIn true;
			_soldier assignAsCommander _vehicle;
			_soldier moveInCommander _vehicle;
		};
		_built = _built + 1;
	};
	_config = configFile >> "CfgVehicles" >> _unitType >> "Turrets";
	_turrets = [_config] call BIS_fnc_returnVehicleTurrets;
	WF_Logic setVariable [Format["%1UnitsCreated",_sideText],_built,true];
	if (count _turrets > 0) then {[_turrets, [], _vehicle, _crew, _team] call SpawnTurrets};
};

PROFILER_END();