#include "profiler.h"
PROFILER_BEGIN("Common_GetTeamType");

Private['_index', '_result'];

if (isNil "_this") exitWith {
	format ["Common_GetTeamType Exception: _this = %1", _this] call LogUnexpected;
	-1;
};

_index = _this Call GetClientIDFromTeam;
if (_index == -1) exitWith {
	format ["Common_GetTeamType Exception: _this = %1, _index=%2", _this, _index] call LogUnexpected;
	-1;
};

_result = Call Compile Format ["%1Types%2",str (side _this),_index];

PROFILER_END();
_result;
