#include "profiler.h"
PROFILER_BEGIN("Common_SetTeamVariable");

Private['_team', '_varName', '_value', '_teamId'];
	_team = _this select 0;
	_varName = _this select 1;
	_value = _this select 2;

	_teamId = _team Call GetClientIDFromTeam;
	if (_teamId == 0) exitWith {};
	
	WF_Logic setVariable [ (format ["%1%2%3",str (side _team), _varName, _teamId]), _value, true];	
	
PROFILER_END();