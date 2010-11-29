#include "profiler.h"
private['_bCycle', '_bCycleA', '_a', '_l', '_r', '_M', '_i', '_j', '_v', '_vv'];

	_a = _this select 0;
	_l = _this select 1;
	_r = _this select 2;
	
	_M = 4;
	
	if ((_r - _l) <= _M) exitWith {
		PROFILER_END();
	};
	
	_i = floor((_r + _l) / 2);
	
	if ( ((_a select _l) select 0) > ((_a select _i) select 0) ) then { [_a, _l, _i] call QuickSortSwap; };
	if ( ((_a select _l) select 0) > ((_a select _r) select 0) ) then { [_a, _l, _r] call QuickSortSwap; };
	if ( ((_a select _i) select 0) > ((_a select _r) select 0) ) then { [_a, _i, _r] call QuickSortSwap; };
	
	_j = _r - 1;
	[_a, _i, _j] call QuickSortSwap;
	
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
			[_a, _i, _j] call QuickSortSwap;
		};
	};

	[_a, _i, _r-1] call QuickSortSwap;
	
	[_a, _l, _j] call QuickSortIterator;
	[_a, _i+1, _r] call QuickSortIterator;
