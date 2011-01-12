#include "profiler.h"
PROFILER_BEGIN("Common_GetTeamVariable");

Private['_team', '_varName', '_teamId', '_result'];
	_team = _this select 0;
	_varName = _this select 1;
	
	if (isNil "_team") exitWith {
		PROFILER_END();
		_this select 2;		//-- return default value
	};

	_teamId = _team Call GetClientIDFromTeam;
	if (_teamId == 0) exitWith { 
		PROFILER_END();
		_this select 2;		//-- return default value
	};
	
	_result = WF_Logic getVariable (format ["%1%2%3",str (side _team), _varName, _teamId]);
	if (isNil '_result') exitWith {
		PROFILER_END();
		_this select 2;		//-- return default value	
	};
	
PROFILER_END();
_result;