#include "profiler.h"
PROFILER_BEGIN("Common_GetTeamType");

Private['_result'];

	_result = [_this, "TeamType", -1] call GetTeamVariable;

PROFILER_END();
_result;
