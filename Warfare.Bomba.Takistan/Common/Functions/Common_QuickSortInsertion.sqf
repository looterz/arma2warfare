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