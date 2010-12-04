#include "profiler.h"
PROFILER_BEGIN("Common_SetTeamMoveMode");

Private['_team','_moveMode'];

	_team = _this select 0;
	_moveMode = _this select 1;
	[_team, "TeamMoveMode", _moveMode] call SetTeamVariable;
	
PROFILER_END();