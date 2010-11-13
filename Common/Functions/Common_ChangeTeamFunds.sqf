#include "profiler.h"
PROFILER_BEGIN("Common_ChangeTeamFunds");

Private["_amount","_funds","_slotIndex","_team"];

_team = _this select 0;
_amount = _this select 1;

_index = _team Call GetClientIDFromTeam;

if (_index > 0) then {
	Call Compile Format ["%1Funds%2 = %1Funds%2 + _amount; publicVariable '%1Funds%2';",str (side _team),_index];
};
PROFILER_END();