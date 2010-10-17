MenuAction = -1;
_exited = false;
_timer = 3;

while {alive player && dialog} do {
	//--- Build Units.
	_enable = false;
	if (barracksInRange || lightInRange || heavyInRange || aircraftInRange || hangarInRange || depotInRange) then {_enable = true};
	ctrlEnable [11001,_enable];
	ctrlEnable [11002,gearInRange];
	
	ctrlEnable [11100, ((WF_Logic getVariable "marketInitialized") == 1)];
	
	_timer = _timer + 0.1;
	
	sleep 0.1;
	
	if (Side player != sideJoined) exitWith {closeDialog 0};
	if (!dialog || _exited) exitWith {};
	
	//--- Buy Gear.
	if (MenuAction == 1) then {
		MenuAction = -1;
		CloseDialog 0;
		CreateDialog "RscBuyUnits";
		_exited = true;	
	};
	
	//--- Gear Menu.
	if (MenuAction == 2) then {
		MenuAction = -1;
		CloseDialog 0;
		CreateDialog "RscGear";
		_exited = true;
	};	
	
	//--- Video Settings.
	if (MenuAction == 3) then {
		MenuAction = -1;
		CloseDialog 0;
		CreateDialog "RscVideo";
		_exited = true;
	};
	
	//--- Vote.
	if (MenuAction == 4) then {
		MenuAction = -1;
		_skip = false;
		_voteTime = WF_Logic getVariable Format["%1CommanderVoteTime",sideJoinedText];
		if (_voteTime <= 0) then {_skip = true};
		if (!_skip) then {
			CloseDialog 0;
			CreateDialog "RscDisplayWFVoting";
			if !(_skip) exitWith {};
		};
		WFBE_RequestCommanderVote = ['SRVFNCREQUESTCOMMANDERVOTE',sideJoined];
		publicVariable 'WFBE_RequestCommanderVote';
		if !(isMultiplayer) then {['SRVFNCREQUESTCOMMANDERVOTE',sideJoined] Spawn HandleSPVF};
		voted = true;
		waitUntil {((WF_Logic getVariable Format ["%1CommanderVoteTime",sideJoinedText])>0) || !dialog || !Alive player};
		if (!Alive player || !Dialog) exitWith {};
		CloseDialog 0;
		CreateDialog "RscDisplayWFVoting";
		_exited = true;
	};
	
	//--- Commanding Menu.
	if (MenuAction == 5) then {
		MenuAction = -1;
		CloseDialog 0;
		CreateDialog "WF_CommandMenu";
		_exited = true;
	};
	
	
	if (MenuAction == 100) then {

		MenuAction = -1;
		closeDialog 0;
		CreateDialog "RscTownMarketControl";		
		_exited = true;
	};		
};