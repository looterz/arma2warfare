#include "profiler.h"
PROFILER_BEGIN("Server_ConstructionStationaryDefense");

//*****************************************************************************************
//Description: Creates Defenses.
//*****************************************************************************************
private['_u','_defense','_direction','_index','_manned','_position','_side','_type','_noammo','_c','_toworld','_h','_array','_minetype','_mine','_team','_check','_alives','_buildings','_closest','_barracknearby','_isveh'];
_type = _this select 0;
_side = _this select 1;
_position = _this select 2;
_direction = _this select 3;
_index = _this select 4;
_manned = _this select 5;
_noammo = if (count _this > 6) then { _this select 6 } else { false };

_defense = _type createVehicle _position;
_defense setDir _direction;
_defense setPos _position;

if (_noammo) then {
	_defense setVehicleAmmo 0;
};

Format["Construction_StationaryDefense: A %1 %2 was created",str _side,_type] call LogInform;

//--- If it's a minefield, we exit the script while spawning it.
if (_type == 'Sign_Danger') exitWith {
	_mineType = if (_side == east) then {'MineMineE'} else {'MineMine'};
	_h = -4;
	_c = 0;
	for [{_u=0}, {_u<9}, {_u=_u+1}] do{
		_array = [((_defense worldToModel (getPos _defense)) select 0) - 16 +_c,((_defense worldToModel (getPos _defense)) select 1) + _h];
		_toWorld = _defense modelToWorld _array;
		_toWorld set[2,0];
		_mine = createMine [_mineType, _toWorld,[], 0];
		_c = _c + 4;
	};

	_h = 0;
	_c = 2;
	for [{_u=0}, {_u<8}, {_u=_u+1}] do{
		_array = [((_defense worldToModel (getPos _defense)) select 0) - 16 +_c,((_defense worldToModel (getPos _defense)) select 1) + _h];
		_toWorld = _defense modelToWorld _array;
		_toWorld set[2,0];
		_mine = createMine [_mineType, _toWorld,[], 0];
		_c = _c + 4;
	};

	_h = 4;
	_c = 0;
	for [{_u=0}, {_u<9}, {_u=_u+1}] do{
		_array = [((_defense worldToModel (getPos _defense)) select 0) - 16 +_c,((_defense worldToModel (getPos _defense)) select 1) + _h];
		_toWorld = _defense modelToWorld _array;
		_toWorld set[2,0];
		_mine = createMine [_mineType, _toWorld,[], 0];
		_c = _c + 4;
	};
	deleteVehicle _defense;
};

[_defense, _side] spawn SetKilledEventHandler;

if (_defense EmptyPositions "gunner" > 0 && (('WFBE_AIDEFENSE' Call GetNamespace) > 0)) then {
	_team = if (_side == WEST) then {WF_DefenseWestGrp} else {WF_DefenseEastGrp};

	if (_manned) then {
		_alives = (units _team) Call GetLiveUnits;
		if (count _alives < ('WFBE_AIDEFENSE' Call GetNamespace)) then {
			_buildings = (str _side) Call GetSideStructures;
			_check = ['BARRACKSTYPE',_buildings,'WFBE_DEFENSEMANRANGE' Call GetNamespace,_side,_defense] Call BuildingInRange;
			_closest = _check select 0;
			_barrackNearby = _check select 1;

			//--- Manning Defenses.
			if (_barrackNearby) then {			
				[_defense,_side,_team,_closest] Spawn HandleDefense;
			};
		};
	};
};

if (paramArtyUI) then {
	_isVeh = getNumber(configFile >> "CfgVehicles" >> typeOf(_defense) >> "ARTY_IsArtyVehicle");
    if (_isVeh == 1) then {
		_defense setVehicleInit "[this] ExecVM 'Common\Common_InitArtillery.sqf'";
		processInitCommands;
		Format["Construction_StationaryDefense: Artillery UI has been set over the %1 %2",str _side,_type] call LogInform;
	};
};

PROFILER_END();