#include "profiler.h"
PROFILER_BEGIN("Common_SetTeamMovePos");

Private['_team','_movePos'];

	_team = _this select 0;
	_movePos = _this select 1;
	[_team, "TeamMovePos", _movePos] call SetTeamVariable;

PROFILER_END();