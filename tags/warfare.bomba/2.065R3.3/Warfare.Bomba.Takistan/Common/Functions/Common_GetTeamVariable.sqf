#include "profiler.h"
PROFILER_BEGIN("Common_GetTeamVariable");

Private['_team', '_varName', '_teamId', '_result'];
	_team = _this select 0;
	_varName = _this select 1;

	_teamId = _team Call GetClientIDFromTeam;
	_result = WF_Logic getVariable (format ["%1%2%3",str (side _team), _varName, _teamId]);	
	
PROFILER_END();
_result;