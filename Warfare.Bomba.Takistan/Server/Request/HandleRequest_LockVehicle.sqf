private['_order', '_vehicle', '_lock'];
	//_clientId = _this select 0;
	//_msgId   = _this select 1;
	_order = _this select 2;
	
	_vehicle = _order select 0;
	_lock = _order select 1;
	
	if ( !(isNull _vehicle) && alive(_vehicle) ) then {
	
		_vehicle lock _lock;
	};


