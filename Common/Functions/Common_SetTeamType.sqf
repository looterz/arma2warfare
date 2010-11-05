Private['_idtype','_index','_team'];

_team = _this select 0;
_idtype = _this select 1;

if (isNil "_team") exitWith {
	format ["Common_SetTeamType Exception: _this = %1 -> _team is Nil", _this] call LogUnexpected;
};

_index = _team Call GetClientIDFromTeam;
if (_index > 0) then {
	Call Compile Format ["%1Types%2 = _idtype; publicVariable '%1Types%2';",str (side _team),_index];
} else {
	format ["Common_SetTeamType Exception: _this = %1, _team=%2 -> _index = 0", _this, _team] call LogUnexpected;
};
