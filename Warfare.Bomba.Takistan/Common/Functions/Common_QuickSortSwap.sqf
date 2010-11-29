private['_a', '_i', '_j', '_tmp'];
	_a = _this select 0;
	_i = _this select 1;
	_j = _this select 2;
	
	_tmp = _a select _i;
	_a set [_i, (_a select _j)];
	_a set [_j, _tmp];