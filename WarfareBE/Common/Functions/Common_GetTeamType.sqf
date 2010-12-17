Private['_index'];

_index = _this Call GetClientIDFromTeam;
if (_index == 0) exitWith {0};

Call Compile Format ["%1Types%2",str (side _this),_index]