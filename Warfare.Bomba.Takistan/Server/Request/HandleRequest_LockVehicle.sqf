private['_order', '_vehicle', '_lock'];
	//_clientId = _this select 0;
	//_msgId   = _this select 1;
	_order = _this;
	
	_vehicle = _order select 0;
	_lock = _order select 1;
	
	if (isNil "_vehicle") exitWith {};
	if (isNull _vehicle !alive(_vehicle) ) exitWith {};
	
	_vehicle lock _lock;
