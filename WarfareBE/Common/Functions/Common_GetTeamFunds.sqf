Private["_index"];

if (isNull _this) exitWith {0};

_index = _this Call GetClientIDFromTeam;

Call Compile Format ["%1Funds%2",str (side _this),_index];