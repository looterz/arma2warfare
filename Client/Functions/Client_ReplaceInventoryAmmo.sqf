Private ['_index','_limit','_magazines','_newMag','_newMagIsSide','_newMagSpace','_oldMags','_presentMags','_replacement','_rlIndex','_size','_spaceToReduce','_totalInventory','_totalMain','_totalSpaces'];
_newMag = _this select 0;
_oldMags = _this select 1;
_magazines = _this select 2;

_magazine = WF_Logic getVariable 'magazineClasses';
_magazineSpaces = WF_Logic getVariable 'magazineSpaces';
_magazineMain = WF_Logic getVariable 'magazineMain';

_misc = WF_Logic getVariable 'miscClasses';
_miscSpaces = WF_Logic getVariable 'miscSpaces';
_miscMain = WF_Logic getVariable 'miscMain';

_totalInventory = _magazine + _misc;
_totalSpaces = _magazineSpaces + _miscSpaces;
_totalMain = _magazineMain + _miscMain;

_presentMags = [];
_replacement = [];
_size = 0;
_spaceToReduce = 0;

_newMagSpace = _magazineSpaces select (_magazine find _newMag);
_newMagIsSide = _magazineMain select (_magazine find _newMag);
_limit = if (_newMagIsSide) then {8} else {12};

{
	_index = _oldMags find _x;
	if (_index != -1) then {
		_oldMag = _oldMags select _index;
		_presentMags = _presentMags + [_oldMag];
		_rlIndex = _magazine find _oldMag;
		_spaceToReduce = _spaceToReduce + (_magazineSpaces select _rlIndex);
	};
} forEach _magazines;

if (_newMagIsSide) then {
	{
		_index = _totalInventory find _x;
		if (_index != -1) then {
			if (_totalMain select _index) then {
				_isSideInv = _totalMain select _index;
				_size = _size + (_totalSpaces select _index);
			};
		};
	} forEach _magazines;	
} else {
	{
		_index = _totalInventory find _x;
		if (_index != -1) then {
			if (!(_totalMain select _index)) then {
				_isSideInv = _totalMain select _index;
				_size = _size + (_totalSpaces select _index);
			};
		};
	} forEach _magazines;
};

_totalToReplace = count _presentMags;
_freeSpace = _size - _spaceToReduce;

_futureSpace = _totalToReplace * _newMagSpace;
while {(_futureSpace + _freeSpace) > _limit} do {
	_totalToReplace = _totalToReplace - 1;
	_futureSpace = _totalToReplace * _newMagSpace;
};

for [{_x = 0},{_x < _totalToReplace},{_x = _x + 1}] do {_replacement = _replacement + [_newMag]};

_magazines = (_magazines - _presentMags) + _replacement;

_magazines