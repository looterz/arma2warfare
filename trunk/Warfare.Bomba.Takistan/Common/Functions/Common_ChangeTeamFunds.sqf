#include "profiler.h"
PROFILER_BEGIN("Common_ChangeTeamFunds");

Private["_amount","_funds","_teamId","_team"];

_team = _this select 0;
_amount = _this select 1;

_teamId = _team Call GetClientIDFromTeam;

if (_teamId != 0) then {
	[_amount, (side _team), _teamId] call ChangeClientFunds;
};
PROFILER_END();