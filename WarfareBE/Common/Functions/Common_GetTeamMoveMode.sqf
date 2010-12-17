Private['_index'];

_index = _this Call GetClientIDFromTeam;
if (_index == 0) exitWith {"towns"};

Call Compile Format ["%1MoveMode%2",str (side _this),_index]