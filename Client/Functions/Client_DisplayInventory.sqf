Private ['_cost','_index','_inventorySlots','_isMisc','_items','_loadout','_magazine','_magType','_misc','_misca','_miscItemSlots','_primary','_secondary','_sidearm','_sidearmInventorySlots','_slot','_sorted'];
_loadout = _this select 0;
_items = _this select 1;

_magazine = WF_Logic getVariable 'magazineClasses';
_magazinePictures = WF_Logic getVariable 'magazinePictures';
_magazineSpaces = WF_Logic getVariable 'magazineSpaces';
_magazineMain = WF_Logic getVariable 'magazineMain';
_magazineCosts = WF_Logic getVariable 'magazineCosts';
_magazineTypes = WF_Logic getVariable 'magazineTypes';

_misc = WF_Logic getVariable 'miscClasses';
_miscPictures = WF_Logic getVariable 'miscPictures';
_miscSpaces = WF_Logic getVariable 'miscSpaces';
_miscMain = WF_Logic getVariable 'miscMain';
_miscCosts = WF_Logic getVariable 'miscCosts';
_miscTypes = WF_Logic getVariable 'miscTypes';

_totalInventory = _magazine + _misc;
_totalTypes = _magazineTypes + _miscTypes;
_totalPictures = _magazinePictures + _miscPictures;
_totalMain = _magazineMain + _miscMain;
_totalCosts = _magazineCosts + _miscCosts;
_totalSpaces = _magazineSpaces + _miscSpaces;

_inventoryGUI = 3503;
_sidearmInvGUI = 3515;
_miscInvGUI = 3523;
_cost = 0;

for [{_count = 0},{_count < 12},{_count = _count + 1}] do {CtrlSetText[_inventoryGUI + _count,"\Ca\UI\Data\ui_gear_mag_gs.paa"]};
for [{_count = 0},{_count < 8},{_count = _count + 1}] do {CtrlSetText[_sidearmInvGUI + _count,"\Ca\UI\Data\ui_gear_mag_gs.paa"]};
for [{_count = 0},{_count < 12},{_count = _count + 1}] do {CtrlSetText[_miscInvGUI + _count,"\Ca\UI\Data\ui_gear_eq_gs.paa"]};

_slot = 0;
_inventorySlots = [];
_sidearmInventorySlots = [];
_miscItemSlots = [];

_primary = [];
_secondary = [];
_sidearm = [];
_misca = [];

{
	_index = _totalInventory find _x;
	if (_index != -1) then {
		switch (_totalTypes select _index) do {
			case 'primary': {_primary = _primary + [_x]};
			case 'secondary': {_secondary = _secondary + [_x]};
			case 'sidearm': {_sidearm = _sidearm + [_x]};
			case 'CfgMagazines': {_misca = _misca + [_x]};
			case 'CfgWeapons': {_misca = _misca + [_x]};
		};
	};
} forEach _loadout;

_sorted = _primary + _secondary + _misca;
_sidearm = _sidearm + _misca;

{
	_index = _totalInventory find _x;
	_isMisc = _misc find _x;
	_skip = false;
	if (_isMisc != -1) then {if (_miscMain select _isMisc) then {_skip = true}};
	if (!_skip) then {
		ctrlSetText[_inventoryGUI + _slot,_totalPictures select _index];
		_cost = _cost + (_totalCosts select _index);
		_slot = _slot + 1;
		_inventorySlots = _inventorySlots + [_totalInventory Select _index];
		for [{_count = (_totalSpaces Select _index) - 1},{_count > 0},{_count = _count - 1}] do {
			CtrlSetText[_inventoryGUI + _slot,""];
			_slot = _slot + 1;
			_inventorySlots = _inventorySlots + [""];
		};
	};
} forEach _sorted;

_slot = 0;
	
{
	_index = _totalInventory find _x;
	_isMisc = _misc find _x;
	_skip = false;
	if (_isMisc != -1) then {if (!(_miscMain select _isMisc)) then {_skip = true}};
	if (!_skip) then {
		ctrlSetText[_sidearmInvGUI + _slot,_totalPictures select _index];
		_cost = _cost + (_totalCosts select _index);
		_slot = _slot + 1;
		_sidearmInventorySlots = _sidearmInventorySlots + [_totalInventory Select _index];
		for [{_count = (_totalSpaces Select _index) - 1},{_count > 0},{_count = _count - 1}] do {
			CtrlSetText[_sidearmInvGUI + _slot,""];
			_slot = _slot + 1;
			_sidearmInventorySlots = _sidearmInventorySlots + [""];
		};
	};
} forEach _sidearm;

_slot = 0;

{
	_index = _misc find _x;
	CtrlSetText[_miscInvGUI + _slot,_miscPictures Select _index];
	_slot = _slot + 1;
	_miscItemSlots = _miscItemSlots + [_misc Select _index];
	_cost = _cost + (_miscCosts select _index);
	for [{_count = (_miscSpaces Select _index) - 1},{_count > 0},{_count = _count - 1}] do {
		CtrlSetText[_miscInvGUI + _slot,""];
		_slot = _slot + 1;
		_miscItemSlots = _miscItemSlots + [""];
	};
} forEach _items;
	
[_inventorySlots,_sidearmInventorySlots,_miscItemSlots,_cost]