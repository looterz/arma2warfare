Private ['_index'];

_index = (Format["WFBE_%1TEAMS",str (side _this)] Call GetNamespace) find _this;
if (_index < 0) exitWith {0};

_index+1