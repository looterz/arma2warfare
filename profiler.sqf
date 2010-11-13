// _pid = "functionName" call ProfilerBegin;
// _pid call ProfilerEnd;

enabledProfiler = true;
initProfiler = true;

ProfilerBegin = { objNull; };
ProfilerEnd = {};

if (!enabledProfiler) exitWith {};


ProfilerData = [];

ProfilerBegin = {
private['_pid'];
	_pid = [_this, diag_tickTime];
	_pid;
};

ProfilerEnd = {
	_this set [1, (diag_tickTime - (_this select 1))];
	_this spawn profilerRegisterProcedureCall;
};

ProfilerLogStats = {
private['_data', '_u'];

	diag_log "--------------------------------------------------";
	diag_log format["ProfilerLogStats | Total entries = %1", count ProfilerData];
	diag_log format["TimeLeft: %1", time];
	diag_log "ProfilerLogStats | Name  | Count Calls | TotalTime";
	diag_log "--------------------------------------------------";
	_u = (count ProfilerData);
	while { _u != 0  } do {
		_u = _u - 1;			
		_data = ProfilerData select _u;
		diag_log format["ProfilerLogStats | %1 | %2 | %3", (_data select 0), (_data select 1), (_data select 2)];		
	};	
};

profilerRegisterProcedureCall = {
private['_funcName', '_dT', '_data', '_u', '_bFound', '_tmp'];	
	
	_funcName = _this select 0;
	_dT = _this select 1;
	
	_data = objNull;
	_u = 0;
	_bFound = false;
	while { _u < (count ProfilerData) && !_bFound } do {
		
		_tmp = ProfilerData select _u;
		if ((_tmp select 0) == _funcName) then { 
			_data = _tmp;
			_bFound = true;
		} else {
			_u = _u + 1;	
		};
	};
	
	if (!_bFound) then {
		_data = [_funcName, 0, 0];
		ProfilerData = ProfilerData + [_data];
		_u = (count ProfilerData) - 1;
	};
	
	_data set [1, (_data select 1) + 1  ];
	_data set [2, (_data select 2) + _dt];
	
	ProfilerData set [_u, _data];
};



while { enabledProfiler } do {

	sleep (30);
	[] call ProfilerLogStats;
};

