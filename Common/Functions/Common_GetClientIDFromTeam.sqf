Private ['_index'];

if (isNil "_this") exitWith {
	format ["Common_GetClientIDFromTeam Exception: _this = %1", _this, _index] call LogUnexpected;
	-1;
};

_index = (Format["WFBE_%1TEAMS",str (side _this)] Call GetNamespace) find _this;

if (_index < 0) exitWith {
	format ["Common_GetClientIDFromTeam Exception: _this = %1, _index=%2", _this, _index] call LogUnexpected;
	-1;
};

_index+1