private['_pos', '_defenceInfo', '_dir', '_defence', '_timeout', '_defences', '_onCaptured', '_args'];
		_pos = _this select 0;
		_type = _this select 1;
		_dir = _this select 2;
		_args = _this select 3;
		_onCaptured = _this select 4;
	
		_defence = nil;
		_timeout = time + 30;
		
		while { isNil "_defence" && _timeout >= time } do {
			sleep 0.5;
			
			_defences = _pos nearEntities [_type, 20];
			_defence = [_defences, 
			{
				_ownerId = _x getVariable "DefenceOwnerId";
				if (isNil "_ownerId") then { true } else { false };
			}] call getFirstOrDefault;
		};
		if (_timeout < time) exitWith { hint "defence not found"};
		
		_defence setPosATL _pos;
		_defence setDir _dir;
		
		[_defence, _args] call _onCaptured;
