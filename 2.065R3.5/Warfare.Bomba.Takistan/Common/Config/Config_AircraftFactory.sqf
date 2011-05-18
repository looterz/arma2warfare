Private['_c','_r','_u'];

_r = 'WFBE_RESTRICTIONADVAIR' Call GetNamespace;
_u = [];

if (paramBuyAircraftInAirportOnly) then  {
	_r = 1;
};


//WEST
if (WF_A2_Vanilla) then {
	_u = 		['MH60S'];
	if (_r == 0 || _r == 1) then {
		_u = _u		+ ['UH1Y'];
		_u = _u		+ ['AH1Z'];
		_u = _u		+ ['AH64D'];
	};
	if (_r == 0) then {
		_u = _u		+ ['MV22'];
		_u = _u		+ ['C130J'];
		_u = _u		+ ['F35B'];
		_u = _u		+ ['AV8B'];
		_u = _u		+ ['AV8B2'];
		_u = _u		+ ['A10'];
	};
};

if (WF_A2_Arrowhead) then {
	_u 			= ['MH6J_EP1'];
	_u = _u		+ ['UH60M_EP1'];
	_u = _u		+ ['UH60M_MEV_EP1'];
	_u = _u		+ ['CH_47F_EP1'];
	if (_r == 0 || _r == 1) then {
		_u = _u		+ ['AH6J_EP1'];
		_u = _u		+ ['AH64D_EP1'];
	};
	if (_r == 0) then {
		_u = _u		+ ['C130J_US_EP1'];
		_u = _u		+ ['A10_US_EP1'];
	};
	if (paramDLCBAF) then {
		_u = _u		+ ['BAF_Merlin_HC3_D'];
		_u = _u		+ ['CH_47F_BAF'];
		if (_r == 0 || _r == 1) then {
			_u = _u		+ ['AW159_Lynx_BAF'];
			_u = _u		+ ['BAF_Apache_AH1_D'];
		};
	};
};

if (WF_A2_CombinedOps) then {
	_u 			= ['MH6J_EP1'];
	_u = _u		+ ['MH60S'];
	_u = _u		+ ['UH60M_EP1'];
	_u = _u		+ ['UH60M_MEV_EP1'];
	_u = _u		+ ['CH_47F_EP1'];
	if (_r == 0 || _r == 1) then {
		_u = _u		+ ['UH1Y'];
		_u = _u		+ ['AH6J_EP1'];
		_u = _u		+ ['AH1Z'];
		_u = _u		+ ['AH64D_EP1'];
	};
	if (_r == 0) then {
		_u = _u		+ ['MV22'];
		_u = _u		+ ['C130J_US_EP1'];
		_u = _u		+ ['F35B'];
		_u = _u		+ ['AV8B'];
		_u = _u		+ ['AV8B2'];
		_u = _u		+ ['A10_US_EP1'];
	};
	if (paramDLCBAF) then {
		_u = _u		+ ['BAF_Merlin_HC3_D'];
		_u = _u		+ ['CH_47F_BAF'];
		if (_r == 0 || _r == 1) then {
			_u = _u		+ ['AW159_Lynx_BAF'];
			_u = _u		+ ['BAF_Apache_AH1_D'];
		};
	};
};

['WFBE_WESTAIRCRAFTUNITS',_u,true] Call SetNamespace;
if (local player) then {['AIRCRAFT','WEST',_u] Call Compile preProcessFile 'Client\Init\Init_Faction.sqf'};

if (paramAllies) then {
	//--- CDF Allies.
	_u			= ['Mi17_CDF'];
	_u = _u		+ ['Mi24_D'];

	['WFBE_WESTALLIESAIRCRAFTUNITS',_u,true] Call SetNamespace;
	['WFBE_WESTALLIESPILOT','CDF_Soldier_Pilot',true] Call SetNamespace;
	
	//--- Insurgent Allies.
	_u			= ['Mi17_Ins'];
	_u = _u		+ ['Su25_Ins'];

	['WFBE_EASTALLIESAIRCRAFTUNITS',_u,true] Call SetNamespace;
	['WFBE_EASTALLIESPILOT','Ins_Soldier_Pilot',true] Call SetNamespace;
} else {
	['WFBE_WESTALLIESAIRCRAFTUNITS',[],true] Call SetNamespace;
	['WFBE_EASTALLIESAIRCRAFTUNITS',[],true] Call SetNamespace;
};

//EAST

if (WF_A2_Vanilla) then {
	_u 			= ['Mi17_Ins'];
	_u = _u		+ ['Mi17_medevac_RU'];
	
	if (_r == 0 ||_r == 1) then {
		_u = _u		+ ['Mi17_rockets_RU'];
		_u = _u		+ ['Mi24_V'];
		_u = _u		+ ['Mi24_P'];
		if !(paramRestrictionKamov) then {
			_u = _u		+ ['Ka52'];
			_u = _u		+ ['Ka52Black'];
		};
	};
	if (_r == 0) then {
		_u = _u		+ ['Su34'];
		_u = _u		+ ['Su25_Ins'];
		_u = _u		+ ['Su39'];
	};
};

