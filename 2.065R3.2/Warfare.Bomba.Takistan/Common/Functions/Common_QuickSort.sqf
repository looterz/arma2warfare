private['_count'];

fnQuickSortSwap = {
private['_a', '_i', '_j', '_tmp'];
	_a = _this select 0;
	_i = _this select 1;
	_j = _this select 2;
	
	_tmp = _a select _i;
	_a set [_i, (_a select _j)];
	_a set [_j, _tmp];
};
fnQuickSort = {
private['_bCycle', '_bCycleA', '_a', '_l', '_r', '_M', '_i', '_j', '_v', '_vv'];

	_a = _this select 0;
	_l = _this select 1;
	_r = _this select 2;
	
	_M = 4;
	
	if ((_r - _l) > _M) then {
		
		_i = floor((_r + _l) / 2);
		
		if ( ((_a select _l) select 0) > ((_a select _i) select 0) ) then { [_a, _l, _i] call fnQuickSortSwap; };
		if ( ((_a select _l) select 0) > ((_a select _r) select 0) ) then { [_a, _l, _r] call fnQuickSortSwap; };
		if ( ((_a select _i) select 0) > ((_a select _r) select 0) ) then { [_a, _i, _r] call fnQuickSortSwap; };
		
		_j = _r - 1;
		[_a, _i, _j] call fnQuickSortSwap;
		
		_i = _l;
		_v = _a select _j;
		_vv = _v select 0;	
		
		_bCycleA = true;
		while { _bCycleA } do {
		
			_bCycle = true;
			while { _bCycle } do {	
				_i = _i + 1;  	
				_bCycle = if ( ((_a select _i) select 0) < _vv) then { true } else { false };
			};

			_bCycle = true;
			while { _bCycle } do {	
				_j = _j - 1;  	
				_bCycle = if ( ((_a select _j) select 0) > _vv) then { true } else { false };
			};
			
			if (_j < _i) then 
			{ 
				_bCycleA = false;
			} else {
				[_a, _i, _j] call fnQuickSortSwap;
			};
		};

		[_a, _i, _r-1] call fnQuickSortSwap;
		
		[_a, _l, _j] call fnQuickSort;
		[_a, _i+1, _r] call fnQuickSort;
	};
};
fnInsertionSort = {
private['_a', '_lo', '_hi', '_i', '_j', '_v', '_vv', '_bCycle'];

	_a = _this select 0;
	_lo = _this select 1;
	_hi = _this select 2;
	
	_i = _lo + 1;
	while { (_i <= _hi) } do {
	
		_v = (_a select _i);
		_vv = _v select 0;
		_j = _i;
		
		_bCycle = true;
		while { (_j > _lo) && _bCycle } do {
		
			_item = _a select (_j-1);
			if ( (_item select 0) > _vv) then {
				_a set [_j, _item ];
				_j = _j - 1;		
			} else {
				_bCycle = false;
			};
		};
		
		_a set [_j, _v];	
		_i = _i + 1;
	};
};    

_count = (count _this) - 1;
if (_count > 0) then {
	[_this, 0, _count] call fnQuickSort;
	[_this, 0, _count] call fnInsertionSort;
};
	
_this;

