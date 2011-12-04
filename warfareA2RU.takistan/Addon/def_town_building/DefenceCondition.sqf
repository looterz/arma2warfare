DefenceConditionGetSupplyObject = {
private['_defenceRange', '_nearTowns', '_closest', '_supply'];

	_supply = objNull;
	_defenceRange = missionNamespace getVariable "WFBE_RESPAWNRANGE";
    _nearTowns = [player,towns] Call SortByDistance;
	if ((isNull _supply) && (count _nearTowns) > 0) then {
		_closest = _nearTowns select 0;
		_sideId = _closest getVariable "sideID";
		if (_sideId == sideId) then {
			if ((player distance _closest) < _defenceRange) then { _supply = _closest };
		};
	};
	
	if (isNull _supply) then {
		_buildings = (side player) Call GetSideStructures;
		_supply = ['BARRACKSTYPE',_buildings, _defenceRange, (side player), player] Call BuildingInRange;
	};
	
	if (isNull _supply) then {
		_typeRepair = Format['WFBE_%1REPAIRTRUCKS',sideJoinedText] Call GetNamespace;
		_range = 'WFBE_REPAIRTRUCKRANGE' Call GetNamespace;
		if (!(isNil "_typeRepair")) then {
			_repairTrucks = (position player) nearEntities[_typeRepair, _range];	
			if ((count _repairTrucks) > 0) then {
				_supply = ([player, _repairTrucks] Call SortByDistance) select 0;
			};
		};
	};
	
	_supply;
};

DefenceConditionIsNearDefenceSupply = {
	if (isNull (call DefenceConditionGetSupplyObject)) then { false } else { true };
};

DefenceCondition_IsPlayerDefenceOwner = {
private['_defence', '_ownerId', '_ourSide', '_owner' ];

	_defence = _this;
	_ownerId = _defence getVariable "DefenceOwnerId";
	
	// статика неизвестно чья, значит будет наша
	if (isNil "_ownerId") exitWith { true };
	
	// всегда разрешаем продавать свое
	if ((getPlayerUID player) == _ownerId) exitWith { true };

	// поищем владельца среди членов команды
	_ourSide = if ((side player) == east) then { 'WFBE_EASTTEAMS' Call GetNamespace } else { 'WFBE_WESTTEAMS' Call GetNamespace };
	_owner = [_ourSide, { (getPlayerUID (leader _x)) == _ownerId }] call getFirstOrDefault;
	if (!(isNil "_owner")) exitWith { false };
	
	true;
};

DefenceCondition_IsPlacementAllowed = {
private['_defenceInfo', '_structureCount', '_dHmax', '_h0', '_h1', '_dH'  ];
	_defenceInfo = _this;

	_structureCount = {	(typeof(_x) == "Land_Fort_Watchtower_EP1" || typeof(_x) == "Land_Fort_Watchtower" || typeof(_x) == "WarfareBCamp") } count (position player nearObjects ["Building",15]);
	if (_structureCount > 0) exitWith { false };
	
	// запретим ставить вышке бункеры, на домах
	_dHmax = (_defenceInfo select DEFENCEINFO_MAXOVERHEIGHT);
	_dH = ((getPosASL player) select 2) - (getTerrainHeightASL (position player));
	
	if (_dHmax > 0 && (_dH > _dHmax)) exitWith { false };
	
	// ставить можно только на верхней площадке осветительной вышки
	_gndPos = [(position player) select 0, (position player) select 1, 10];	
	if (_dH > 1 && count ( _gndPos nearObjects ["Land_Ind_IlluminantTower",5]) > 0 && _dH < 20) exitWith { false };
	
	true;
};

// Покупа сооружения
DefenceConditionBuy = {
	if (!(isNull (player getVariable "DefenceTaken"))) exitWith { false; };
	if (!(isNull (player getVariable "DefencePreview"))) exitWith { false; };
	if (!(call DefenceConditionIsNearDefenceSupply)) exitWith { false };
  
	true;
};

