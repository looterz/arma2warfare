#include "profiler.h"
PROFILER_BEGIN("Common_GetTeamMovePos");

Private['_result'];

	_result = [_this, "TeamMovePos", objNull ] call GetTeamVariable;

PROFILER_END();
_result;