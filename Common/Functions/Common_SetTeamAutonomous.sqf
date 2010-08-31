Private['_status','_team'];

_team = _this select 0;
_status = _this select 1;

if (!isNil "_team") then {_team setVariable ['autonomous',_status,true]};