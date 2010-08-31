Private['_respawn','_team'];

_team = _this select 0;
_respawn = _this select 1;

if (!isNil "_team") then {_team setVariable ['respawn',_respawn,true]};