Private['_index','_status','_team'];

_team = _this select 0;
_status = _this select 1;

_index = _team Call GetClientIDFromTeam;
if (_index == 0) exitWith {};

Call Compile Format ["%1Autonomous%2 = _status; publicVariable '%1Autonomous%2';",str (side _team),_index];