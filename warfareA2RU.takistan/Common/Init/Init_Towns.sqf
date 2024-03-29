Private ["_startAt","_txt"];

waitUntil{townModeSet};
_startAt = time;
waitUntil {!isNil "totalTowns"};
waitUntil {(count towns == totalTowns) ||  time - _startAt > 50};
if (time - _startAt >= 47 && local player) then {
	_txt = Format["DEBUG: \n\n Something might be wrong with the town initialization process... \n\n This could be related to the towns amount set in WF_Logic ,to the initialization itself, or to some funky mods, try to rejoin the game if the auto-fix doesn't work... \n\n Extra Info: \n count towns: %1 \n totalTowns: %2... \n\n The game will now attempt to fix itself...",count towns,totalTowns];
	_txt Call DebugHint;
	
	/* Attempt to fix Null over JIP */
	towns = towns - [objNull];
	if (count towns == totalTowns) then {townInit = true;('DEBUG: \n\n The towns initialization has been fixed.') Call DebugHint;} else {('DEBUG: \n\n The towns initialization cannot be fixed.') Call DebugHint;sleep 5; failMission "END1"};
} else {townInit = true};

diag_log Format["[WFBE (INIT)][frameno:%1 | ticktime:%2] Init_Towns: Towns initialization - [Done]",diag_frameno,diag_tickTime];