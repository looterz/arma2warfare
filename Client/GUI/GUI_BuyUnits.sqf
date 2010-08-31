disableSerialization;

//--- Init.
MenuAction = -1;

_listCosts = [];
_listCrews = [];
_listDescriptions = [];
_listImages = [];
_listTimes = [];
_listUnits = [];
_listUpgrades = [];

_closest = objNull;
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
_map = _display displayCtrl 12015;
_sorted = [];
_type = '';
_update = true;
_updateDetails = true;
_updateList = true;
_updateMap = true;
_val = 0;
_mbu = 'WFBE_MAXGROUPSIZE' Call GetNamespace;

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
	Private ['_currentUpgrades','_filler','_i','_listBox','_listCosts','_listNames','_listUpgrades','_u','_value'];
	_listCosts = _this select 0;
	_listNames = _this select 1;
	_listUpgrades = _this select 2;
	_filler = _this select 3;
	_listBox = _this select 4;
	_value = _this select 5;
	_u = 0;
	_i = 0;
	
	_currentUpgrades = WF_Logic getVariable Format ['%1Upgrades',sideJoinedText];
	
	lnbClear _listBox;
	{
		if ((_listUpgrades select _u) <= (_currentUpgrades select _value)) then {
			lnbAddRow [_listBox,['$'+str (_listCosts Select _u),_x]];
			lnbSetData [_listBox,[_i,0],_filler];
			lnbSetValue [_listBox,[_i,0],_u];
			_i = _i + 1;
		};
		_u = _u + 1;
	} forEach _listNames;
	
	if (_i > 0) then {lnbSetCurSelRow [_listBox,0]} else {lnbSetCurSelRow [_listBox,-1]};
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
		_currentCost = _listCosts select _currentValue;
		_unit = _listUnits select _currentValue;
		_reupdate = false;
		if (_type == 'Depot') then {
			if (_unit isKindOf 'Man') then {_isInfantry = true;_reupdate = true};
		};
		if !(_isInfantry) then {
			_extra = 0;
			if (_driver) then {_extra = _extra + 1};
			if (_gunner) then {_extra = _extra + 1};
			if (_commander) then {_extra = _extra + 1};
			_currentCost = _currentCost + (('WFBE_CREWCOST' Call GetNamespace) * _extra);
		};
		if ((_currentRow) != -1) then {
			_funds = Call GetPlayerFunds;
			_skip = false;
			if (_funds < _currentCost) then {_skip = true;hint parseText(Format[localize 'STR_WF_Funds_Missing',_currentCost - _funds,_listDescriptions select _currentValue])};
			if (!_skip) then {
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
			if (!_skip) then {
				_queu = _closest getVariable 'queu';
				_txt = parseText(Format [localize 'STR_WF_BuyEffective',_listDescriptions select _currentValue]);
				if (!isNil '_queu') then {if (count _queu > 0) then {_txt = parseText(Format [localize 'STR_WF_Queu',_listDescriptions select _currentValue])}};
				hint _txt;
				_params = if (_isInfantry) then {[_closest,_unit,[]]} else {[_closest,_unit,[_driver,_gunner,_commander,_isLocked]]};
				_params Spawn BuildUnit;
				-(_currentCost) Call ChangePlayerFunds;
			};
		};
		if (_reupdate) then {_reupdate = false; _isInfantry = false};
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
	if (MenuAction == 301) then {MenuAction = -1;_factSel = lbCurSel 12018;_closest = _sorted select _factSel;_updateMap = true};
	
	//--- Selection change, we update the details.
	if (MenuAction == 302) then {MenuAction = -1;_updateDetails = true};
	
	//--- Lock icon.
	if (MenuAction == 401) then {MenuAction = -1;_isLocked = if (_isLocked) then {false} else {true};_updateDetails = true};
	
	//--- Player funds.
	ctrlSetText [12019,Format [localize 'STR_WF_Cash',Call GetPlayerFunds]];
	
	//--- Update tabs.
	if (_update) then {
		_listUnits = Format ['WFBE_%1%2UNITS',sideJoinedText,_type] Call GetNamespace;
		_listDescriptions = Format ['WFBE_%1%2Descriptions',sideJoinedText,_type] Call GetNamespace;
		_listImages =  Format ['WFBE_%1%2IMAGES',sideJoinedText,_type] Call GetNamespace;
		_listCosts = Format ['WFBE_%1%2COSTS',sideJoinedText,_type] Call GetNamespace;
		_listTimes = Format ['WFBE_%1%2TIMES',sideJoinedText,_type] Call GetNamespace;
		_listUpgrades = Format ['WFBE_%1%2UPGRADES',sideJoinedText,_type] Call GetNamespace;
		_listCrews = [];
		
		//--- We load the crews if the type is not Barracks.
		_isInfantry = true;
		if (_type != 'Barracks') then {
			_listCrews = Format ['WFBE_%1%2CREWS',sideJoinedText,_type] Call GetNamespace;
			_isInfantry = false;
		};
		
		[_listCosts,_listDescriptions,_listUpgrades,_type,_listBox,_val] Call _fillList;
		
		//--- Update tabs icons.
		_IDCS = [12005,12006,12007,12008,12020,12021];
		_IDCS = _IDCS - [_currentIDC];
		_con = _display DisplayCtrl _currentIDC;
		_con ctrlSetTextColor [0.75,0.75,0.75,1];
		{_con = _display DisplayCtrl _x;_con ctrlSetTextColor [0.4, 0.4, 0.4, 1]} forEach _IDCS;
		
		_update = false;
		_updateList = true;
		_updateDetails = true;
	};
	
	//--- Update factories.
	if (_updateList) then {
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
				_buildings = WF_Logic getVariable Format ['%1BaseStructures',sideJoinedText];
				_factories = [sideJoined,Format ['WFBE_%1%2TYPE',sideJoinedText,_type] Call GetNamespace,_buildings] Call GetFactories;
				_sorted = [player,_factories] Call SortByDistance;
				_closest = _sorted select 0;
				_countAlive = count _factories;
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
			ctrlSetText [12009,_listImages select _currentValue];
			_currentCost = _listCosts select _currentValue;
			
			//--- Update driver-gunner-commander icons.
			if (!_isInfantry && _type != 'Depot') then {
				_slots = _listCrews select _currentValue;
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
			if (!_isInfantry) then {
				ctrlShow[_IDCLock,true];
				_color = if (_isLocked) then {_enabledColor} else {_disabledColor};
				_con = _display displayCtrl _IDCLock;
				_con ctrlSetTextColor _color;
			} else {
				ctrlShow[_IDCLock,false];
			};

			//--- Long description.
			_utype = _listUnits select _currentValue;
			if (isClass (configFile >> 'CfgVehicles' >> _utype >> 'Library')) then {
				_txt = getText (configFile >> 'CfgVehicles' >> _utype >> 'Library' >> 'libTextDesc');
				(_display displayCtrl 12022) ctrlSetStructuredText (parseText _txt);
			} else {
				(_display displayCtrl 12022) ctrlSetStructuredText (parseText '');
			};
			
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
		_buildings = WF_Logic getVariable Format ['%1BaseStructures',sideJoinedText];
		_factories = [sideJoined,Format ['WFBE_%1%2TYPE',sideJoinedText,_type] Call GetNamespace,_buildings] Call GetFactories;
		if (count _factories != _countAlive) then {_updateList = true};
	};
	
	_lastSel = lnbCurSelRow _listBox;
	_lastType = _type;
	sleep 0.1;
};