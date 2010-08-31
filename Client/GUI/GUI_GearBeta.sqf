/* Important, use +array if you plan to use Setters */
_primary = +(WF_Logic getVariable 'primaryClasses');
_primaryCosts = +(WF_Logic getVariable 'primaryCosts');
_primaryPictures = +(WF_Logic getVariable 'primaryPictures');
_primaryNames = +(WF_Logic getVariable 'primaryNames');
_primaryMagazines = +(WF_Logic getVariable 'primaryMagazines');
_primaryUpgrades = +(WF_Logic getVariable 'primaryUpgrades');
_primaryAllowed = +(WF_Logic getVariable 'primaryAllowed');

_secondary = +(WF_Logic getVariable 'secondaryClasses');
_secondaryCosts = +(WF_Logic getVariable 'secondaryCosts');
_secondaryPictures = +(WF_Logic getVariable 'secondaryPictures');
_secondaryNames = +(WF_Logic getVariable 'secondaryNames');
_secondaryMagazines = +(WF_Logic getVariable 'secondaryMagazines');
_secondaryUpgrades = +(WF_Logic getVariable 'secondaryUpgrades');
_secondaryAllowed = +(WF_Logic getVariable 'secondaryAllowed');

_sidearm = +(WF_Logic getVariable 'sidearmClasses');
_sidearmCosts = +(WF_Logic getVariable 'sidearmCosts');
_sidearmPictures = +(WF_Logic getVariable 'sidearmPictures');
_sidearmNames = +(WF_Logic getVariable 'sidearmNames');
_sidearmMagazines = +(WF_Logic getVariable 'sidearmMagazines');
_sidearmUpgrades = +(WF_Logic getVariable 'sidearmUpgrades');
_sidearmAllowed = +(WF_Logic getVariable 'sidearmAllowed');

_misc = +(WF_Logic getVariable 'miscClasses');
_miscCosts = +(WF_Logic getVariable 'miscCosts');
_miscPictures = +(WF_Logic getVariable 'miscPictures');
_miscTypes = +(WF_Logic getVariable 'miscTypes');
_miscNames = +(WF_Logic getVariable 'miscNames');
_miscUpgrades = +(WF_Logic getVariable 'miscUpgrades');
_miscAllowed = +(WF_Logic getVariable 'miscAllowed');

_magazine = +(WF_Logic getVariable 'magazineClasses');
_magazineCosts = +(WF_Logic getVariable 'magazineCosts');
_magazinePictures = +(WF_Logic getVariable 'magazinePictures');
_magazineNames = +(WF_Logic getVariable 'magazineNames');
_magazineUpgrades = +(WF_Logic getVariable 'magazineUpgrades');
_magazineAllowed = +(WF_Logic getVariable 'magazineAllowed');

_template = +(WF_Logic getVariable 'templateClasses');
_templateCosts = +(WF_Logic getVariable 'templateCosts');
_templatePictures = +(WF_Logic getVariable 'templatePictures');
_templateNames = +(WF_Logic getVariable 'templateNames');	
_templateMags = +(WF_Logic getVariable 'templateMags');
_templateItems = +(WF_Logic getVariable 'templateItems');
_templateSpecs = +(WF_Logic getVariable 'templateSpecs');
_templateUpgrades = +(WF_Logic getVariable 'templateUpgrades');
_templateAllowed = +(WF_Logic getVariable 'templateAllowed');

_all = _primary + _secondary + _sidearm + _misc;
_allCosts = _primaryCosts + _secondaryCosts + _sidearmCosts + _miscCosts;
_allPictures = _primaryPictures + _secondaryPictures + _sidearmPictures + _miscPictures;
_allNames = _primaryNames + _secondaryNames + _sidearmNames + _miscNames;
_allMagazines = _primaryMagazines + _secondaryMagazines + _sidearmMagazines;
_allUpgrades = _primaryUpgrades + _secondaryUpgrades + _sidearmUpgrades + _miscUpgrades;
_allAllowed = _primaryAllowed + _secondaryAllowed + _sidearmAllowed + _miscAllowed;

WF_Logic setVariable ['lbChange',false];
WF_Logic setVariable ['lbMainAction',''];
WF_Logic setVariable ['InventoryClick',-1];
WF_Logic setVariable ['WF_GEAR_Swap',false];
WF_Logic setVariable ['WF_Gear_Action',''];

primClicked = false;
secoClicked = false;
sideClicked = false;
deleteLoadout = false;
saveLoadout = false;
buyLoadout = false;
_displayInv = false;
_updateUnit = true;
_updateFiller = false;

disableSerialization;
_lb = 3700;
_lbm = 3701;
_primaryIDC = 3500;
_secondaryIDC = 3501;
_sidearmIDC = 3502;
_specialIDC = 3535;
_display = _this select 0;

_totalWeapons = count _primary + count _secondary + count _sidearm;

