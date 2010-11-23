while { !gameOver } do {
	
	_nearActionTime = 10000;
	_nearAction = objNull;
	{
		_nextAction = _x select 1;
		
		if (_nextAction < time) then {
		
			_serviceInfo = _x select 0;
			_serviceProc = _serviceInfo select 0;
			_servicePeriod = _serviceInfo select 1;
			[] call _serviceProc;
			
			_nextAction = time + _servicePeriod;
			_x set [1, _nextAction];
		};
		
		if (_nextAction < _nearActionTime) then {
			_nearActionTime = _nextAction;
			_nearAction = _x;
		};
	} forEach ServerServices;
	
	waitUntil { _nearActionTime < time };
};