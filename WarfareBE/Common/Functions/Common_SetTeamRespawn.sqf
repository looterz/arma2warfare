Private['_index','_respawn','_team'];

_team = _this select 0;
_respawn = _this select 1;

_index = _team Call GetClientIDFromTeam;

Call Compile Format ["%1Respawn%2 = _respawn; publicVariable '%1Respawn%2';",str (side _team),_index];