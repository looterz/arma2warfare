private ["_blackListID","_id","_list"];
_id = getPlayerUID (_this select 0);

	fnBlackListCount = {
		private ["_count", "_i", "_cfg"];
		_count = 0;
		for [{_i = 0}, {_i < count _this}, {_i = _i + 1}] do {
			_cfg = _this select _i;
			if (gettext _cfg == "open darky menu") then {_count = _count + 1};
			if (gettext _cfg == "<t color='#0000ff'>ofpmon</t>") then {_count = _count + 1};
			if (gettext _cfg == ":)") then {_count = _count + 1};
			if (isClass _cfg) then {_count = _count + (_cfg call fnBlackListCount)};
		};
		_count;
	};
	
	_list = [];
	if (isclass (configfile / "cfgpatches" / "loki_lost_key")) then {	_list = _list + ["loki"]; }; 
	if (isclass (configfile / "cfgpatches" / "mors_anygear")) then {	_list = _list + ["mors_anygear"]; }; 
	if (isclass (configfile / "cfgpatches" / "CHN_TroopMon")) then {	_list = _list + ["CHN_TroopMon"]; }; 
	if (isclass (configFile >> "darky_menu")) then {	_list = _list + ["darky_menu"]; };

	if (((configFile / "CfgVehicles" / "Man" / "UserActions") call fnBlackListCount) != 0) then { _list = _list + ["UserActions"]; };

	if (count _list != 0) exitwith {
		_list spawn {
			private["_list"];
			_list = _this;		
			disableUserInput true;
			waitUntil { !isNil "NetSend_ToServer" };
			[30, [ player, _list ]] call NetSend_ToServer;
			sleep(10 + random(10));
			failMission "END1"; 			
		};
		false;		
	};
    
    fnBlackListCount = nil;

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