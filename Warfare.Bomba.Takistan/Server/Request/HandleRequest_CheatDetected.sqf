private['_id','_uid','_name','_player','_msgdata','_info'];
		
	_msgData = _this;
	_player = _msgData select 0;
	_info = _msgData select 1;
	_id = _player Call GetClientID;	
	_uid = getPlayerUID(_player);
	_name = name _player;
	
	diag_log format["WARNING!"];
	diag_log format["WARNING! Cheater detected: %1(UID:%2) %3", _name, _uid, _info];

	format["Trying kick cheater (%1) #kick %1", _name] call LogHigh;
	serverCommand format["#kick %1", _name];
