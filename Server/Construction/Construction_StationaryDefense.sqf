//*****************************************************************************************
//Description: Creates Defenses.
//*****************************************************************************************
Private ["_defense","_direction","_index","_manned","_position","_side","_type"];
_type = _this select 0;
_side = _this select 1;
_position = _this select 2;
_direction = _this select 3;
_index = _this select 4;
_manned = _this select 5;

_defense = _type createVehicle _position;
_defense setDir _direction;
_defense setPos _position;

//--- If it's a minefield, we exit the script while spawning it.
if (_type == 'Sign_Danger') exitWith {
	_mineType = if (_side == east) then {'MineMineE'} else {'MineMine'};
	_h = -4;
	_c = 0;
	for [{_x=0}, {_x<9}, {_x=_x+1}] do{
		_array = [((_defense worldToModel (getPos _defense)) select 0) - 16 +_c,((_defense worldToModel (getPos _defense)) select 1) + _h];
		_toWorld = _defense modelToWorld _array;
		_toWorld set[2,0];
		_mine = createMine [_mineType, _toWorld,[], 0];
		_c = _c + 4;
	};

	_h = 0;
	_c = 2;
	for [{_x=0}, {_x<8}, {_x=_x+1}] do{
		_array = [((_defense worldToModel (getPos _defense)) select 0) - 16 +_c,((_defense worldToModel (getPos _defense)) select 1) + _h];
		_toWorld = _defense modelToWorld _array;
		_toWorld set[2,0];
		_mine = createMine [_mineType, _toWorld,[], 0];
		_c = _c + 4;
	};

	_h = 4;
	_c = 0;
	for [{_x=0}, {_x<9}, {_x=_x+1}] do{
		_array = [((_defense worldToModel (getPos _defense)) select 0) - 16 +_c,((_defense worldToModel (getPos _defense)) select 1) + _h];
		_toWorld = _defense modelToWorld _array;
		_toWorld set[2,0];
		_mine = createMine [_mineType, _toWorld,[], 0];
		_c = _c + 4;
	};
	deleteVehicle _defense;
};

Call Compile Format ["_defense addEventHandler ['Killed',{[_this select 0,_this select 1,%1] Spawn UnitKilled}]",_side];

if (_defense EmptyPositions "gunner" > 0 && autoDefense) then {
	_team = if (_side == WEST) then {WF_DefenseWestGrp} else {WF_DefenseEastGrp};
	_vehicles = (WF_Logic getVariable "emptyVehicles") + [_defense];
	if (_manned) then {
		_alives = (units _team) Call GetLiveUnits;
		if (count _alives < ('WFBE_MAXAIDEFENSE' Call GetNamespace)) then {
			_buildings = WF_Logic getVariable Format ["%1BaseStructures",str _side];
			_check = ['BARRACKSTYPE',_buildings,'WFBE_DEFENSEMANRANGE' Call GetNamespace,_side,_defense] Call BuildingInRange;
			_closest = _check select 0;
			_barrackNearby = _check select 1;

			//--- Manning Defenses.
			if (_barrackNearby) then {
				sleep 7;
				
				if (!(alive _closest)||(isNull _closest )) exitWith {};
				
				_type = typeOf _closest;
				_index = (Format["WFBE_%1STRUCTURENAMES",str _side] Call GetNamespace) find _type;
				_distance = (Format["WFBE_%1STRUCTUREDISTANCES",str _side] Call GetNamespace) select _index;
				_direction = (Format["WFBE_%1STRUCTUREDIRECTIONS",str _side] Call GetNamespace) select _index;
				_position = [getPos _closest,_distance,getDir _closest + _direction] Call GetPositionFrom;
				
				_type = Format ["WFBE_%1SOLDIER",str _side] Call GetNamespace;
				_soldier = [_type,_team,_position,_side] Call CreateMan;
				[_soldier] allowGetIn true;
				_soldier assignAsGunner _defense;
				[_soldier] orderGetIn true;
				
				_built = WF_Logic getVariable Format ["%1UnitsCreated",str _side];
				_built = _built + 1;
				WF_Logic setVariable [Format["%1UnitsCreated",str _side],_built,true];
				
				[_defense,_soldier] Spawn HandleDefense;
			};
		};
	};
};

if (artyUI) then {
	_isVeh = getNumber(configFile >> "CfgVehicles" >> typeOf(_defense) >> "ARTY_IsArtyVehicle");
    if (_isVeh == 1) then {
		_defense setVehicleInit "[this] ExecVM 'Common\Common_InitArtillery.sqf'";
		processInitCommands;
	};
};