_fillerIDC = [3400,3401,3402,3403,3404,3405];
_fillerTypes = ['template','all','primary','secondary','sidearm','misc'];
_inventorySlots = [];
_lastFiller = 'nil';
_id = _fillerTypes find 'primary';
_list = [];
_listPictures = [];
_listMagazines = [];
_miscItemSlots = [];
_sidearmInventorySlots = [];
(_display DisplayCtrl (_fillerIDC select _id)) ctrlSetTextColor [0.7, 1, 0.7, 1];

_currentItem = '';
_currentMags = [];
_currentData = '';
_currentValue = '';
_currentCost = 0;
_cost = 0;

_currentPrimary = '';
_currentSecondary = '';
_currentSidearm = '';
_currentPrimaryCost = 0;
_currentSecondaryCost = 0;
_currentSidearmCost = 0;
_currentSpecialCost = 0;

_old = '';

_currentWeapons = [];
_currentSpecials = [];
_currentItems = [];
_currentMagazines = [];
_slistMagazines = [];

//--- Set command is just terrific...
_replaceArray = {
	Private ['_array','_indexExcluded','_newArray'];
	_array = _this select 0;
	_indexExcluded = _this select 1;
	
	_newArray = [];
	for [{_x = 0},{_x < count(_array)},{_x = _x + 1}] do {
		if (_x != _indexExcluded) then {
			_newArray = _newArray + [_array select _x];
		};
	};
	
	_newArray
};

_fillList = {
	Private ['_currentUpgrades','_filler','_i','_listBox','_listBoxArray','_listCosts','_listNames','_listPictures','_listUpgrades','_listAllowed','_u'];
	_listCosts = _this select 0;
	_listNames = _this select 1;
	_listPictures = _this select 2;
	_listUpgrades = _this select 3;
	_listAllowed = _this select 4;
	_filler = _this select 5;
	_listBox = _this select 6;
	_listBoxArray = [];
	_u = 0;
	_i = 0;
	
	_currentUpgrades = WF_Logic getVariable Format ["%1Upgrades",sideJoinedText];
	
	{
		if ((_listUpgrades select _u) <= (_currentUpgrades select 13)) then {
			_add = true;
			if (gearRestriction && !gearInRange) then {
				if !(_listAllowed select _u) then {_add = false};
			};
			if (_add) then {
				lnbAddRow [_listBox,['$'+str (_listCosts Select _u),_x]];
				lnbSetPicture [_listBox,[_i,0],_listPictures select _u];
				lnbSetData [_listBox,[_i,0],_filler];
				lnbSetValue [_listBox,[_i,0],_u];
				_i = _i + 1;
			};
		};
		_u = _u + 1;
	} forEach _listNames;
	
	lnbSetCurSelRow [_listBox,0]
};

_addMagazine = {
	Private ['_index','_limit','_mag','_magazines','_size','_totalInventory','_totalMain','_totalSpaces'];
	_magazines = _this select 0;
	_mag = _this select 1;
	_size = 0;
	_limit = 12;
	
	_magazine = WF_Logic getVariable 'magazineClasses';
	_magazineSpaces = WF_Logic getVariable 'magazineSpaces';
	_magazineMain = WF_Logic getVariable 'magazineMain';
	
	_misc = WF_Logic getVariable 'miscClasses';
	_miscSpaces = WF_Logic getVariable 'miscSpaces';
	_miscMain = WF_Logic getVariable 'miscMain';
	
	_totalInventory = _magazine + _misc;
	_totalSpaces = _magazineSpaces + _miscSpaces;
	_totalMain = _magazineMain + _miscMain;
	
	_newMagSpace = _totalSpaces select (_totalInventory find _mag);
	_newMagSideInv = _totalMain select (_totalInventory find _mag);
	_limit = if (_newMagSideInv) then {8} else {12};

	if (_newMagSideInv) then {
		{
			_index = _totalInventory find _x;
			if (_index != -1) then {
				if (_totalMain select _index) then {
					_size = _size + (_totalSpaces select _index)
				};
			};
		} forEach _magazines;
	} else {
		{
			_index = _totalInventory find _x;
			if (_index != -1) then {
				if (!(_totalMain select _index)) then {
					_size = _size + (_totalSpaces select _index)
				};
			};
		} forEach _magazines;	
	};
	
	
	if (_size + _newMagSpace <= _limit) then {_magazines = _magazines + [_mag]};
	_magazines
};

_addItem = {
	Private ['_index','_items','_limit','_mag','_magazines','_size','_totalInventory','_totalMain','_totalSpaces'];
	_items = _this select 0;
	_mag = _this select 1;
	_size = 0;
	_limit = 12;
	
	{_size = _size + 1} forEach _items;
	
	if (_size + 1 <= _limit) then {_items = _items + [_mag]};
	
	_items
};

