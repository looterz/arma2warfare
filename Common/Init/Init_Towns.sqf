waitUntil { initJIP };
waitUntil { !isNil "LogInited" };
waitUntil{townModeSet};

_startAt = time;
waitUntil {!isNil "totalTowns"};
waitUntil {(count towns == totalTowns) ||  time - _startAt > 30};
if (time - _startAt >= 27 && local player) then {
	_txt = Format["DEBUG: \n\n Something might be wrong with the town initialization process... \n\n This could be related to the towns amount set or to the initialization itself, try to rejoin the game if the auto-fix doesn't work... \n\n Extra Info: \n count towns: %1 \n totalTowns: %2... \n\n The game will now attempt to fix itself...",count towns,totalTowns];
	_txt Call DebugHint;
	
	/* Attempt to fix Null over JIP */
	towns = towns - [objNull];
	if (count towns == totalTowns) then {townInit = true} else {sleep 5; failMission "END1"};
} else {townInit = true};

"Init_Towns: Towns initialization - [Done]" call LogMedium;