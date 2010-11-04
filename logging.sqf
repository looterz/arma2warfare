// -- function Begin / Completed = LogMedium
// -- function Processing Data = LogHigh
// -- function Function Notification = LogInform
// waitUntil { !isNil "LogInited" };

LogTime = {
private['_time', '_str'];
	_time = time;
	_time = floor(_time) + (floor((_time - floor(_time)) * 1000) / 1000) + 0.0001;

	_str = format["%1", _time];
	_str;
};

LOGLEVEL = 5;
#ifdef WF_LOGLEVEL
	LOGLEVEL = WF_LOGLEVEL;
#endif

#ifdef WF_DEBUG
	LOGLEVEL = 10;
#endif

LogNotify     = {};
LogUnexpected = {}; 
LogTrace 	  = {};
LogError 	  = {};
LogWarning    = {};
LogMedium     = {};
LogHigh 	  = {};
LogInform 	  = {};

if (LOGLEVEL >= 0) then { LogNotify     = { diag_log format['%2 | NOTF | %1', _this, call LogTime]; }; };
if (LOGLEVEL >= 1) then { LogUnexpected = { diag_log format['%2 | UNEX | %1', _this, call LogTime]; }; };
if (LOGLEVEL >= 2) then { LogTrace      = { diag_log format['%2 | TRAC | %1', _this, call LogTime]; }; };
if (LOGLEVEL >= 3) then { LogError      = { diag_log format['%2 | ERR  | %1', _this, call LogTime]; }; };
if (LOGLEVEL >= 4) then { LogWarning    = { diag_log format['%2 | WARN | %1', _this, call LogTime]; }; };
if (LOGLEVEL >= 5) then { LogMedium     = { diag_log format['%2 | MED  | %1', _this, call LogTime]; }; };
if (LOGLEVEL >= 6) then { LogHigh       = { diag_log format['%2 | HIGH | %1', _this, call LogTime]; }; };
if (LOGLEVEL >= 7) then { LogInform     = { diag_log format['%2 | INFO | %1', _this, call LogTime]; }; };

LogInited = true;
"Initialize Logger - End" call LogMedium;