#include "profiler.h"
PROFILER_BEGIN("Common_SetTeamAutonomous");

Private['_status','_team'];

	_team = _this select 0;
	_status = _this select 1;

	[_team, "TeamAutonomous", _status] call SetTeamVariable;

PROFILER_END();