while { !gameOver } do {
	
	_nearActionTime = 10000;
	_nearAction = objNull;
	{
		_nextAction = _x select 1;
		
		if (_nextAction < time) then {
		
			_srvInfo = _x select 0;
			_hThread = _x select 2;
			_name = _x select 3;

			_srvProc = _srvInfo select 0;
			_srvPeriod = _srvInfo select 1;

			_bDone = if ( !isNil "_hThread" ) then { scriptDone _hThread } else { true };
			
			if (_bDone) then {
				_hThread = [] spawn _srvProc;
				_x set [2, _hThread];
			};

			_hThread = _x select 2;
			_bDone = if ( !isNil "_hThread" ) then { scriptDone _hThread } else { true };
			format["Service: %1, State: %2", _name, _bDone] call LogHigh;

			_x set [1, time + _srvPeriod];
		};
		
		if (_nextAction < _nearActionTime) then {
			_nearActionTime = _nextAction;
			_nearAction = _x;
		};
	} forEach ServerServices;
	
	waitUntil { _nearActionTime < time };
};