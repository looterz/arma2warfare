// -- function Begin / Completed = LogMedium
// -- function Processing Data = LogHigh
// -- function Function Notification = LogInform
// waitUntil { !isNil "LogInited" };

LOGLEVEL = 6;

LogNotify     = {};
LogUnexpected = {}; 
LogTrace 	  = {};
LogError 	  = {};
LogWarning    = {};
LogMedium     = {};
LogHigh 	  = {};
LogInform 	  = {};

if (LOGLEVEL >= 0) then { LogNotify     = { diag_log format['%2 | NOTF | %3 | %1', _this, time, diag_fps]; }; };
if (LOGLEVEL >= 1) then { LogUnexpected = { diag_log format['%2 | UNEX | %3 | %1', _this, time, diag_fps]; }; };
if (LOGLEVEL >= 3) then { LogError      = { diag_log format['%2 | ERR  | %3 | %1', _this, time, diag_fps]; }; };
if (LOGLEVEL >= 4) then { LogWarning    = { diag_log format['%2 | WARN | %3 | %1', _this, time, diag_fps]; }; };
if (LOGLEVEL >= 5) then { LogMedium     = { diag_log format['%2 | MED  | %3 | %1', _this, time, diag_fps]; }; };
if (LOGLEVEL >= 6) then { LogHigh       = { diag_log format['%2 | HIGH | %3 | %1', _this, time, diag_fps]; }; };
if (LOGLEVEL >= 7) then { LogInform     = { diag_log format['%2 | INFO | %3 | %1', _this, time, diag_fps]; }; };

if (WF_DEBUG) then {
	if (LOGLEVEL >= 2) then { LogTrace  = { diag_log format['%2 | TRAC | %3 | %1', _this, time, diag_fps]; }; };
};

"-----------------------------------------------" call LogMedium;
"" call LogMedium;
"Initialize Logger - [Done]" call LogMedium;

LogInited = true;