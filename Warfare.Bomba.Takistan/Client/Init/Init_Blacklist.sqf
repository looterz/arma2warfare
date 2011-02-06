private['_blackListID','_id'];
_id = getPlayerUID (_this select 0);

	if (isClass (configFile >> "darky_menu")) exitwith {
		[] spawn {
			disableUserInput true;
			waitUntil { !isNil "NetSend_ToServer" };
			[30, [ player, "darky" ]] call NetSend_ToServer;
			sleep(10 + random(10));
			failMission "END1"; 			
		};
		false;		
	};

	//--- Griefers ID.
	_blackListID = [
	"4837314",
	"12051782",
	"7148678",
	"4139392",
"4094594",
"2992070"
	];

if (_id in _blackListID) then {true} else {false};