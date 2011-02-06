#include "profiler.h"
PROFILER_BEGIN("Common_GetTeamMoveMode");

private['_result'];

	_result = [_this, "TeamMoveMode", ""] call GetTeamVariable;

PROFILER_END();
_result;