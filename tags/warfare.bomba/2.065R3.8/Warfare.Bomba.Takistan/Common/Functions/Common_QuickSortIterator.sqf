#include "profiler.h"
private['_bCycle', '_bCycleA', '_a', '_l', '_r', '_M', '_i', '_j', '_v', '_vv', '_data'];

	_a = _this select 0;
	_l = _this select 1;
	_r = _this select 2;
	
	_M = 4;
	
	if ((_r - _l) <= _M) exitWith {
	};
	
	_i = floor((_r + _l) / 2);
	
	_data = [_a, _l, _i];
	
	if ( ((_a select _l) select 0) > ((_a select _i) select 0) ) then { 
		_data call QuickSortSwap; 
	};
	if ( ((_a select _l) select 0) > ((_a select _r) select 0) ) then {
		_data set [2, _r];
		_data call QuickSortSwap; 
	};
	if ( ((_a select _i) select 0) > ((_a select _r) select 0) ) then { 
		_data set [1, _i]; _data set [2, _r];
		_data call QuickSortSwap; 
	};
	
	_j = _r - 1;
	_data set [1, _i]; _data set [2, _j];
	_data call QuickSortSwap;
	
	_i = _l;
	_v = _a select _j;
	_vv = _v select 0;	
	
	_bCycleA = true;
	while { _bCycleA } do {
	
		_bCycle = true;
		while { _bCycle } do 
		{	
			_i = _i + 1;  	
			_bCycle = if ( ((_a select _i) select 0) < _vv) then { true } else { false };
		};

		_bCycle = true;
		while { _bCycle } do 
		{	
			_j = _j - 1;  	
			_bCycle = if ( ((_a select _j) select 0) > _vv) then { true } else { false };
		};
		
		if (_j < _i) then 
		{ 
			_bCycleA = false;
		} else 
		{
			_data set [1, _i]; _data set [2, _j];
			_data call QuickSortSwap;
		};
	};

	_data set [1, _i]; _data set [2, _r-1];
	_data call QuickSortSwap;
	
	_data set [1, _l]; _data set [2, _j];
	_data call QuickSortIterator;
	
	_data set [1, _i+1]; _data set [2, _r];
	_data call QuickSortIterator;
