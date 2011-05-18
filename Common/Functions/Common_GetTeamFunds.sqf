Private["_index"];

if (isNull _this) exitWith {0};

_index = _this Call GetClientIDFromTeam;
if (_index == 0) exitWith {0};

Call Compile Format ["%1Funds%2",str (side _this),_index];