#include "profiler.h"
PROFILER_BEGIN("Common_GetTeamMoveMode");

Private['_index', '_result'];

	_result = [_this, "TeamMoveMode"] call GetTeamVariable;

PROFILER_END();
_result;