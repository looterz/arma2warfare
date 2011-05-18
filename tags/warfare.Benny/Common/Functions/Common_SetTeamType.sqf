Private['_idtype','_index','_team'];

_team = _this select 0;
_idtype = _this select 1;

_index = _team Call GetClientIDFromTeam;
if (_index == 0) exitWith {};

Call Compile Format ["%1Types%2 = _idtype; publicVariable '%1Types%2';",str (side _team),_index];