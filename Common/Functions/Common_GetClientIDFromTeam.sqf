#include "profiler.h"
PROFILER_BEGIN("Common_GetClientIDFromTeam");

Private ['_index', '_teams'];

if (isNil "_this") exitWith {
	"Common_GetClientIDFromTeam Exception: _this = isNil" call LogUnexpected;
	PROFILER_END();
	-1;
};

_teams = Format["WFBE_%1TEAMS",str (side _this)] Call GetNamespace;
if (isNil "_teams") exitWith {
	format["Common_GetClientIDFromTeam Exception _teams is nil: this=%1, side=%2", _this, str (side _this)] call LogUnexpected;
	PROFILER_END();
	-1;
};

_index = _teams find _this;
if (isNil "_index") exitWith {
	format["Common_GetClientIDFromTeam Exception _index is nil: this=%1, side=%2, teams=%3", _this, str (side _this), _teams] call LogUnexpected;
	PROFILER_END();
	-1;
};

if (_index < 0) exitWith {
	format ["Common_GetClientIDFromTeam Exception: _this = %1, _index=%2", _this, _index] call LogUnexpected;
	PROFILER_END();	
	-1;
};

PROFILER_END();
_index+1;