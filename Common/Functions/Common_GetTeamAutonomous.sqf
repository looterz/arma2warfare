Private['_index'];

_index = _this Call GetClientIDFromTeam;
if (_index == 0) exitWith {false};

Call Compile Format ["%1Autonomous%2",str (side _this),_index]