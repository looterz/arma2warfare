disableSerialization;

//--- Init.
MenuAction = -1;

_listUnits = [];

_closest = objNull;
_closestFactory = objNull;
_commander = false;
_countAlive = 0;
_currentCost = 0;
_currentIDC = 0;
_disabledColor = [0.4, 0.4, 0.4, 1];
_display = _this select 0;
_driver = false;
_enabledColor = [1, 1, 1, 0.75];
_gunner = false;
_IDCLock = 12023;
_IDCS = [12005,12006,12007,12008,12020,12021];
_IDCSVehi = [12012,12013,12014];
_isInfantry = false;
_isLocked = true;
_lastCheck = 0;
_lastSel = -1;
_lastType = 'nil';
_listBox = 12001;
_comboFaction = 12026;
_map = _display displayCtrl 12015;
_sorted = [];
_type = 'nil';
_update = true;
_updateDetails = true;
_updateList = true;
_updateMap = true;
_val = 0;
_costCoefficient = 1;
_mbu = 'WFBE_MAXGROUPSIZE' Call GetNamespace;
_currentUnit = objNull;

//--- Get the closest Factory Type in range.
_break = false;
_status = [barracksInRange,lightInRange,heavyInRange,aircraftInRange,depotInRange,hangarInRange];
_statusLabel = ['Barracks','Light','Heavy','Aircraft','Depot','Airport'];
_statusVals = [0,1,2,3,4,3];
for [{_i = 0},{(_i < 6) && !_break},{_i = _i + 1}] do {
	if (_status select _i) then {
		_break = true;
		_currentIDC = _IDCS select _i;
		_type = _statusLabel select _i;
		_val = _statusVals select _i;
	};
};

if (_type == 'nil') exitWith {closeDialog 0};

//--- Destroy local variables.
_break = nil;
_status = nil;
_statusLabel = nil;
_statusVals = nil;

//--- Enable the current IDC.
_IDCS = _IDCS - [_currentIDC];
{
	_con = _display DisplayCtrl _x;
	_con ctrlSetTextColor [0.4, 0.4, 0.4, 1];
} forEach _IDCS;

//--- Fill the list function.
_fillList = {
	Private ['_addin','_c','_currentUpgrades','_filler','_filter','_i','_listBox','_listNames','_u','_value'];
	_listNames = _this select 0;
	_filler = _this select 1;
	_listBox = _this select 2;
	_value = _this select 3;
	_u = 0;
	_i = 0;
	
	_currentUpgrades = (sideJoinedText) Call GetSideUpgrades;
	_filter = Format["WFBE_%1%2CURRENTFACTIONSELECTED",sideJoinedText,_filler] Call GetNamespace;
	if (isNil '_filter') then {_filter = "nil"} else {
		if (_filter == 0) then {
			_filter = 'nil';
		} else {
			_filter = ((Format["WFBE_%1%2FACTIONS",sideJoinedText,_filler] Call GetNamespace) select _filter);
		};
	};
	
	if (paramTrade && paramVehicleComponents) then {
		_products = [_closestFactory] call marketGetMarketProducts;
	};
	
	_tmplistUnits = [];
	{
		_addin = true;
		_c = _x Call GetNamespace;
		if (_filter != "nil") then {
			if ((_c select QUERYUNITFACTION) != _filter) then {_addin = false};
		};
		if ((_c select QUERYUNITUPGRADE) <= (_currentUpgrades select _value) && _addin) then {
		
			_basePrice = if (_x isKindOf "Man") then { _x call GetUnitEquipmentPrice; } else { _c select QUERYUNITPRICE; };
			
			if (paramTrade && paramVehicleComponents) then {
				_basePrice = [_products, _x, _basePrice] call marketGetUnitPriceEx;
			};
			
			_cost = _basePrice;
			_cost = (ceil(_basePrice*_costCoefficient / 5))*5;		
			if (_cost < 5) then { _cost = 5; };
			
			_tmplistUnits = _tmplistUnits + [ [ ('$'+str (_cost)), (_c select QUERYUNITLABEL), _filler, _u] ];
			_i = _i + 1;
		};
		_u = _u + 1;
	} forEach _listNames;	
	
	_u = 0;
	lnbClear _listBox;
	{
		lnbAddRow [_listBox, [(_x select 0), (_x select 1)] ];
		lnbSetData [_listBox,[_u,0], (_x select 2)];
		lnbSetValue [_listBox,[_u,0], (_x select 3)];
		_u = _u + 1;
	} forEach _tmplistUnits;
	
	_tmplistUnits = nil;
	
	if (_i > 0) then {lnbSetCurSelRow [_listBox,0]} else {lnbSetCurSelRow [_listBox,-1]};
};

