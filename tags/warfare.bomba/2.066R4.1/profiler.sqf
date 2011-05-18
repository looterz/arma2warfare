// _pid = "functionName" call ProfilerBegin;
// _pid call ProfilerEnd;

enabledProfiler = false;

PROFILER_FUNC_NAMES = [];
ProfilerBegin = {objNull};
ProfilerEnd = {};

initProfiler = true;
if (!enabledProfiler) exitWith {};

ProfilerBegin = {
private['_pid'];
	_pid = [_this, time, 0];
	_pid spawn profilerRegisterProcedureCall;
	_pid;
};

ProfilerEnd = {
private['_pid'];
	_this set [1, (time - (_this select 1))];
	_this set [2, 1];
};

profilerRegisterProcedureCall = {
private['_funcName', '_dT', '_data', '_u', '_bFound', '_tmp'];	
	
	_dT  = time;
	waitUntil { (_this select 2)== 1 || (time - _dT) > 15 };
	
	if ((_this select 2)== 0) then {
		_this set [1, (time - (_this select 1))];
		format["Profiler Detect Long Executing method: %1", (_this select 0)] call LogMedium;
	};
	
	_funcName = _this select 0;
	_dT = _this select 1;
	
	call compile format["_data = PERF_FN_%1", _funcName];
	if (isNil "_data") then {
		_data = [0, 0];
		call compile format["PERF_FN_%1 = _data;", _funcName];	
		PROFILER_FUNC_NAMES = PROFILER_FUNC_NAMES + [_funcName];
	};
	
	_data set [0, (_data select 0) + 1  ];
	
	if (_dT != 0) then {
		_data set [1, (_data select 1) + _dT];
	};
	
	//PROFILER_FUNC_NAMES set [_u, _data];
};


ProfilerLogStats = {
private['_data', '_u', '_fnName', '_data'];

	diag_log "--------------------------------------------------";
	diag_log format["ProfilerLogStats | Total entries = %1", count PROFILER_FUNC_NAMES];
	diag_log format["TimeLeft | %1", time];
	diag_log "ProfilerLogStats | Name  | Count Calls | TotalTime";
	diag_log "--------------------------------------------------";
	_u = (count PROFILER_FUNC_NAMES);
	while { _u != 0 } do {
		_u = _u - 1;			
		_fnName = PROFILER_FUNC_NAMES select _u;
		call compile format["_data = PERF_FN_%1", _fnName];
		diag_log format["ProfilerLogStats | %1 | %2 | %3", _fnName, (_data select 0), (_data select 1)];		
	};	
};

while { enabledProfiler } do {

	sleep (60);
	[] call ProfilerLogStats;
};