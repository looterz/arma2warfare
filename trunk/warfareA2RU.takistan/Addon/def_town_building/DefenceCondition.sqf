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

defenceGetSupplyObjectResult = false;
defenceGetSupplyObjectTimeout = -1;
 
DefenceGetSupplyObject = {
private['_defenceRange', '_nearTowns', '_closest', '_supply'];

	if (defenceGetSupplyObjectTimeout > time) exitWith { defenceGetSupplyObjectResult };

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
	
	defenceGetSupplyObjectResult = _supply;
	defenceGetSupplyObjectTimeout = if (isNull defenceGetSupplyObjectResult) then { time + 10 } else { time + 5 };	
	_supply;
};

DefenceIsNearDefenceSupply = {
	if (isNull (call DefenceGetSupplyObject)) then { false } else { true };
};

DefenceIsPlayerDefenceOwner = {
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

DefenceIsPlacementAllowed = {
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

statDefenceBuy = 0;
statDefenceSell = 0;
statDefencePlace = 0;
statDefenceCancel = 0;
statDefenceTake = 0;
statDefenceDrop = 0;

DefencePrintStats = {
private['_txt'];	
	_txt = format["time=%1; ", time];
	_txt = _txt + format["Buy=%1; ", statDefenceBuy];
	_txt = _txt + format["Sell=%1; ", statDefenceSell];
	_txt = _txt + format["Place=%1; ", statDefencePlace];
	_txt = _txt + format["Cancel=%1; ", statDefenceCancel];
	_txt = _txt + format["Take=%1; ", statDefenceTake];
	_txt = _txt + format["Drop=%1; ", statDefenceDrop];
	
	diag_log _txt;
};

defenceBuyContitionTimeout = -1;
defenceBuyContitionState = false;
DefenceConditionBuy = {
		if (defenceSellContitionState || defenceTakeConditionState || defencePlaceConditionState || defenceCancelConditionState) exitWith { 
			defenceBuyContitionState = false;
			defenceBuyContitionTimeout = -1;
			false 
		};

		if (defenceBuyContitionTimeout < time) then {
				defenceBuyContitionState = (call DefenceConditionBuyInternal);
				defenceBuyContitionTimeout = if (defenceBuyContitionState) then { time + 5 } else { time + 10 };
		};
		defenceBuyContitionState;
};

defencePlaceConditionTimeout = -1;
defencePlaceConditionState = false;
DefenceConditionPlace = {
		if (defenceBuyContitionState) exitWith { 
			defencePlaceConditionState = false;
			defencePlaceConditionTimeout = -1;			
			false;
		};

		if (defencePlaceConditionTimeout < time) then {
				defencePlaceConditionState = (call DefenceConditionPlaceInternal);
				defencePlaceConditionTimeout = if (defencePlaceConditionState) then { time + 0.5 } else { time + 5 };
		};
		defencePlaceConditionState;
};

defenceCancelConditionTimeout = -1;
defenceCancelConditionState = false;
DefenceConditionCancel = {
		if (defenceBuyContitionState) exitWith { 
			defenceCancelConditionState = false;
			defenceCancelConditionTimeout = -1;			
			false;
		};

		if (defenceCancelConditionTimeout < time) then {
				defenceCancelConditionState = (call DefenceConditionCancelInternal);
				defenceCancelConditionTimeout = if (defenceCancelConditionState) then { time + 0.5 } else { time + 5 };
		};
		defenceCancelConditionState;
};


defenceSellContitionTimeout = -1;
defenceSellContitionState = false;
DefenceConditionSell = {
		if (defenceCancelConditionState || defencePlaceConditionState || defenceDropConditionState) exitWith { 
			defenceSellContitionState = false;
			defenceSellContitionTimeout = -1;			
			false;
		};

		if (defenceSellContitionTimeout < time) then {
				defenceSellContitionState = (call DefenceConditionSellInternal);
				defenceSellContitionTimeout = if (defenceSellContitionState) then { time + 0.5 } else { time + 2.5 };
		};
		defenceSellContitionState;
};


defenceTakeConditionTimeout = -1;
defenceTakeConditionState = false;
DefenceConditionTake = {
		if (defenceCancelConditionState || defencePlaceConditionState || defenceDropConditionState) exitWith { 
			defenceTakeConditionState = false;
			defenceTakeConditionTimeout = -1;			
			false;
		};

		if (defenceTakeConditionTimeout < time) then {
				defenceTakeConditionState = (call DefenceConditionTakeInternal);
				defenceTakeConditionTimeout = if (defenceTakeConditionState) then { time + 0.5 } else { time + 2.5 };
		};
		defenceTakeConditionState;
};

defenceDropConditionTimeout = -1;
defenceDropConditionState = false;
DefenceConditionDrop = {
		if (defenceBuyContitionState || defenceCancelConditionState || defencePlaceConditionState || defenceTakeConditionState || defenceSellContitionState) exitWith { 
			defenceDropConditionState = false;
			defenceDropConditionTimeout = -1;			
			false;
		};

		if (defenceDropConditionTimeout < time) then {
				defenceDropConditionState = (call DefenceConditionDropInternal);
				defenceDropConditionTimeout = if (defenceDropConditionState) then { time + 0.5 } else { time + 5 };
		};
		defenceDropConditionState;
};


// Покупа сооружения
DefenceConditionBuyInternal = {
	statDefenceBuy = statDefenceBuy+1;

	if (!(isNull (player getVariable "DefenceTaken"))) exitWith { false; };
	if (!(isNull (player getVariable "DefencePreview"))) exitWith { false; };
	if (!(call DefenceIsNearDefenceSupply)) exitWith { false };
  
	true;
};


/// Продажа сооружения
DefenceConditionSellInternal = {
private['_defence', '_defenceType'];

	statDefenceSell = statDefenceSell + 1;

	if (!(isNull (player getVariable "DefenceTaken"))) exitWith { false; };
	if (!(isNull (player getVariable "DefencePreview"))) exitWith { false; };
	if (!(call DefenceIsNearDefenceSupply)) exitWith { false };
	
	_defence = cursorTarget;
	if (player distance _defence > 3) exitWith { false };
	
	_defenceType = typeof(_defence);
	_defenceInfo = [WF_DefenceTypeData, { (_x select DEFENCEINFO_TYPENAME) == _defenceType } ] call getFirstOrDefault;
	if (isNil "_defenceInfo") exitWith { false };
	
	// продавать сооружение когда на ней сидит бот или человек нельзя
	if ((_defenceInfo select DEFENCEINFO_WEAPONTYPE) && (count (crew _defence) > 0)) exitWith { false };
	
	// продавать можно свои сооружения и сооружения созданные противником	
	if (!(_defence call DefenceIsPlayerDefenceOwner)) exitWith {false};
	
	true;
};
 
/// Размещение сооружения
DefenceConditionPlaceInternal = {
	statDefencePlace = statDefencePlace + 1;

	if ((isNull (player getVariable "DefencePreview"))) exitWith { false; };
	if (!((player getVariable "DefencePreviewInfo") call DefenceIsPlacementAllowed)) exitWith { false };
	if (!(call DefenceIsNearDefenceSupply)) exitWith { false };
  
	true;
 };

/// Отмена перемещения или размещения нового элемента обороны
DefenceConditionCancelInternal = {
	statDefenceCancel = statDefenceCancel + 1;

	if (!(isNull (player getVariable "DefencePreview"))) exitWith { true; }; 
	false;
 };

/// Условие для разрешения перемещения объекта  
DefenceConditionTakeInternal = {
private['_defence', '_defenceType', '_defenceInfo'];
	statDefenceTake = statDefenceTake+1;

	if (!(isNull (player getVariable "DefenceTaken"))) exitWith { false; };
	if (!(isNull (player getVariable "DefencePreview"))) exitWith { false; };
	if (!(call DefenceIsNearDefenceSupply)) exitWith { false };	
	
	_defence = cursorTarget;
	if (player distance _defence > 3) exitWith { false };
	
	_defenceType = typeof(_defence);
	_defenceInfo = [WF_DefenceTypeList, { (_x select DEFENCEINFO_TYPENAME) == _defenceType } ] call getFirstOrDefault;
	if (isNil "_defenceInfo") exitWith { false };
	
	if (!(_defenceInfo select DEFENCEINFO_WEAPONTYPE)) exitWith { false };
	if (count (crew _defence) > 0) exitWith { false };	
	
	// перемещать можно свои сооружения и сооружения созданные противником	
	if (!(_defence call DefenceIsPlayerDefenceOwner)) exitWith {false};	
	
	true;
};

/// Условие для возможности положить объект
DefenceConditionDropInternal = {
private['_taken', '_defenceType'];
	statDefenceDrop = statDefenceDrop+1;

  if ((isNull (player getVariable "DefenceTaken"))) exitWith { false; }; 
  if (!(call DefenceIsNearDefenceSupply)) exitWith { false };
  
  _taken = player getVariable "DefenceTaken";
  _defenceInfo = [WF_DefenceTypeList, { (_x select DEFENCEINFO_TYPENAME) == typeof(_taken) } ] call getFirstOrDefault;
  if (isNil "_defenceInfo") exitWith { false };
  
  if (!(_defenceInfo call DefenceIsPlacementAllowed)) exitWith { false };
  
  true;	
};