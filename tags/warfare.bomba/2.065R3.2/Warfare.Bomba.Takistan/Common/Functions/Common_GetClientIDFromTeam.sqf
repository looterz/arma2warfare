#include "profiler.h"
PROFILER_BEGIN("Common_GetClientIDFromTeam");

Private ['_index', '_teams'];

	if (isNil "_this") exitWith {
		"Common_GetClientIDFromTeam Exception: _this = isNil" call LogUnexpected;
		PROFILER_END();
		-1;
	};

	_teams = Format["WFBE_%1TEAMS",str (side _this)] Call GetNamespace;
	if (isNil "_teams") exitWith {
		format["Common_GetClientIDFromTeam Exception _teams is nil: this=%1, side=%2", _this, str (side _this)] call LogUnexpected;
		PROFILER_END();
		-1;
	};

	_index = _teams find _this;
	if (isNil "_index") exitWith {
		format["Common_GetClientIDFromTeam Exception _index is nil: this=%1, side=%2, teams=%3", _this, str (side _this), _teams] call LogUnexpected;
		PROFILER_END();
		-1;
	};

	if (_index != -1) exitWith {	// Normal Return
		PROFILER_END();
		_index+1;
	};

	// Nothing not found, try search direct in WEST teams
	_teams = "WFBE_WESTTEAMS" Call GetNamespace;
	_index = _teams find _this;

	// Still Nothing not found, try search direct in EAST teams
	if (_index == -1) then {
		_teams = "WFBE_EASTTEAMS" Call GetNamespace;
		_index = _teams find _this;
	};

	if (_index == -1) exitWith {
		format ["Common_GetClientIDFromTeam Exception: _this = %1, _index=%2 _side=%3", _this, _index, side _this] call LogUnexpected;
		format ["Common_GetClientIDFromTeam Exception: WFBE_EASTTEAMS=%1", ("WFBE_EASTTEAMS" Call GetNamespace) ] call LogUnexpected;
		format ["Common_GetClientIDFromTeam Exception: WFBE_WESTTEAMS=%1", ("WFBE_WESTTEAMS" Call GetNamespace) ] call LogUnexpected;
		PROFILER_END();	
		-1;
	};

PROFILER_END();
_index+1;