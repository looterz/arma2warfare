private['_order', '_vehicle', '_lock'];
		
	_msgData = _this select 2;
	_player = _msgData select 0;
	_info = _msgData select 1;
	diag_log format["WARNING!"];
	diag_log format["WARNING! Cheater detected: %1(UID:%2) %3", name _player, getPlayerUID(_player), _info];

	serverCommand format["#ban %1", name _player];
	sleep 0.1;
	serverCommand format["#beserver ban %1", name _player];
	sleep 0.1;
	
	//--- _player setVehicleInit format["#ban %1", name _player];
	//--- sleep 0.1;
	//--- processInitCommands;
	//--- sleep 0.1
	//--- clearVehicleInit _player;	

