#include "profiler.h"
private['_a','_lo','_hi','_i','_j','_v','_vv','_bCycle','_u','_u1','_item'];

	_a = _this select 0;
	_lo = _this select 1;
	_hi = _this select 2;
	
	if (_lo >= _hi) exitWith {};

	_i = _lo + 1;
	_u = _hi - _lo;
	while { _u != 0 } do {

		_u = _u - 1;
		_v = (_a select _i);
		_vv = _v select 0;
		_j = _i;
		
		_bCycle = true;
		_u1 = _j - _lo;
		
		while { _u1 != 0 } do {

			_item = _a select (_j-1);
			if ( (_item select 0) > _vv) then 
			{
				_a set [_j, _item ];
				_j = _j - 1;		
				_u1 = _u1 - 1;
			} else 
			{
				_u1 = 0;
			};
		};
		
		_a set [_j, _v];	
		_i = _i + 1;
	};