/// Продажа сооружения
DefenceConditionSell = {
	if (!(isNull (player getVariable "DefenceTaken"))) exitWith { false; };
	if (!(isNull (player getVariable "DefencePreview"))) exitWith { false; };
	if (!(call DefenceConditionIsNearDefenceSupply)) exitWith { false };
	
	_defence = cursorTarget;
	if (player distance _defence > 3) exitWith { false };
	
	_defenceType = typeof(_defence);
	_defenceInfo = [WF_DefenceTypeData, { (_x select DEFENCEINFO_TYPENAME) == _defenceType } ] call getFirstOrDefault;
	if (isNil "_defenceInfo") exitWith { false };
	
	// продавать сооружение когда на ней сидит бот или человек нельзя
	if ((_defenceInfo select DEFENCEINFO_WEAPONTYPE) && (count (crew _defence) > 0)) exitWith { false };
	
	// продавать можно свои сооружения и сооружения созданные противником	
	if (!(_defence call DefenceCondition_IsPlayerDefenceOwner)) exitWith {false};
	
	true;
};
 
/// Размещение сооружения
DefenceConditionPlace = {
	if ((isNull (player getVariable "DefencePreview"))) exitWith { false; };
	if (!((player getVariable "DefencePreviewInfo") call DefenceCondition_IsPlacementAllowed)) exitWith { false };
	if (!(call DefenceConditionIsNearDefenceSupply)) exitWith { false };
  
	true;
 };

/// Отмена перемещения или размещения нового элемента обороны
DefenceConditionCancel = {
	if (!(isNull (player getVariable "DefencePreview"))) exitWith { true; }; 
	false;
 };

getFirstOrDefault = {
private['_container', '_fncondition', '_element', '_end', '_i', '_x'];
	_container = _this select 0;
	_fncondition = _this select 1;
	_element = nil;
	
	_end = count _container;
	_i = 0;
	while {_i < _end && isNil "_element" } do {
		_x = _container select _i;
	
		if (_x call _fncondition) then {
			_element = _x;
			break;
		};
		_i = _i + 1;
	};
	
	_element;
 };
 
/// Условие для разрешения перемещения объекта  
DefenceConditionTake = {
	if (!(isNull (player getVariable "DefenceTaken"))) exitWith { false; };
	if (!(isNull (player getVariable "DefencePreview"))) exitWith { false; };
	if (!(call DefenceConditionIsNearDefenceSupply)) exitWith { false };	
	
	_defence = cursorTarget;
	if (player distance _defence > 3) exitWith { false };
	
	_defenceType = typeof(_defence);
	_defenceInfo = [WF_DefenceTypeList, { (_x select DEFENCEINFO_TYPENAME) == _defenceType } ] call getFirstOrDefault;
	if (isNil "_defenceInfo") exitWith { false };
	
	if (!(_defenceInfo select DEFENCEINFO_WEAPONTYPE)) exitWith { false };
	if (count (crew _defence) > 0) exitWith { false };	
	
	// перемещать можно свои сооружения и сооружения созданные противником	
	if (!(_defence call DefenceCondition_IsPlayerDefenceOwner)) exitWith {false};	
	
	true;
};

/// Условие для возможности положить объект
DefenceConditionDrop = {
  if ((isNull (player getVariable "DefenceTaken"))) exitWith { false; }; 
  if (!(call DefenceConditionIsNearDefenceSupply)) exitWith { false };
  
  _taken = player getVariable "DefenceTaken";
  _defenceInfo = [WF_DefenceTypeList, { (_x select DEFENCEINFO_TYPENAME) == typeof(_taken) } ] call getFirstOrDefault;
  if (isNil "_defenceInfo") exitWith { false };
  
  if (!(_defenceInfo call DefenceCondition_IsPlacementAllowed)) exitWith { false };
  
  true;	
};