_changeFactionCombo = {
	Private['_get','_lb','_type'];
	_lb = _this select 0;
	_type = _this select 1;
	
	lbClear _lb;
	{
		lbAdd [_lb,_x];
	} forEach (Format["WFBE_%1%2FACTIONS",sideJoinedText,_type] Call GetNamespace);
	
	_get = Format["WFBE_%1%2CURRENTFACTIONSELECTED",sideJoinedText,_type] Call GetNamespace;
	if (isNil '_get') then {
		lbSetCurSel [_lb,0];
	} else {
		lbSetCurSel [_lb,_get];
	};
};

//--- Loop.
while {alive player && dialog} do {
	//--- Nothing in range? exit!.
	if (!barracksInRange && !lightInRange && !heavyInRange && !aircraftInRange && !hangarInRange && !depotInRange) exitWith {closeDialog 0};
	if (side player != sideJoined || !dialog) exitWith {closeDialog 0};
	
	//--- Purchase.
	if (MenuAction == 1) then {
		MenuAction = -1;
		_currentRow = lnbCurSelRow _listBox;
		_currentValue = lnbValue[_listBox,[_currentRow,0]];
		_unit = _listUnits select _currentValue;
		_currentUnit = _unit Call GetNamespace;	
		
		if ((_currentRow) != -1) then {
			_funds = Call GetPlayerFunds;
			_skip = false;
			if (_funds < _currentCost) then {_skip = true;hint parseText(Format[localize 'STR_WF_Funds_Missing',_currentCost - _funds,_currentUnit select QUERYUNITLABEL])};
			if !(_skip) then {
				_size = Count ((Units (group player)) Call GetLiveUnits);
				if (_isInfantry) then {if ((unitQueu + _size + 1) > _mbu) then {_skip = true;hint parseText(Format [localize 'STR_WF_MaxGroup',_mbu])}};
				if (!_isInfantry && !_skip) then {
					_cpt = 0;
					if (_driver) then {_cpt = _cpt + 1};
					if (_gunner) then {_cpt = _cpt + 1};
					if (_commander) then {_cpt = _cpt + 1};
					if ((unitQueu + _size + _cpt) > _mbu && _cpt != 0) then {_skip = true;hint parseText(Format [localize 'STR_WF_MaxGroup',_mbu])};
				};
			};
			if !(_skip) then {
				_queu = _closest getVariable 'queu';
				_txt = parseText(Format [localize 'STR_WF_BuyEffective',_currentUnit select QUERYUNITLABEL]);
				if (!isNil '_queu') then {if (count _queu > 0) then {_txt = parseText(Format [localize 'STR_WF_Queu',_currentUnit select QUERYUNITLABEL])}};
				hint _txt;
				_params = if (_isInfantry) then {[_closest,_unit,[]]} else {[_closest,_unit,[_driver,_gunner,_commander,_isLocked]]};
				_params Spawn BuildUnit;
				-(_currentCost) Call ChangePlayerFunds;
				
				if (paramTrade && paramVehicleComponents) then {
					[_closestFactory, _unit] Call marketUseResourcesToBuyUnit;
				};
			};
		};
	};
	
	//--- Tabs selection.
	if (MenuAction == 101) then {MenuAction = -1;if (barracksInRange) then {_currentIDC = 12005;_type = 'Barracks';_val = 0;_update = true}};
	if (MenuAction == 102) then {MenuAction = -1;if (lightInRange) then {_currentIDC = 12006;_type = 'Light';_val = 1;_update = true}};
	if (MenuAction == 103) then {MenuAction = -1;if (heavyInRange) then {_currentIDC = 12007;_type = 'Heavy';_val = 2;_update = true}};
	if (MenuAction == 104) then {MenuAction = -1;if (aircraftInRange) then {_currentIDC = 12008;_type = 'Aircraft';_val = 3;_update = true}};
	if (MenuAction == 105) then {MenuAction = -1;if (depotInRange) then {_currentIDC = 12020;_type = 'Depot';_val = 4;_update = true}};
	if (MenuAction == 106) then {MenuAction = -1;if (hangarInRange) then {_currentIDC = 12021;_type = 'Airport';_val = 3;_update = true}};
	
	//--- driver-gunner-commander icons.
	if (MenuAction == 201) then {MenuAction = -1;_driver = if (_driver) then {false} else {true};_updateDetails = true};
	if (MenuAction == 202) then {MenuAction = -1;_gunner = if (_gunner) then {false} else {true};_updateDetails = true};
	if (MenuAction == 203) then {MenuAction = -1;_commander = if (_commander) then {false} else {true};_updateDetails = true};
	
	//--- Factory DropDown list value has changed.
//--- TODO: update = true call repaint list view twice!
	if (MenuAction == 301) then {
		MenuAction = -1;_factSel = lbCurSel 12018;
		
		if (_closest != _sorted select _factSel) then {
			_updateMap = true;
			_update=true;
			_closest = _sorted select _factSel;
		};
		
	};
	
	//--- Selection change, we update the details.
	if (MenuAction == 302) then {MenuAction = -1;_updateDetails = true};
	
	//--- Faction Filter changed.
	if (MenuAction == 303) then {MenuAction = -1;_update = true;[Format["WFBE_%1%2CURRENTFACTIONSELECTED",sideJoinedText,_type],(lbCurSel _comboFaction),true] Call SetNamespace};
	
	//--- Lock icon.
	if (MenuAction == 401) then {MenuAction = -1;_isLocked = if (_isLocked) then {false} else {true};_updateDetails = true};
	
	//--- Player funds.
	ctrlSetText [12019,Format [localize 'STR_WF_Cash',Call GetPlayerFunds]];

	//--- Update factories.
	if (_updateList) then {
	
		format["GUI_BuyUnit UpdateList type=%1", _type] call LogTrace;
	
		switch (_type) do {
			//--- Specials.
			case 'Depot': {
				_nObjects = nearestObjects [player, WFDEPOT,('WFBE_TOWNPURCHASERANGE' Call GetNamespace)];
				_closest = if (count _nObjects > 0) then {_nObjects select 0} else {objNull};
				_sorted = [_closest];
			};
			case 'Airport': {
				_sorted = [player,Airfields] Call SortByDistance;
				_closest = _sorted select 0;
				_sorted = [_closest];
			};
			//--- Factories
			default {
				_buildings = (sideJoinedText) Call GetSideStructures;
				_factories = [sideJoined,Format ['WFBE_%1%2TYPE',sideJoinedText,_type] Call GetNamespace,_buildings] Call GetFactories;
				_countAlive = count _factories;
			
				_sorted = [player,_factories] Call SortByDistance;
				_closest = _sorted select 0;
			
				if (paramBuyVehiclesInTown && _countAlive > 0 && depotInRange && _type != 'Aircraft') then {
					
					_nearDepotList = nearestObjects [player, WFDEPOT,('WFBE_TOWNPURCHASERANGE' Call GetNamespace)];
					if (count _nearDepotList > 0) then {
						
						_nearDepot = _nearDepotList select 0;
						if (_closest distance _nearDepot >  0.8*('WFBE_DEFENSEMANRANGE' Call GetNamespace)) then {
						// -- if  town has factory not add buy from central depot
							_factories = _factories + [_nearDepot];
							_sorted = [player,_factories] Call SortByDistance;
							_closest = _sorted select 0;						
						};
					};
				};
			};
		};

		//--- Refresh the Factory DropDown list.
		lbClear 12018;
		{
			_nearest = [_x,towns] Call SortByDistance;
			_nearTown = (_nearest select 0) getVariable 'name';
			_txt = _type + ' ' + _nearTown + ' ' + str (round(player distance _x)) + 'M';
			lbAdd[12018,_txt];
		} forEach _sorted;
		lbSetCurSel [12018,0];
		
		_updateList = false;
		_updateMap = true;
	};
	
	//--- Update tabs.
	if (_update) then {

		_costCoefficient = 1;
		_closestFactory = _closest;
		
		if (_type != "Depot" && _type != "Airport" && !(isNull _closest)) then {

			_discount = 0;
			_closestFactory = _closest;
			if ((typeOf _closest) in WFDEPOT) then 
			{ 
				_buildings1 = (sideJoinedText) Call GetSideStructures;				
				_factories1 = [sideJoined,Format ['WFBE_%1%2TYPE',sideJoinedText,_type] Call GetNamespace,_buildings1] Call GetFactories;
				_sorted1 = [_closest, _factories1] Call SortByDistance;
				
				format["F=%1", _factories1] call LogMedium;
				format["S=%1", _sorted1] call LogMedium;
				
				_closestFactory = if (count _sorted1 > 0) then { _sorted1 select 0; } else { objNull; };
			}; //-- buy in central depot
		
			if (!(isNull _closestFactory)) then {

				_range = 'WFBE_DEFENSEMANRANGE' Call GetNamespace;
				if (isNil '_range') then { _range = 300; };
				_range = _range * 0.8;
				
				_depotNearFactory = nearestObjects [_closestFactory, WFDEPOT, _range];
				_nearTown = if (count _depotNearFactory > 0) then {_depotNearFactory select 0} else {objNull; };
				if (!isNull _nearTown) then {
				
					_sideID = _nearTown getVariable "sideID";
					if !(isNil "_sideID") then {
					
						_supplyValue = _nearTown getVariable "supplyValue";
						_maxSV = _nearTown getVariable "maxSupplyValue";
					
						if (_sideID == sideID) then {
							_discount = 0.1 + 0.2*(_maxSV / 120) * (_supplyValue / _maxSV);
						};
					};
				};

				_costCoefficient = _costCoefficient - _discount;		
				if ((typeOf _closest) in WFDEPOT) then {
					_dist = _closest distance _closestFactory;
					_costCoefficient = _costCoefficient + (_dist / 4000); // -- increase price for delivery to 25% for each 1000m
					
					_supplyValue = _closest getVariable "supplyValue";
					_maxSV = _closest getVariable "maxSupplyValue";
					
					_k = (0.3 -  (0.6*_supplyValue / 120) ); 
					if (_k > 0.3)  then { _k = 0.3;  };
					if (_k < -0.3) then { _k = -0.3; };
					
					_costCoefficient = _costCoefficient + _k;
				};
			};
		};
		
		_listUnits = Format ['WFBE_%1%2UNITS',sideJoinedText,_type] Call GetNamespace;

		CF_COEF = _costCoefficient;
		CF_ClosestFactory = _closestFactory;
		CF_FACT = _closest;
		[_comboFaction,_type] Call _changeFactionCombo;
		[_listUnits,_type,_listBox,_val] Call _fillList;
		
		//--- Update tabs icons.
		_IDCS = [12005,12006,12007,12008,12020,12021];
		_IDCS = _IDCS - [_currentIDC];
		_con = _display DisplayCtrl _currentIDC;
		_con ctrlSetTextColor [0.75,0.75,0.75,1];
		{_con = _display DisplayCtrl _x;_con ctrlSetTextColor [0.4, 0.4, 0.4, 1]} forEach _IDCS;

		_update = false;
		
		if (!_updateMap) then {
  		      _updateList = true;
		      _updateDetails = true;
                };
	};
	
	//--- Display Factory Queu.
	_queu = _closest getVariable "queu";
	_value = if (isNil '_queu') then {0} else {count (_closest getVariable "queu")};
	ctrlSetText[12024,Format[localize 'STR_WF_Queued',str _value]];
	
	//--- List selection changed.
	if (_updateDetails) then {
		_currentRow = lnbCurSelRow _listBox;
		//--- Our list is not empty.
		if (_currentRow != -1) then {
			_currentValue = lnbValue[_listBox,[_currentRow,0]];
			_currentUnit = (_listUnits select _currentValue) Call GetNamespace;
			ctrlSetText [12009,_currentUnit select QUERYUNITPICTURE];
			_currentCost = _currentUnit select QUERYUNITPRICE;

			_unit = _listUnits select _currentValue;
			if (_unit isKindOf "Man") then { 
				_currentCost = _unit call GetUnitEquipmentPrice; 
			};
			
			if (paramTrade && paramVehicleComponents) then {
				_currentCost = [_closestFactory, _unit, _currentCost] call marketGetUnitPrice;
			};
			
			_isInfantry = if ((_listUnits select _currentValue) isKindOf 'Man') then {true} else {false};
			
			//--- Update driver-gunner-commander icons.
			if (!_isInfantry && _type != 'Depot') then {
				_slots = _currentUnit select QUERYUNITCREW;
				_c = 0;
				_extra = 0;
				
				//--- Enabled AI by default.
				_maxOut = false;
				if (_lastType != _type || _lastSel != _currentRow) then {_maxOut = true};
				
				switch (_slots) do {
					case 1: {
						if (_maxOut) then {_driver = true};
						if (_driver) then {_extra = _extra + 1};
						_gunner = false;
						_commander = false;
					};
					case 2: {
						if (_maxOut) then {_driver = true;_gunner = true};
						if (_driver) then {_extra = _extra + 1};
						if (_gunner) then {_extra = _extra + 1};
						_commander = false;
					};
					case 3: {
						if (_maxOut) then {_driver = true;_gunner = true;_commander = true};
						if (_driver) then {_extra = _extra + 1};
						if (_gunner) then {_extra = _extra + 1};
						if (_commander) then {_extra = _extra + 1};					
					};
				};
				
				//--- Show the icons.
				{
					_show = false;
					if (_c < _slots) then {_show = true};
					ctrlShow [_x,_show];
					_c = _c + 1;
				} forEach _IDCSVehi;
				
				_i = 0;
				
				//--- Set the icons.
				{
					_color = if (_x) then {_enabledColor} else {_disabledColor};
					_con = _display displayCtrl (_IDCSVehi select _i);
					_con ctrlSetTextColor _color;
					_i = _i + 1;
				} forEach [_driver,_gunner,_commander];

				//--- Set the 'extra' price.
				_currentCost = _currentCost + (('WFBE_CREWCOST' Call GetNamespace) * _extra);
			} else {
				{ctrlShow [_x,false]} forEach (_IDCSVehi);
				_driver = false;
				_gunner = false;
				_commander = false;
			};
			
			//--- Lock Icon.
			if !(_isInfantry) then {
				ctrlShow[_IDCLock,true];
				_color = if (_isLocked) then {_enabledColor} else {_disabledColor};
				_con = _display displayCtrl _IDCLock;
				_con ctrlSetTextColor _color;
			} else {
				ctrlShow[_IDCLock,false];
			};

			//--- Long description.
			_utype = _listUnits select _currentValue;
			_txt = '';
			if (isClass (configFile >> 'CfgVehicles' >> _utype >> 'Library')) then {
				_txt = getText (configFile >> 'CfgVehicles' >> _utype >> 'Library' >> 'libTextDesc');
			};
			
			if (paramTrade && paramVehicleComponents) then {
				_txtRequire = [_closestFactory, _utype] call marketGetUnitRequirementText;
				_txt = _txtRequire + _txt;
			};
			
			(_display displayCtrl 12022) ctrlSetStructuredText (parseText _txt);
			
			_currentCost = (ceil(_currentCost * _costCoefficient / 5))*5;		
			if (_currentCost < 5) then { _currentCost = 5; };				
			
			ctrlSetText [12010,Format [localize 'STR_WF_Price',_currentCost]];
			_updateDetails = false;
		} else {
			ctrlSetText [12009, ''];
			ctrlSetText [12010, ''];
			(_display displayCtrl 12022) ctrlSetStructuredText (parseText '');
		};
	};
	
	//--- Update the Factory Minimap position.
	if (_updateMap) then {
		ctrlMapAnimClear _map;
		_map ctrlMapAnimAdd [2,.075,getPos _closest];
		ctrlMapAnimCommit _map;
		_updateMap = false;
	};
	
	//--- Check that the factories of the current type are still alive.
	_lastCheck = _lastCheck + 0.1;
	if (_lastCheck > 2 && _type != 'Depot' && _type != 'Airport') then {
		_lastCheck = 0;
		_buildings = (sideJoinedText) Call GetSideStructures;
		_factories = [sideJoined,Format ['WFBE_%1%2TYPE',sideJoinedText,_type] Call GetNamespace,_buildings] Call GetFactories;
		if (count _factories != _countAlive) then {_updateList = true};
	};
	
	_lastSel = lnbCurSelRow _listBox;
	_lastType = _type;
	sleep 0.1;
};