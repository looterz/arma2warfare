Private['_index','_movePos','_team'];

_team = _this select 0;
_movePos = _this select 1;

_index = _team Call GetClientIDFromTeam;
if (_index == 0) exitWith {};

Call Compile Format ["%1MovePos%2 = _movePos; publicVariable '%1MovePos%2';",str (side _team),_index];