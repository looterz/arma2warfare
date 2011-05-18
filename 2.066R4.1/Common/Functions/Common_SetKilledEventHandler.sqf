"Init SetKilledEventHandler - Begin" call LogHigh;

EH_WESTUnitKilled = {
	format["EH_WESTUnitKilled %1", _this] call LogHigh;
	[_this select 0,_this select 1, west] spawn UnitKilled;
};

EH_EASTUnitKilled = {
	[_this select 0,_this select 1, east] spawn UnitKilled;
};

EH_WESTAITeamKilled = {
	format["EH_WESTAITeamKilled %1", _this] call LogHigh;
	
	(group (_this select 0)) spawn AISquadRespawn;
	[_this select 0,_this select 1, west] spawn UnitKilled;
};

EH_EASTAITeamKilled = {
	(group (_this select 0)) spawn AISquadRespawn;
	[_this select 0,_this select 1, east] spawn UnitKilled;
};

EH_RESISTANCEUnitKilled = {
	[_this select 0,_this select 1, resistance] spawn UnitKilled;
};

SetKilledEventHandler = {
	
	format["SetKilledEventHandler: %1", _this] call LogHigh;
	(_this select 0) removeAllEventHandlers "Killed";
	
	switch(_this select 1) do {
		case west:		 { (_this select 0) addEventHandler ['Killed', EH_WESTUnitKilled]; };
		case east:  	 { (_this select 0) addEventHandler ['Killed', EH_EASTUnitKilled]; };
		case resistance: { (_this select 0) addEventHandler ['Killed', EH_RESISTANCEUnitKilled]; };			
	};
};

SetAITeamKilledEventHandler = {
	
	format["SetAITeamKilledEventHandler: %1", _this] call LogHigh;
	(_this select 0) removeAllEventHandlers "Killed";
	
	switch(_this select 1) do {
		case west:		 { (_this select 0) addEventHandler ['Killed', EH_WESTAITeamKilled]; };
		case east:  	 { (_this select 0) addEventHandler ['Killed', EH_EASTAITeamKilled]; };			
	};
};

"Init SetKilledEventHandler - [Done]" call LogHigh;