Private['_index'];

_index = _this Call GetClientIDFromTeam;
if (_index == 0) exitWith {[0,0,0]};

Call Compile Format ["%1MovePos%2",str (side _this),_index]