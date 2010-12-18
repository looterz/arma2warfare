#include "profiler.h"
PROFILER_BEGIN("Common_SetTeamType");

Private['_idtype', '_team'];

	_team = _this select 0;
	_idtype = _this select 1;

	[_team, "TeamType", _idtype] call SetTeamVariable;

PROFILER_END();
