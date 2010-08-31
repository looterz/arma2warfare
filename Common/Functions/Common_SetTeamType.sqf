Private['_index','_team'];

_team = _this select 0;
_index = _this select 1;

if (!isNil "_team") then {_team setVariable ['types',_index,true]};