WF_Gear_Hotkeys = {
	Private ['_ctrl','_key'];
	_key = _this select 1;
	_ctrl = _this select 3;

	if (_key == 16 && _ctrl) then {//--- Ctrl + A
		WF_Logic setVariable ['filler','all'];
	};
	if (_key == 20 && _ctrl) then {//--- Ctrl + T
		WF_Logic setVariable ['filler','template'];
	};
	if (_key == 25 && _ctrl) then {//--- Ctrl + P
		WF_Logic setVariable ['filler','primary'];
	};
	if (_key == 31 && _ctrl) then {//--- Ctrl + S
		WF_Logic setVariable ['filler','sidearm'];
	};
	if (_key == 38 && _ctrl) then {//--- Ctrl + L
		WF_Logic setVariable ['filler','secondary'];
	};
	if (_key == 39 && _ctrl) then {//--- Ctrl + M
		WF_Logic setVariable ['filler','misc'];
	};
};
_disp = (findDisplay 16000) displayAddEventHandler ['KeyDown','_this Call WF_Gear_Hotkeys'];

//--- Fill the available units list.
_unitList = [];
_buildings = WF_Logic getVariable Format ["%1BaseStructures",sideJoinedText];
{
	_check = ['BARRACKSTYPE',_buildings,'WFBE_PURCHASEGEARRANGE' Call GetNamespace,sideJoined,_x] Call BuildingInRange;
	_inRange = _check select 1;
	if (!_inRange) then {
		_nObjects = nearestObjects [_x, WFCAMP, 20];
		_nObject = if (count _nObjects > 0) then {_nObjects select 0} else {objNull};
		if !(isNull _nObject) then {
			_sideID = _nObject getVariable "sideID";
			if !(isNil "_sideID") then {
				if (_sideID == sideID) then {_inRange = true};
			};
		};
	};
	if (_inRange) then {
		_unitList = _unitList + [_x];
		_text = toArray(str _x);
		_amount = count _text;
		_val = _text select (_amount-2);
		_val2 = _text select (_amount-1);
		_ainumber = if (_val == 58) then {[_val2]} else {[_val, _val2]};
		_txt = if (_x == leader (group _x)) then {1} else {toString(_ainumber)};
		_type = getText (configFile >> "CfgVehicles" >> typeOf _x >> "displayName");
		lbAdd [3854,Format["[%1] %2 (%3)",_txt,name _x,_type]];
	};
} forEach units(group player);
if (count _unitList > 0) then {lbSetCurSel[3854,0]};
_currentUnit = player;

