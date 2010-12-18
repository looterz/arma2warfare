#include "profiler.h"
PROFILER_BEGIN("Common_GetTeamAutonomous");

Private['_result', '_team'];

	_team = _this;
	_result = [_team, "TeamAutonomous"] call GetTeamVariable;

PROFILER_END();
_result;