"Init SetKilledEventHandler - Begin" call LogHigh;

EH_WESTUnitKilled = {
	format["EH_WESTUnitKilled %1", _this] call LogHigh;
	[_this select 0,_this select 1, west] spawn UnitKilled;
};

EH_EASTUnitKilled = {
	format["EH_EASTUnitKilled %1", _this] call LogHigh;
	[_this select 0,_this select 1, east] spawn UnitKilled;
};

EH_WESTAITeamKilled = {
	format["EH_WESTAITeamKilled %1", _this] call LogHigh;
	[_this select 0] spawn AISquadRespawn;
	[_this select 0,_this select 1, west] spawn UnitKilled;
};

EH_EASTAITeamKilled = {
	format["EH_EASTAITeamKilled %1", _this] call LogHigh;
	[_this select 0] spawn AISquadRespawn;
	[_this select 0,_this select 1, east] spawn UnitKilled;
};

EH_WESTAITeamRespawn = {
	format["EH_WESTAITeamRespawn %1", _this] call LogHigh;
	//_respawnedUnit = _this select 0;
	//_corpse = _this select 1;
	if (isServer && !(isPlayer (_this select 0))) then {
		_this Spawn AISquadRespawn; 
	};
};

EH_EASTAITeamRespawn = {
	format["EH_WESTAITeamRespawn %1", _this] call LogHigh;
	//_respawnedUnit = _this select 0;
	//_corpse = _this select 1;
	if (isServer && !(isPlayer (_this select 0))) then {
		_this Spawn AISquadRespawn; 
	};
};


EH_RESISTANCEUnitKilled = {
	[_this select 0,_this select 1, resistance] spawn UnitKilled;
};

SetKilledEventHandler = {
	
	format["SetKilledEH: %1", _this] call LogHigh;
	(_this select 0) removeAllEventHandlers "Killed";
	
	switch(_this select 1) do {
		case west:		 { (_this select 0) addEventHandler ['Killed', EH_WESTUnitKilled]; };
		case east:  	 { (_this select 0) addEventHandler ['Killed', EH_EASTUnitKilled]; };
		case resistance: { (_this select 0) addEventHandler ['Killed', EH_RESISTANCEUnitKilled]; };			
	};
};



SetAITeamKilledEventHandler = {
private['_extended'];
	
	_extended = if (isMultiplayer && !WF_A2_Vanilla) then { true } else { false };
	
	if (_extended) then {
		(_this select 0) removeAllMPEventHandlers "MPRespawn";	
		format["SetAITeamMPRespawnEH: %1", _this] call LogHigh;		
		
		switch(_this select 1) do {
			case west: { (_this select 0) addMPEventHandler ['MPRespawn', { _this spawn EH_WESTAITeamRespawn}]; };
			case east: { (_this select 0) addMPEventHandler ['MPRespawn', { _this spawn EH_EASTAITeamRespawn}]; };			
		};		
		_this call SetKilledEventHandler;
	} else 
	{
		format["SetAITeamKilledEH: %1", _this] call LogHigh;
		(_this select 0) removeAllEventHandlers "Killed";
		
		switch(_this select 1) do {
			case west:	{ (_this select 0) addEventHandler ['Killed', EH_WESTAITeamKilled]; };
			case east:  { (_this select 0) addEventHandler ['Killed', EH_EASTAITeamKilled]; };			
		};
	};
};

"Init SetKilledEventHandler - [Done]" call LogHigh;