while {alive player && dialog} do {
	if (Side player != sideJoined) exitWith {closeDialog 0};
	if (!dialog) exitWith {};
	
	//--- Something changed since the last time?
	_filler = WF_Logic getVariable 'filler';
	_changed = WF_Logic getVariable 'lbChange';
	_mainAction = WF_Logic getVariable 'lbMainAction';
	_inventoryClick = WF_Logic getVariable 'InventoryClick';
	_unitSwap = WF_Logic getVariable 'WF_GEAR_Swap';
	_actionSE = WF_Logic getVariable 'WF_Gear_Action';
	
	//--- Filter Changed.
	if (_filler != _lastFiller || _updateFiller) then {
		_updateFiller = false;
		_list = Call Compile Format ['_%1',_filler];
		_listCosts = Call Compile Format ['_%1Costs',_filler];
		_listNames = Call Compile Format ['_%1Names',_filler];
		_listPictures = Call Compile Format ['_%1Pictures',_filler];
		_listMagazines = Call Compile Format ['_%1Magazines',_filler];
		_listUpgrades = Call Compile Format ['_%1Upgrades',_filler];
		_listAllowed = Call Compile Format ['_%1Allowed',_filler];
		lnbClear _lb;
		[_listCosts,_listNames,_listPictures,_listUpgrades,_listAllowed,_filler,_lb] Call _fillList;
		_id = _fillerTypes find _filler;
		{(_display displayCtrl _x) ctrlSetTextColor [1, 1, 1, 1]} forEach _fillerIDC;
		(_display displayCtrl (_fillerIDC select _id)) ctrlSetTextColor [0.7, 1, 0.7, 1];
		//--- Update the list since the filler changed.
		_changed = true;
	};
	
	//--- List Selection Changed.
	if (_changed) then {
		WF_Logic setVariable ['lbChange',false];
		_currentRow = lnbCurSelRow _lb;
		_currentData = lnbData[_lb,[_currentRow,0]];
		_currentValue = lnbValue[_lb,[_currentRow,0]];
		_currentItem = _list select _currentValue;
		lnbClear _lbm;
		if (!isNil '_listMagazines') then {
			if (_currentValue < count _listMagazines) then {
				_magListCosts = [];
				_magListNames = [];
				_magListPictures = [];
				_magListUpgrades = [];
				_magListAllowed = [];
				_currentMags = _listMagazines select _currentValue;
				if (count _currentMags > 0) then {
					{
						_index = _magazine find _x;
						if (_index != -1) then {
							_magListCosts = _magListCosts + [_magazineCosts select _index];
							_magListNames = _magListNames + [_magazineNames select _index];
							_magListPictures = _magListPictures + [_magazinePictures select _index];
							_magListUpgrades = _magListUpgrades + [_magazineUpgrades select _index];
							_magListAllowed = _magListAllowed + [_magazineAllowed select _index];
						};
					} forEach _currentMags;
					[_magListCosts,_magListNames,_magListPictures,_magListUpgrades,_magazineAllowed,'magazine',_lbm] Call _fillList;
				};
			};
		};
	};
	
	//--- Player have clicked on one of the listbox.
	if (_mainAction != '') then {
		switch (_mainAction) do {
			case 'addWeapon': {
				_skip = true;
				if (_filler == 'primary' || _filler == 'secondary' || _filler == 'sidearm' || _filler == 'all') then {
					if (_currentItem in _misc) then {_skip = false;_currentValue = _currentValue - _totalWeapons};
					if (_skip) then {
						_slist = Call Compile Format ['_%1',_currentData];
						_slistPictures = Call Compile Format ['_%1Pictures',_currentData];
						_slistCosts = Call Compile Format ['_%1Costs',_currentData];
						_index = _slist find _currentItem;
						if (_index != -1) then {
							_slistMagazines = Call Compile Format ['_%1Magazines',_currentData];
							if (_filler == 'all') then {
								if (_currentItem in _primary) then {_currentData = 'primary'} else {
									if (_currentItem in _secondary) then {_currentData = 'secondary'} else {
										if (_currentItem in _sidearm) then {_currentData = 'sidearm'};
									};
								};
							};
							Call Compile Format ['_old = _current%1;_currentWeapons = _currentWeapons - [_current%1];_current%1Cost = _slistCosts select _index;_current%1 = _slist select _index;ctrlSetText[_%IDC,_slistPictures select _index];ctrlSetText[_%1IDC,_slistPictures select _index]',_currentData];
							//--- New Magazines.
							_currentMags = _slistMagazines select _index;
							//--- Old Magazines.
							_oldWeaponIndex = _slist find _old;
							if (_oldWeaponIndex > -1) then {
								_oldMags = _slistMagazines select _oldWeaponIndex;
								_currentMagazines = [_currentMags select 0,_oldMags,_currentMagazines] Call ReplaceInventoryAmmo;
							};
						};
						
						_currentWeapons = _currentWeapons + [_currentItem];
						_displayInv = true;
					};
				};
				if (_filler == 'misc' || !_skip) then {
					_type = _miscTypes select _currentValue;
					if (_type == 'CfgMagazines') then {
						_currentMagazines = [_currentMagazines,_currentItem] Call _addMagazine;
						_displayInv = true;
					};
					if (_type == 'Special' && count _currentSpecials < 3 && !(_currentItem in _currentSpecials)) then {
						_currentSpecials = _currentSpecials + [_currentItem];
						_currentSpecialCost = 0;
						_u = 0;
						{
							_index = _misc find _x;
							ctrlSetText[_specialIDC + _u,_miscPictures select _index];
							_currentSpecialCost = _currentSpecialCost + (_miscCosts select _index);
							_u = _u + 1;
						} forEach _currentSpecials;
						_displayInv = true;
					};
					if (_type == 'Item') then {
						if (!(_currentItem in _currentItems)) then {
							_currentItems = [_currentItems,_currentItem] Call _addItem;
							_displayInv = true;
						};
					};
				};
				if (_filler == 'template') then {
					_tempWeapons = _template select _currentValue;
					_tempItems = _templateItems select _currentValue;
					_tempMags = _templateMags select _currentValue;
					_tempSpecs = _templateSpecs select _currentValue;
					_currentPrimary = '';
					_currentSecondary = '';
					_currentSidearm = '';
					_currentPrimaryCost = 0;
					_currentSecondaryCost = 0;
					_currentSidearmCost = 0;
					_currentWeapons = [];
					_currentItems = _tempItems;
					{
						_index = _primary find _x;
						if (_index != -1) then {_currentWeapons = _currentWeapons + [_x];_currentPrimary = _x;_currentPrimaryCost = _primaryCosts select _index;ctrlSetText[_primaryIDC,_primaryPictures select _index]} else {
							_index = _secondary find _x;
							if (_index != -1) then {_currentWeapons = _currentWeapons + [_x];_currentSecondary = _x;_currentSecondaryCost = _secondaryCosts select _index;ctrlSetText[_secondaryIDC,_secondaryPictures select _index]} else {
								_index = _sidearm find _x;
								if (_index != -1) then {_currentWeapons = _currentWeapons + [_x];_currentSidearm = _x;_currentSidearmCost = _sidearmCosts select _index;ctrlSetText[_sidearmIDC,_sidearmPictures select _index]};
							};
						};
					} forEach _tempWeapons;
					if (_currentPrimary == '') then  {ctrlSetText [_primaryIDC,'\ca\ui\data\ui_gear_gun_gs.paa']};
					if (_currentSecondary == '') then  {ctrlSetText [_secondaryIDC,'\ca\ui\data\ui_gear_sec_gs.paa']};
					if (_currentSidearm == '') then  {ctrlSetText [_sidearmIDC,'\ca\ui\data\ui_gear_hgun_gs.paa']};
					_currentMagazines = _tempMags;
					_currentSpecials = _tempSpecs;
					_currentSpecialCost = 0;
					for [{_x = 0},{_x < 2},{_x = _x + 1}] do {ctrlSetText[_specialIDC + _x,'\Ca\UI\Data\ui_gear_eq_gs.paa']};
					_u = 0;
					{
						_index = _misc find _x;
						_currentSpecialCost = _currentSpecialCost + (_miscCosts select _index);
						ctrlSetText[_specialIDC + _u,_miscPictures select _index];
						_u = _u + 1;
					} forEach _currentSpecials;
					_displayInv = true;
				};
			};

			case 'addMagazine': {
				_currentMagValue = lnbValue[_lbm,[lnbCurSelRow _lbm,0]];
				_currentMag = _currentMags select _currentMagValue;
				_currentMagazines = [_currentMagazines,_currentMag] Call _addMagazine;
				_displayInv = true;
			};
		};
		WF_Logic setVariable ['lbMainAction',''];
	};
	
	//--- Remove a weapon by clicking on it.
	if (primClicked) then {primClicked = false;if (_currentPrimary != '') then  {ctrlSetText [_primaryIDC,'\ca\ui\data\ui_gear_gun_gs.paa'];_index = _primary find _currentPrimary;_currentPrimaryCost = 0;_currentWeapons = _currentWeapons - [_currentPrimary];_currentPrimary = '';_displayInv = true}};
	if (secoClicked) then {secoClicked = false;if (_currentSecondary != '') then  {ctrlSetText [_secondaryIDC,'\ca\ui\data\ui_gear_sec_gs.paa'];_index = _secondary find _currentSecondary;_currentSecondaryCost = 0;_currentWeapons = _currentWeapons - [_currentSecondary];_currentSecondary = '';_displayInv = true}};
	if (sideClicked) then {sideClicked = false;if (_currentSidearm != '') then  {ctrlSetText [_sidearmIDC,'\ca\ui\data\ui_gear_hgun_gs.paa'];_index = _sidearm find _currentSidearm;_currentSidearmCost = 0;_currentWeapons = _currentWeapons - [_currentSidearm];_currentSidearm = '';_displayInv = true}};

	if (_unitSwap) then {
		WF_Logic setVariable ['WF_GEAR_Swap',false];
		if (count _unitList > 0) then {_currentUnit = _unitList select (lbCurSel 3854)} else {_currentUnit = player};
		_updateUnit = true;
	};
	
	if (_updateUnit) then {
		_currentWeapons = weapons _currentUnit;
		_currentSpecials = [];
		_currentItems = [];
		_currentMagazines = magazines _currentUnit;
		_slistMagazines = [];
		
		_currentPrimary = '';
		_currentSecondary = '';
		_currentSidearm = '';

		_sideGear = _currentWeapons;
		{if (!(_x in _all)) then {_sideGear = _sideGear - [_x]}} forEach _currentWeapons;
		_currentWeapons = _sideGear;

		_sideGear = _currentMagazines;
		{if (!(_x in _misc) && !(_x in _magazine)) then {_sideGear = _sideGear - [_x]}} forEach _currentMagazines;
		_currentMagazines = _sideGear;
		
		_currentPrimaryCost = 0;
		_currentSecondaryCost = 0;
		_currentSidearmCost = 0;
		_currentSpecialCost = 0;

		ctrlSetText [_primaryIDC,'\ca\ui\data\ui_gear_gun_gs.paa'];
		ctrlSetText [_secondaryIDC,'\ca\ui\data\ui_gear_sec_gs.paa'];
		ctrlSetText [_sidearmIDC,'\ca\ui\data\ui_gear_hgun_gs.paa'];
		ctrlSetText [3535,'\Ca\UI\Data\ui_gear_eq_gs.paa'];
		ctrlSetText [3536,'\Ca\UI\Data\ui_gear_eq_gs.paa'];
		
		{
			_index = _primary find _x;
			if (_index != -1) then {_currentPrimary = _primary select _index;_currentPrimaryCost = _primaryCosts select _index;ctrlSetText[_primaryIDC,_primaryPictures select _index]};
			_index = _secondary find _x;
			if (_index != -1) then {_currentSecondary = _secondary select _index;_currentSecondaryCost = _secondaryCosts select _index;ctrlSetText[_secondaryIDC,_secondaryPictures select _index]};
			_index = _sidearm find _x;
			if (_index != -1) then {_currentSidearm = _sidearm select _index;_currentSidearmCost = _sidearmCosts select _index;ctrlSetText[_sidearmIDC,_sidearmPictures select _index]};
			_index = _misc find _x;
			if (_index != -1) then {
				switch (_miscTypes select _index) do {
					case 'Special': {
						_currentSpecials = _currentSpecials + [_x];
						_currentSpecialCost = _currentSpecialCost + (_miscCosts select _index);
						_u = 0;
						{
							_i = _misc find _x;
							ctrlSetText[_specialIDC + _u,_miscPictures select _i];
							_u = _u + 1;
						} forEach _currentSpecials;
					};
					case 'Item': {
						_currentItems = _currentItems + [_x];
					};
				};
			};
		} forEach _currentWeapons;

		_currentWeapons = _currentWeapons - _misc;
		_data = [_currentMagazines,_currentItems] Call DisplayInventory;
		_inventorySlots = _data select 0;
		_sidearmInventorySlots = _data select 1;
		_miscItemSlots = _data select 2;
		_currentCost = (_data select 3) + _currentPrimaryCost + _currentSecondaryCost + _currentSidearmCost + _currentSpecialCost;
		_cost = 0;
		_updateUnit = false;
	};
	
	//--- Remove a magazine by clicking on it.
	if (_inventoryClick != -1) then {
		//--- Main Inventory.
		if (_inventoryClick > 3502 && _inventoryClick < 3515) then {
			_slot = _inventoryClick - 3503;
			if (_slot < Count _inventorySlots) then {
				_index = _currentMagazines find (_inventorySlots Select _slot);
				if (_index != -1) then {_currentMagazines = [_currentMagazines,_index] Call _replaceArray};
			};
		};
		//--- Handgun Inventory
		if (_inventoryClick > 3514 && _inventoryClick < 3523) then {
			_slot = _inventoryClick - 3515;
			if (_slot < Count _sidearmInventorySlots) then {
				_index = _currentMagazines find (_sidearmInventorySlots Select _slot);
				if (_index != -1) then {_currentMagazines = [_currentMagazines,_index] Call _replaceArray};
			};
		};
		//--- Misc Inventory
		if (_inventoryClick > 3522 && _inventoryClick < 3535) then {
			_slot = _inventoryClick - 3523;
			if (_slot < Count _miscItemSlots) then {
				_index = _currentItems find (_miscItemSlots Select _slot);
				if (_index != -1) then {_currentItems = [_currentItems,_index] Call _replaceArray};
			};
		};
		//--- Remove a special item.
		if (_inventoryClick == 3535 || _inventoryClick == 3536) then {
			_slot = _inventoryClick - 3535;
			if (_slot < Count _currentSpecials) then {
				_currentSpecialCost = 0;
				_currentSpecials = _currentSpecials - [_currentSpecials select _slot];
				for [{_x = 0},{_x < 2},{_x = _x + 1}] do {ctrlSetText[_specialIDC + _x,'\Ca\UI\Data\ui_gear_eq_gs.paa']};
				_u = 0;
				{
					_index = _misc find _x;
					_currentSpecialCost = _currentSpecialCost + (_miscCosts select _index);
					ctrlSetText[_specialIDC + _u,_miscPictures select _index];
					_u = _u + 1;
				} forEach _currentSpecials;				
			};
		};
		WF_Logic setVariable ['InventoryClick',-1];
		_displayInv = true;
	};
	
	//--- Custom UA.
	if (_actionSE != '') then {
		switch (_actionSE) do {
			case 'reload': {
				if !(isNil 'respawnWeapons') then {
					_currentPrimary = '';
					_currentSecondary = '';
					_currentSidearm = '';
					_currentPrimaryCost = 0;
					_currentSecondaryCost = 0;
					_currentSidearmCost = 0;
					_currentWeapons = [];
					_currentItems = [];
					_currentSpecials = [];
					{
						_index = _primary find _x;
						if (_index != -1) then {_currentWeapons = _currentWeapons + [_x];_currentPrimary = _x;_currentPrimaryCost = _primaryCosts select _index;ctrlSetText[_primaryIDC,_primaryPictures select _index]} else {
							_index = _secondary find _x;
							if (_index != -1) then {_currentWeapons = _currentWeapons + [_x];_currentSecondary = _x;_currentSecondaryCost = _secondaryCosts select _index;ctrlSetText[_secondaryIDC,_secondaryPictures select _index]} else {
								_index = _sidearm find _x;
								if (_index != -1) then {_currentWeapons = _currentWeapons + [_x];_currentSidearm = _x;_currentSidearmCost = _sidearmCosts select _index;ctrlSetText[_sidearmIDC,_sidearmPictures select _index]};
							};
						};
						_index = _misc find _x;
						if (_index != -1) then {
							switch (_miscTypes select _index) do {
								case 'Special': {
									_currentSpecials = _currentSpecials + [_x];
								};
								case 'Item': {
									_currentItems = _currentItems + [_x];
								};
							};
						};
					} forEach respawnWeapons;
					if (_currentPrimary == '') then  {ctrlSetText [_primaryIDC,'\ca\ui\data\ui_gear_gun_gs.paa']};
					if (_currentSecondary == '') then  {ctrlSetText [_secondaryIDC,'\ca\ui\data\ui_gear_sec_gs.paa']};
					if (_currentSidearm == '') then  {ctrlSetText [_sidearmIDC,'\ca\ui\data\ui_gear_hgun_gs.paa']};
					_currentMagazines = respawnAmmo;
					_currentSpecialCost = 0;
					for [{_x = 0},{_x < 2},{_x = _x + 1}] do {ctrlSetText[_specialIDC + _x,'\Ca\UI\Data\ui_gear_eq_gs.paa']};
					_u = 0;
					{
						_index = _misc find _x;
						_currentSpecialCost = _currentSpecialCost + (_miscCosts select _index);
						ctrlSetText[_specialIDC + _u,_miscPictures select _index];
						_u = _u + 1;
					} forEach _currentSpecials;

					_displayInv = true;
				};
			};
			case 'clear': {
				_currentPrimary = '';
				_currentSecondary = '';
				_currentSidearm = '';
				_currentPrimaryCost = 0;
				_currentSecondaryCost = 0;
				_currentSidearmCost = 0;
				_currentSpecialCost = 0;
				_currentWeapons = [];
				_currentItems = [];
				_currentSpecials = [];
				_currentMagazines = [];
				ctrlSetText [_primaryIDC,'\ca\ui\data\ui_gear_gun_gs.paa'];
				ctrlSetText [_secondaryIDC,'\ca\ui\data\ui_gear_sec_gs.paa'];
				ctrlSetText [_sidearmIDC,'\ca\ui\data\ui_gear_hgun_gs.paa'];
				for [{_x = 0},{_x < 2},{_x = _x + 1}] do {ctrlSetText[_specialIDC + _x,'\Ca\UI\Data\ui_gear_eq_gs.paa']};
				_displayInv = true;
			};
		};
		WF_Logic setVariable ['WF_Gear_Action',''];
	};
	
	//--- Show inventory (Icons).
	if (_displayInv) then {
		_displayInv = false;
		_upgradeCost = _currentSpecialCost;
		_data = [_currentMagazines,_currentItems] Call DisplayInventory;
		_inventorySlots = _data select 0;
		_sidearmInventorySlots = _data select 1;
		_miscItemSlots = _data select 2;
		_upgradeCost = _upgradeCost + (_data select 3);
		if (_currentPrimary != '') then  {_upgradeCost = _upgradeCost + _currentPrimaryCost};
		if (_currentSecondary != '') then  {_upgradeCost = _upgradeCost + _currentSecondaryCost};
		if (_currentSidearm != '') then  {_upgradeCost = _upgradeCost + _currentSidearmCost};
		_cost = _upgradeCost - _currentCost;
	};
	
	//--- Buy a loadout.
	if (buyLoadout) then {
		buyLoadout = false;
		_funds = Call GetPlayerFunds;
		if (_funds >= _cost) then {
			(-_cost) Call ChangePlayerFunds;
			//--- Player's respawn loadout.
			if (_currentUnit == player) then {
				respawnWeapons = _currentWeapons + _currentSpecials + _currentItems;
				respawnAmmo = _currentMagazines;
			};
			[_currentUnit,(_currentWeapons + _currentSpecials + _currentItems),_currentMagazines] Call EquipLoadout;
			_data = [_currentMagazines,_currentItems] Call DisplayInventory;
			_inventorySlots = _data select 0;
			_sidearmInventorySlots = _data select 1;
			_miscItemSlots = _data select 2;
			_currentCost = (_data select 3) + _currentPrimaryCost + _currentSecondaryCost + _currentSidearmCost + _currentSpecialCost;
			_cost = 0;
		} else {
			hint parseText(Format [localize "STR_WF_Funds_Missing_Gear",_cost - _funds]);
		};
	};
	
	//--- Remove an existing template.
	if (deleteLoadout) then {
		deleteLoadout = false;
		//--- Behave only on template filler.
		if (_filler == 'template') then {
			_currentRow = lnbCurSelRow _lb;
			_currentValue = lnbValue[_lb,[_currentRow,0]];
			//--- Update the templates.
			_template set [_currentValue, "DELETE"];
			_template = _template - ["DELETE"];
			WF_Logic setVariable["templateClasses",_template];
			_templateCosts set [_currentValue, "DELETE"];
			_templateCosts = _templateCosts - ["DELETE"];
			WF_Logic setVariable["templateCosts",_templateCosts];
			_templatePictures set [_currentValue, "DELETE"];
			_templatePictures = _templatePictures - ["DELETE"];
			WF_Logic setVariable["templatePictures",_templatePictures];
			_templateNames set [_currentValue, "DELETE"];
			_templateNames = _templateNames - ["DELETE"];
			WF_Logic setVariable["templateNames",_templateNames];
			_templateMags set [_currentValue, "DELETE"];
			_templateMags = _templateMags - ["DELETE"];
			WF_Logic setVariable["templateMags",_templateMags];
			_templateItems set [_currentValue, "DELETE"];
			_templateItems = _templateItems - ["DELETE"];
			WF_Logic setVariable["templateItems",_templateItems];
			_templateSpecs set [_currentValue, "DELETE"];
			_templateSpecs = _templateSpecs - ["DELETE"];
			WF_Logic setVariable["templateSpecs",_templateSpecs];
			_templateUpgrades set [_currentValue, "DELETE"];
			_templateUpgrades = _templateUpgrades - ["DELETE"];
			WF_Logic setVariable["templateUpgrades",_templateUpgrades];
			_templateAllowed set [_currentValue, "DELETE"];
			_templateAllowed = _templateAllowed - ["DELETE"];
			WF_Logic setVariable["templateAllowed",_templateAllowed];
			_updateFiller = true;
		};
	};
	
	if (saveLoadout) then {
		saveLoadout = false;
		//--- Behave only on template filler.
		if (_filler == 'template') then {
			//--- Update the templates.
			_desc = '';
			_pict = '';
			_temp = [];
			_cAllow = true;
			_upgr = 0;
			if (_currentPrimary != '') then {
				_temp = _temp + [_currentPrimary];
				_ind = _primary find _currentPrimary;
				_desc = _desc + (_primaryNames select _ind);
				_pict = (_primaryPictures select _ind);
				if !(_primaryAllowed select _ind) then {_cAllow = false};
				_upgr = _primaryUpgrades select _ind;
			};
			if (_currentSecondary != '') then {
				_temp = _temp + [_currentSecondary];
				if (_desc != '') then { _desc = _desc + "/"};
				//--- Needless to check if the primary is prohibed.
				_ind = _secondary find _currentSecondary;
				_desc = _desc + (_secondaryNames select _ind);
				if (_pict == '') then {_pict = _secondaryPictures select _ind};
				if (_cAllow) then {if !(_secondaryAllowed select _ind) then {_cAllow = false}};
				if ((_secondaryUpgrades select _ind) > _upgr) then {_upgr = _secondaryUpgrades select _ind};
			};
			if (_currentSidearm != '') then {
				_temp = _temp + [_currentSidearm];
				if (_desc != '') then { _desc = _desc + "/"};
				//--- Needless to check if the secondary is prohibed.
				_ind = _sidearm find _currentSidearm;
				_desc = _desc + (_sidearmNames select _ind);
				if (_pict == '') then {_pict = _sidearmPictures select _ind};
				if (_cAllow) then {if !(_sidearmAllowed select _ind) then {_cAllow = false}};
				if ((_sidearmUpgrades select _ind) > _upgr) then {_upgr = _sidearmUpgrades select _ind};
			};
			_template = _template + [_temp];
			WF_Logic setVariable["templateClasses",_template];
			_templateCosts = _templateCosts + [(_cost + _currentCost)];
			WF_Logic setVariable["templateCosts",_templateCosts];
			_templatePictures = _templatePictures + [_pict];
			WF_Logic setVariable["templatePictures",_templatePictures];
			_templateNames = _templateNames + [_desc];
			WF_Logic setVariable["templateNames",_templateNames];
			_templateMags = _templateMags + [_currentMagazines];
			WF_Logic setVariable["templateMags",_templateMags];
			_templateItems = _templateItems + [_currentItems];
			WF_Logic setVariable["templateItems",_templateItems];
			_templateSpecs = _templateSpecs + [_currentSpecials];
			WF_Logic setVariable["templateSpecs",_templateSpecs];
			_templateUpgrades = _templateUpgrades + [_upgr];
			WF_Logic setVariable["templateUpgrades",_templateUpgrades];
			_templateAllowed = _templateAllowed + [_cAllow];
			WF_Logic setVariable["templateAllowed",_templateAllowed];
			_updateFiller = true;
		};
	};
	
	//--- Loadout Cost.
	ctrlSetText[3850,Format[localize 'STR_WF_Cost',_cost]];
	//--- Player's Cash.
	ctrlSetText[3851,Format["%1 $ %2.",localize 'STR_WF_CashLabel',Call GetPlayerFunds]];
	
	_lastFiller = _filler;
	sleep 0.05;
};

//--- Variables destruction.
WF_Logic setVariable ['lbChange',nil];
WF_Logic setVariable ['lbMainAction',nil];
WF_Logic setVariable ['InventoryClick',nil];
WF_Gear_Hotkeys = nil;
primClicked = nil;
secoClicked = nil;
sideClicked = nil;
buyLoadout = nil;
saveLoadout = nil;
deleteLoadout = nil;

(findDisplay 16000) displayRemoveEventHandler ['KeyDown',_disp];