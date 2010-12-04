#include "profiler.h"
PROFILER_BEGIN("Common_GetTeamRespawn");

Private['_result'];

	_result = [_this, "TeamRespawn"] call GetTeamVariable;	
	
PROFILER_END();
_result;