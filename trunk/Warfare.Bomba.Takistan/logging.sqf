// -- function Begin / Completed = LogMedium
// -- function Processing Data = LogHigh
// -- function Function Notification = LogInform
// waitUntil { !isNil "LogInited" };

LOGLEVEL = 6;
#ifdef WF_LOGLEVEL
	LOGLEVEL = WF_LOGLEVEL;
#endif

if (WF_DEBUG) then {
	LOGLEVEL = 6;
};

LogNotify     = {};
LogUnexpected = {}; 
LogTrace 	  = {};
LogError 	  = {};
LogWarning    = {};
LogMedium     = {};
LogHigh 	  = {};
LogInform 	  = {};

if (LOGLEVEL >= 0) then { LogNotify     = { diag_log format['%2 | NOTF | %1', _this, time]; }; };
if (LOGLEVEL >= 1) then { LogUnexpected = { diag_log format['%2 | UNEX | %1', _this, time]; }; };
if (LOGLEVEL >= 3) then { LogError      = { diag_log format['%2 | ERR  | %1', _this, time]; }; };
if (LOGLEVEL >= 4) then { LogWarning    = { diag_log format['%2 | WARN | %1', _this, time]; }; };
if (LOGLEVEL >= 5) then { LogMedium     = { diag_log format['%2 | MED  | %1', _this, time]; }; };
if (LOGLEVEL >= 6) then { LogHigh       = { diag_log format['%2 | HIGH | %1', _this, time]; }; };
if (LOGLEVEL >= 7) then { LogInform     = { diag_log format['%2 | INFO | %1', _this, time]; }; };

if (WF_DEBUG) then {
	if (LOGLEVEL >= 2) then { LogTrace  = { diag_log format['%2 | TRAC | %1', _this, time]; }; };
};

"-----------------------------------------------" call LogMedium;
"" call LogMedium;
"Initialize Logger - [Done]" call LogMedium;

LogInited = true;