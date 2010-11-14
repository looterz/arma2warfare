// _pid = "functionName" call ProfilerBegin;
// _pid call ProfilerEnd;

enabledProfiler = false;

ProfilerData = [];
ProfilerBegin = { objNull; };
ProfilerEnd = {};

initProfiler = true;
if (!enabledProfiler) exitWith {};

ProfilerBegin = {
private['_pid'];
	_pid = [_this, diag_tickTime, 0];
	_pid spawn profilerRegisterProcedureCall;
	_pid;
};

ProfilerEnd = {
private['_pid'];
	_this set [1, (diag_tickTime - (_this select 1))];
	_this set [2, 1];
};

profilerRegisterProcedureCall = {
private['_funcName', '_dT', '_data', '_u', '_bFound', '_tmp'];	
	
	_dT  = time;
	waitUntil { (_this select 2)== 1 || (time - _dT) > 15 };
	
	if ((_this select 2)== 0) then {
		format["Profiler Detect Long Executing method: %1", (_this select 0)] call LogMedium;
		_this set [1, (diag_tickTime - (_this select 1))];
	};
	
	_funcName = _this select 0;
	_dT = _this select 1;
	
	_data = objNull;
	_u = (count ProfilerData);
	_bFound = false;
	while { !(_u == 0) && !_bFound } do {
		
		_u = _u - 1;
		_tmp = ProfilerData select _u;
		if ((_tmp select 0) == _funcName) then { 
			_data = _tmp;
			_bFound = true;
		};
	};
	
	if (!_bFound) then {
		_data = [_funcName, 0, 0];
		ProfilerData = ProfilerData + [_data];
		_u = (count ProfilerData) - 1;
	};
	
	_data set [1, (_data select 1) + 1  ];
	_data set [2, (_data select 2) + _dt];
	
	//ProfilerData set [_u, _data];
};


ProfilerLogStats = {
private['_data', '_u'];

	diag_log "--------------------------------------------------";
	diag_log format["ProfilerLogStats | Total entries = %1", count ProfilerData];
	diag_log format["TimeLeft | %1", time];
	diag_log "ProfilerLogStats | Name  | Count Calls | TotalTime";
	diag_log "--------------------------------------------------";
	_u = (count ProfilerData);
	while { !(_u == 0)  } do {
		_u = _u - 1;			
		_data = ProfilerData select _u;
		diag_log format["ProfilerLogStats | %1 | %2 | %3", (_data select 0), (_data select 1), (_data select 2)];		
	};	
};


while { enabledProfiler } do {

	sleep (60);
	[] call ProfilerLogStats;
};

