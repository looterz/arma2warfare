// -- function Begin / Completed = LogMedium
// -- function Processing Data = LogHigh
// -- function Function Notification = LogInform
// waitUntil { !isNil "LOGLEVEL" };

LogTime = {
private['_time', '_str'];
	_time = time;
	_str = format["%1", _time];
	_time = floor((_time - floor(_time)) * 1000);
	if (_time == (floor(_time / 1000)*1000)) exitWith { _str + ".000" };
	if (_time == (floor(_time / 100)*100)) exitWith { _str + "00" };
	if (_time == (floor(_time / 10)*10)) exitWith { _str + "0" };
	
	_str;
};

LogNotify     = { if (LOGLEVEL >= 0) then { diag_log format['%2 | NOTF | %1', _this, call LogTime]; }; };
LogUnexpected = { if (LOGLEVEL >= 1) then { diag_log format['%2 | UNEX | %1', _this, call LogTime]; }; };
LogTrace 	  = { if (LOGLEVEL >= 2) then { diag_log format['%2 | TRAC | %1', _this, call LogTime]; };		 };
LogError 	  = { if (LOGLEVEL >= 3) then { diag_log format['%2 | ERRO | %1', _this, call LogTime]; }; 	 };
LogWarning    = { if (LOGLEVEL >= 4) then { diag_log format['%2 | WARN | %1', _this, call LogTime]; };	 };
LogMedium     = { if (LOGLEVEL >= 5) then { diag_log format['%2 | MED  | %1', _this, call LogTime]; };	 };
LogHigh 	  = { if (LOGLEVEL >= 6) then { diag_log format['%2 | HIGH | %1', _this, call LogTime]; };		 };
LogInform 	  = { if (LOGLEVEL >= 7) then { diag_log format['%2 | INFO | %1', _this, call LogTime]; };	 };

LOGLEVEL = 0;
#ifdef WF_LOGLEVEL
	LOGLEVEL = WF_LOGLEVEL;
#endif