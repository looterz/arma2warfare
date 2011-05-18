#include "profiler.h"
PROFILER_BEGIN("Common_GetCommanderTeam");

Private ["_cmdrTeam","_side"];
_side = _this;

_cmdrTeam = WF_Logic getVariable Format ["%1CommanderTeam",str _side];
if (isNil "_cmdrTeam") then {_cmdrTeam = objNull};

PROFILER_END();
_cmdrTeam;