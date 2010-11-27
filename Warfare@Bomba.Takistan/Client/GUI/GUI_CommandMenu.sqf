MenuAction = -1;
_exited = false;

while {alive player && dialog} do {
	//--- Command AI.
	
	_commandInRange = if (!WF_DEBUG) then { commandInRange; } else { true; };
	
	_enable = false;
	if (!isNull(commanderTeam)) then {if (commanderTeam == group player) then {_enable = true}};
	ctrlEnable [13001,_enable]; //--- Team Orders
	ctrlEnable [13002,_commandInRange]; //--- Special Menu
	ctrlEnable [13003,_commandInRange]; //--- Upgrade Menu
	
	sleep 0.1;
	
	if (side player != sideJoined) exitWith {closeDialog 0};
	if (!dialog || _exited) exitWith {};
	
	//--- Command AI.
	if (MenuAction == 1) then {
		MenuAction = -1;
		CloseDialog 0;
		CreateDialog "RscOrderMenu";
		_exited = true;	
	};
	
	//--- Artillery Menu.
	if (MenuAction == 2) then {
		MenuAction = -1;
		CloseDialog 0;
		CreateDialog "RscArtilleryMenu";
		_exited = true;	
	};

	//--- Upgrade Menu.
	if (MenuAction == 3) then {
		MenuAction = -1;
		CloseDialog 0;
		CreateDialog "RscUpgradeMenu";
		_exited = true;	
	};	
	
	//--- Missions Menu.
	if (MenuAction == 4) then {
		MenuAction = -1;
		CloseDialog 0;
		CreateDialog "RscMissionMenu";
		_exited = true;	
	};

	//--- Support Menu.
	if (MenuAction == 5) then {
		MenuAction = -1;
		CloseDialog 0;
		CreateDialog "RscSupportMenu";
		_exited = true;	
	};
};