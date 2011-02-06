#include "profiler.h"
PROFILER_BEGIN("Common_SetTeamRespawn");

private['_respawn','_team'];

	_team = _this select 0;
	_respawn = _this select 1;
	[_team, "TeamRespawn", _respawn] call SetTeamVariable;
	
PROFILER_END();