#include "profiler.h"
PROFILER_BEGIN("Common_GetTeamRespawn");

Private['_index', '_result'];
_index = _this Call GetClientIDFromTeam;
_result = Call Compile Format ["%1Respawn%2",str (side _this),_index];

PROFILER_END();
_result;