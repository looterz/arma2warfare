#include "profiler.h"
PROFILER_BEGIN("Common_GetTeamFunds");

Private["_funds","_index","_team", "_result"];

if (isNil "_this") exitWith {
	format ["Common_GetTeamFunds Exception: _this = %1", _this] call LogUnexpected;
	0;
};

if (isNull _this) exitWith {
	format ["Common_GetTeamFunds Exception: _this = %1", _this] call LogUnexpected;
	0;
};

_index = _this Call GetClientIDFromTeam;

if (_index == -1) exitWith {
	format ["Common_GetTeamFunds Exception: _this = %1, _index=%2", _this, _index] call LogUnexpected;
	0;
};

_result = Call Compile Format ["%1Funds%2",str (side _this),_index];

PROFILER_END();
_result;