if (WF_A2_Arrowhead) then {
	_u 			= ['Mi17_TK_EP1'];
	_u = _u		+ ['UH1H_TK_EP1'];
	if (_r == 0 ||_r == 1) then {
		_u = _u		+ ['Mi24_D_TK_EP1'];
	};
	if (_r == 0) then {
		_u = _u		+ ['An2_TK_EP1'];
		_u = _u		+ ['L39_TK_EP1'];
		_u = _u		+ ['Su25_TK_EP1'];
	};
	
	if (paramDLCBAF) then {
		_u = _u		+ ['Ka60_PMC'];
		_u = _u		+ ['Ka60_GL_PMC'];
		_u = _u		+ ['Ka137_PMC'];
		_u = _u		+ ['Ka137_MG_PMC'];
	};	
};

if (WF_A2_CombinedOps) then {
	_u 			= ['Mi17_Ins'];
	_u = _u		+ ['UH1H_TK_EP1'];
	if (_r == 0 ||_r == 1) then {
		_u = _u		+ ['Mi17_medevac_RU'];
		_u = _u		+ ['Mi17_rockets_RU'];
		_u = _u		+ ['Mi24_V'];
		_u = _u		+ ['Mi24_D_TK_EP1'];
		_u = _u		+ ['Mi24_P'];
		if !(paramRestrictionKamov) then {
			_u = _u		+ ['Ka52'];
			_u = _u		+ ['Ka52Black'];
		};
	};
	if (_r == 0) then {
		_u = _u		+ ['An2_TK_EP1'];
		_u = _u		+ ['L39_TK_EP1'];
		_u = _u		+ ['Su34'];
		_u = _u		+ ['Su25_TK_EP1'];
		_u = _u		+ ['Su25_Ins'];
		_u = _u		+ ['Su39'];
	};
	
	if (paramDLCBAF) then {
		_u = _u		+ ['Ka60_PMC'];
		_u = _u		+ ['Ka60_GL_PMC'];
		_u = _u		+ ['Ka137_PMC'];
		_u = _u		+ ['Ka137_MG_PMC'];
	};	
};

['WFBE_EASTAIRCRAFTUNITS',_u,true] Call SetNamespace;
if (local player) then {['AIRCRAFT','EAST',_u] Call Compile preProcessFile 'Client\Init\Init_Faction.sqf'};

//RESISTANCE
_u = [];

['WFBE_GUERAIRCRAFTUNITS',_u,true] Call SetNamespace;

if (WF_A2_Vanilla) then {
	['WFBE_WESTPILOT','USMC_Soldier_Pilot',true] Call SetNamespace;
	['WFBE_EASTPILOT','RU_Soldier_Pilot',true] Call SetNamespace;
};

if (WF_A2_Arrowhead) then {
	['WFBE_WESTPILOT','US_Soldier_Pilot_EP1',true] Call SetNamespace;
	['WFBE_EASTPILOT','TK_Soldier_Pilot_EP1',true] Call SetNamespace;
};

if (WF_A2_CombinedOps) then {
	['WFBE_WESTPILOT','US_Soldier_Pilot_EP1',true] Call SetNamespace;
	['WFBE_EASTPILOT','RU_Soldier_Pilot',true] Call SetNamespace;
};

//--- UAV
if (WF_A2_Vanilla) then {
	['WFBE_WESTUAV','MQ9PredatorB',true] Call SetNamespace;
	['WFBE_EASTUAV','Pchela1T',true] Call SetNamespace;
};

if (WF_A2_Arrowhead) then {
	['WFBE_WESTUAV','MQ9PredatorB_US_EP1',true] Call SetNamespace;
	['WFBE_EASTUAV','',true] Call SetNamespace;
};

if (WF_A2_CombinedOps) then {
	['WFBE_WESTUAV','MQ9PredatorB_US_EP1',true] Call SetNamespace;
	['WFBE_EASTUAV','Pchela1T',true] Call SetNamespace;
};

_longestAircraftBuildTime = 0;
{
	_c = _x Call GetNamespace;
	if !(isNil '_c') then {
		if ((_c select QUERYUNITTIME) > _longestAircraftBuildTime) then {
			_longestAircraftBuildTime = (_c select QUERYUNITTIME);
		};
	} else {
		Format [" Config_AircraftFactory: '%1' is not defined in the Core files.",_x] call LogError;
	};
} forEach (('WFBE_EASTAIRCRAFTUNITS' Call GetNamespace) + ('WFBE_WESTAIRCRAFTUNITS' Call GetNamespace) + ('WFBE_GUERAIRCRAFTUNITS' Call GetNamespace));

['WFBE_LONGESTAIRCRAFTBUILDTIME',_longestAircraftBuildTime,true] Call SetNamespace;
"Config_AircraftFactory: Initialization - [Done]" call LogMedium;