"Init SetKilledEventHandler - Begin" call LogHigh;

EH_WESTUnitKilled = {
	[_this select 0,_this select 1, west] spawn UnitKilled;
};

EH_EASTUnitKilled = {
	[_this select 0,_this select 1, east] spawn UnitKilled;
};

EH_WESTAITeamKilled = {
	[_this select 0,_this select 1, west] spawn UnitKilled;
	(group (_this select 0)) spawn AISquadRespawn;
};

EH_EASTAITeamKilled = {
	[_this select 0,_this select 1, east] spawn UnitKilled;
	(group (_this select 0)) spawn AISquadRespawn;
};

EH_RESISTANCEUnitKilled = {
	[_this select 0,_this select 1, resistance] spawn UnitKilled;
};

SetKilledEventHandler = {
	
	(_this select 0) removeAllEventHandlers "Killed";
	
	switch(_this select 1) do {
		case west:		 { (_this select 0) addEventHandler ['Killed', EH_WESTUnitKilled]; };
		case east:  	 { (_this select 0) addEventHandler ['Killed', EH_EASTUnitKilled]; };
		case resistance: { (_this select 0) addEventHandler ['Killed', EH_RESISTANCEUnitKilled]; };			
	};
};

SetAITeamKilledEventHandler = {
	
	(_this select 0) removeAllEventHandlers "Killed";
	
	switch(_this select 1) do {
		case west:		 { (_this select 0) addEventHandler ['Killed', EH_WESTAITeamKilled]; };
		case east:  	 { (_this select 0) addEventHandler ['Killed', EH_EASTAITeamKilled]; };			
	};
};

"Init SetKilledEventHandler - [Done]" call LogHigh;