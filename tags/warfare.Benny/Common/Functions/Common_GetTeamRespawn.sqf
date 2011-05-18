Private['_index'];

_index = _this Call GetClientIDFromTeam;
if (_index == 0) exitWith {""};

Call Compile Format ["%1Respawn%2",str (side _this),_index]