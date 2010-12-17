#include "profiler.h"
PROFILER_BEGIN("Common_GetTeamFunds");

Private["_funds","_index","_team", "_result"];

	_team = _this;

	_index = _team Call GetClientIDFromTeam;
	_result = if (_index != 0) then { call Compile Format ["%1Funds%2",str (side _team),_index]; } else { 0 };
	
	if (isNil "_result") then { _result = 0; };

PROFILER_END();
_result;