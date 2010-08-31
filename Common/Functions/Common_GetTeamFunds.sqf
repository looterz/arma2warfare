Private["_funds","_index","_team"];

if (isNull _this) exitWith {0};

_team = _this;

_index = (Format["WFBE_%1TEAMS",str (side _team)] Call GetNamespace) find _team;
if (_index < 0 && !isServer) exitWith {0};

_funds = _team getVariable "funds";
if (isNil "_funds") then {_funds = Format ['WFBE_%1STARTINGMONEY',str (side _team)] Call GetNamespace};

_funds