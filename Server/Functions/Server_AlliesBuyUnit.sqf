Private ["_building","_built","_crew","_direction","_distance","_factoryType","_id","_index","_isVehicle","_longest","_position","_queu","_queu2","_ret","_side","_sideText","_soldier","_team","_type","_unitType","_vehicle","_waitTime"];
_id = _this select 0;
_building = _this select 1;
_unitType = _this select 2;
_side = _this select 3;
_team = _this select 4;
_isVehicle = [];
if (count _this > 4) then {_isVehicle = _this select 5};

_sideText = str _side;

diag_log Format["[WFBE (INFORMATION)] Server_AlliesBuyUnit: AI Team %1 has purchased a '%2'",_team,_unitType];

_queu = _building getVariable "queu";
if (isNil "_queu") then {_queu = []};
_queu = _queu + [_id select 0];
_building setVariable ["queu",_queu];

_type = typeOf _building;
if (_type == "CDF_WarfareBBarracks" || _type == "Ins_WarfareBBarracks") then {_type = Call Compile Format ["%1BAR",str _side]};
if (_type == "CDF_WarfareBLightFactory" || _type == "Ins_WarfareBLightFactory") then {_type = Call Compile Format ["%1LVF",str _side]};
if (_type == "CDF_WarfareBHeavyFactory" || _type == "Ins_WarfareBHeavyFactory") then {_type = Call Compile Format ["%1HEAVY",str _side]};
if (_type == "CDF_WarfareBAircraftFactory" || _type == "Ins_WarfareBAircraftFactory") then {_type = Call Compile Format ["%1AIR",str _side]};

_index = (Format ["WFBE_%1STRUCTURENAMES",_sideText] Call GetNamespace) find _type;
_distance = (Format ["WFBE_%1STRUCTUREDISTANCES",_sideText] Call GetNamespace) select _index;
_direction = (Format ["WFBE_%1STRUCTUREDIRECTIONS",_sideText] Call GetNamespace) select _index;
_factoryType = (Format ["WFBE_%1STRUCTURES",_sideText] Call GetNamespace) select _index;

_waitTime = (_unitType Call GetNamespace) select QUERYUNITTIME;
_position = [getPos _building,_distance,getDir _building + _direction] Call GetPositionFrom;
_longest = Format ["WFBE_LONGEST%1BUILDTIME",_factoryType] Call GetNamespace;

_ret = 0;
_queu2 = [0];

if (count _queu > 0) then {
	_queu2 = _building getVariable "queu";
};

while {_id select 0 != _queu select 0} do {
	sleep 4;
	_ret = _ret + 4;
	_queu = _building getVariable "queu";
	
	if (!(alive _building)||(isNull _building)) exitWith {
		_queu = _building getVariable "queu";
		_queu = _queu - [_queu select 0];
		_building setVariable ["queu",_queu];
		diag_log Format ["[WFBE (INFORMATION)] Server_BuyUnit.sqf: Canceled unit '%1', the factory is destroyed.",_unitType];
	};
	
	if (_queu select 0 == _queu2 select 0) then {
		if (_ret > _longest) then {
			if (count _queu > 0) then {
				_queu = _building getVariable "queu";
				_queu = _queu - [_queu select 0];
				_building setVariable ["queu",_queu];
			};	
		};
	};
	if (count _queu != count _queu2) then {
		_ret = 0;
		_queu2 = _building getVariable "queu";
	};
};

sleep _waitTime;

_queu = _building getVariable "queu";
_queu = _queu - [_unique];
_building setVariable ["queu",_queu];

if ((!alive _building)||(isNull _building)) exitWith {diag_log Format ["[WFBE (INFORMATION)] Server_AlliesBuyUnit.sqf: Canceled unit '%1', the factory is destroyed.",_unitType];};

if (_unitType isKindOf "Man") then {
	_soldier = [_unitType,_team,_position,_side] Call CreateMan;
	_built = WF_Logic getVariable Format ["%1UnitsCreated",_sideText];
	_built = _built + 1;
	WF_Logic setVariable [Format["%1UnitsCreated",_sideText],_built,true];
	
	//--- Infantry can use the team vehicles as cargo.
	_vehi = [_team,true] Call GetTeamVehicles;
	{_team addVehicle _x} forEach _vehi;
} else {
	_crew = Format["WFBE_%1ALLIESSOLDIER",_sideText] Call GetNamespace;
	if (_unitType isKindOf "Tank") then {_crew = Format ["WFBE_%1ALLIESCREW",_sideText] Call GetNamespace};
	if (_unitType isKindOf "Air") then {_crew = Format ["WFBE_%1ALLIESPILOT",_sideText] Call GetNamespace};
	_vehicle = [_unitType,_position,_side,true] Call CreateVehi;
	_factoryPosition = getPos _building;
	_vehicle setDir -((((_position select 1) - (_factoryPosition select 1)) atan2 ((_position select 0) - (_factoryPosition select 0))) - 90);
	_vehicle setVelocity [0,0,-1];
	//--- AI Can fly...? (*roll eyes at the harriers*).
	if (_vehicle isKindOf "Plane") then {_vehicle setPos [_position select 0,_position select 1,1500]};
	
	/* Clear the vehicle */
	clearWeaponCargo _vehicle;
	clearMagazineCargo _vehicle;
	
	emptyQueu = emptyQueu + [_vehicle];
	_vehicle Spawn HandleEmptyVehicle;
	_soldier = [_crew,_team,_position,_side] Call CreateMan;
	[_soldier] allowGetIn true;
	[_soldier] orderGetIn true;
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
		_soldier = [_crew,_team,_position,_side] Call CreateMan;
		[_soldier] allowGetIn true;
		[_soldier] orderGetIn true;
		_soldier assignAsCommander _vehicle;
		_soldier moveInCommander _vehicle;
		_built = _built + 1;
	};
	_config = configFile >> "CfgVehicles" >> _unitType >> "Turrets";
	_turrets = [_config] call BIS_fnc_returnVehicleTurrets;
	WF_Logic setVariable [Format["%1UnitsCreated",_sideText],_built,true];
	if (count _turrets > 0) then {[_turrets, [], _vehicle, _crew, _team] call SpawnTurrets};
};