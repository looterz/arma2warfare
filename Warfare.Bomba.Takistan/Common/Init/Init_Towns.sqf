private['_startat','_txt'];

waitUntil { !isNil "initJIP" };
	
	waitUntil{townModeSet};

	"Init_Towns: Towns initialization - Begin" call LogMedium;
	_startAt = time;
	waitUntil {!isNil "totalTowns"};
waitUntil {(count towns == totalTowns) ||  time - _startAt > 40};
if (time - _startAt >= 37 && local player) then {
		_txt = Format["DEBUG: \n\n Something might be wrong with the town initialization process... \n\n This could be related to the towns amount set or to the initialization itself, try to rejoin the game if the auto-fix doesn't work... \n\n Extra Info: \n count towns: %1 \n totalTowns: %2... \n\n The game will now attempt to fix itself...",count towns,totalTowns];
		_txt Call DebugHint;
		format["Init_Towns: %1", _txt] call LogUnexpected;
		
		/* Attempt to fix Null over JIP */
		towns = towns - [objNull];
	if (count towns == totalTowns) then {townInit = true;('DEBUG: \n\n The towns initialization has been fixed.') Call DebugHint;} else {('DEBUG: \n\n The towns initialization cannot be fixed.') Call DebugHint;sleep 5; failMission "END1"};
	} else {townInit = true};

	"Init_Towns: Towns initialization - [Done]" call LogMedium;