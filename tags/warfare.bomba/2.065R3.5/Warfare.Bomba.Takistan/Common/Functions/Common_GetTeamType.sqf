#include "profiler.h"
PROFILER_BEGIN("Common_GetTeamType");

Private['_result'];

	_result = [_this, "TeamType"] call GetTeamVariable;

PROFILER_END();
_result;
