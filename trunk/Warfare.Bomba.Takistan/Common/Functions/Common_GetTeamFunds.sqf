#include "profiler.h"
PROFILER_BEGIN("Common_GetTeamFunds");

Private["_funds","_index","_team", "_result"];

	_result = [_this, "Funds", 0] call GetTeamVariable;

PROFILER_END();
_result;