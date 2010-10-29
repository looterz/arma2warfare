Private['_index'];

_index = _this Call GetClientIDFromTeam;

Call Compile Format ["%1Respawn%2",str (side _this),_index]