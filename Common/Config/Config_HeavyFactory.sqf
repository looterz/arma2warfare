Private['_c','_u'];

_u = [];

//WEST
if (WF_A2_Vanilla) then {
	_u 			= ['AAV'];
	_u = _u		+ ['M1A1'];
	_u = _u		+ ['MLRS'];
	_u = _u		+ ['M1A2_TUSK_MG'];
};

if (WF_A2_Arrowhead) then {
	_u 			= ['M1126_ICV_M2_EP1'];
	_u = _u		+ ['M1126_ICV_mk19_EP1'];
	_u = _u		+ ['M1129_MC_EP1'];
	_u = _u		+ ['M1135_ATGMV_EP1'];
	_u = _u		+ ['M1128_MGS_EP1'];
	_u = _u		+ ['M1133_MEV_EP1'];
	_u = _u		+ ['M2A2_EP1'];
	_u = _u		+ ['M2A3_EP1'];
	_u = _u		+ ['M1A1_US_DES_EP1'];
	_u = _u		+ ['MLRS_DES_EP1'];
	_u = _u		+ ['M1A2_US_TUSK_MG_EP1'];
	_u = _u		+ ['M6_EP1'];
	if (paramDLCBAF) then {
		_u = _u		+ ['BAF_FV510_W'];
		_u = _u		+ ['BAF_FV510_D'];
	};
};

if (WF_A2_CombinedOps) then {
	_u 			= ['AAV'];
	_u = _u		+ ['M2A2_EP1'];
	_u = _u		+ ['M2A3_EP1'];
	_u = _u		+ ['M1A1'];
	_u = _u		+ ['M1A1_US_DES_EP1'];
	_u = _u		+ ['MLRS'];
	_u = _u		+ ['MLRS_DES_EP1'];
	_u = _u		+ ['M1A2_TUSK_MG'];
	_u = _u		+ ['M1A2_US_TUSK_MG_EP1'];
	_u = _u		+ ['M6_EP1'];
	if (paramDLCBAF) then {
		_u = _u		+ ['BAF_FV510_W'];
		_u = _u		+ ['BAF_FV510_D'];
	};
};

['WFBE_WESTHEAVYUNITS',_u,true] Call SetNamespace;
if (local player) then {['HEAVY','WEST',_u] Call Compile preProcessFile 'Client\Init\Init_Faction.sqf'};

if (paramAllies) then {
	//--- CDF Allies.
	_u			= ['BMP2_Ambul_CDF'];
	_u = _u		+ ['ZSU_CDF'];
	_u = _u		+ ['BMP2_CDF'];
	_u = _u		+ ['T72_CDF'];

	['WFBE_WESTALLIESHEAVYUNITS',_u,true] Call SetNamespace;
	['WFBE_WESTALLIESCREW','CDF_Soldier_Crew',true] Call SetNamespace;
	
	//--- Insurgent Allies.
	_u			= ['BMP2_Ambul_INS'];
	_u = _u		+ ['ZSU_INS'];
	_u = _u		+ ['BMP2_INS'];
	_u = _u		+ ['T72_INS'];

	['WFBE_EASTALLIESHEAVYUNITS',_u,true] Call SetNamespace;
	['WFBE_EASTALLIESCREW','Ins_Soldier_Crew',true] Call SetNamespace;
} else {
	['WFBE_WESTALLIESHEAVYUNITS',[],true] Call SetNamespace;
	['WFBE_EASTALLIESHEAVYUNITS',[],true] Call SetNamespace;
};

_u = [];

//EAST
if (WF_A2_Vanilla) then {
	_u 			= ['BMP2_INS'];
	_u = _u		+ ['BMP3'];
	_u = _u		+ ['ZSU_INS'];
	_u = _u		+ ['T72_RU'];
	_u = _u		+ ['T90'];
	_u = _u		+ ['2S6M_Tunguska'];
};

if (WF_A2_Arrowhead) then {
	_u 			= ['M113_TK_EP1'];
	_u = _u		+ ['BMP2_TK_EP1'];
	_u = _u		+ ['ZSU_TK_EP1'];
	_u = _u		+ ['T34_TK_EP1'];
	_u = _u		+ ['T55_TK_EP1'];
	_u = _u		+ ['T72_TK_EP1'];
};

if (WF_A2_CombinedOps) then {
	_u 			= ['M113_TK_EP1'];
	_u = _u		+ ['BMP2_INS'];
	_u = _u		+ ['BMP2_TK_EP1'];
	_u = _u		+ ['BMP3'];
	_u = _u		+ ['ZSU_INS'];
	_u = _u		+ ['ZSU_TK_EP1'];
	_u = _u		+ ['T34_TK_EP1'];
	_u = _u		+ ['T55_TK_EP1'];
	_u = _u		+ ['T72_RU'];
	_u = _u		+ ['T72_TK_EP1'];
	_u = _u		+ ['T90'];
	_u = _u		+ ['2S6M_Tunguska'];
};

['WFBE_EASTHEAVYUNITS',_u,true] Call SetNamespace;
if (local player) then {['HEAVY','EAST',_u] Call Compile preProcessFile 'Client\Init\Init_Faction.sqf'};

//RESISTANCE
if (WF_A2_Vanilla || WF_A2_CombinedOps) then {
	_u 			= ['BMP2_Gue'];
	_u = _u		+ ['T72_Gue'];
};

if (WF_A2_Arrowhead || WF_A2_CombinedOps) then {
	_u 			= ['T34_TK_GUE_EP1'];
	_u = _u		+ ['T55_TK_GUE_EP1'];
};

['WFBE_GUERHEAVYUNITS',_u,true] Call SetNamespace;

if (WF_A2_Vanilla) then {
	['WFBE_WESTCREW','USMC_Soldier_Crew',true] Call SetNamespace;
	['WFBE_EASTCREW','RU_Soldier_Crew',true] Call SetNamespace;
	['WFBE_GUERCREW','GUE_Soldier_Crew',true] Call SetNamespace;
};

if (WF_A2_Arrowhead) then {
	['WFBE_WESTCREW','US_Soldier_Crew_EP1',true] Call SetNamespace;
	['WFBE_EASTCREW','TK_Soldier_Crew_EP1',true] Call SetNamespace;
	['WFBE_GUERCREW','TK_GUE_Soldier_EP1',true] Call SetNamespace;
};

if (WF_A2_CombinedOps) then {
	_resType = 'WFBE_RESISTANCEFACTION' Call GetNamespace;
	if (isNil '_resType') then {_resType = -1};
	['WFBE_WESTCREW','US_Soldier_Crew_EP1',true] Call SetNamespace;
	['WFBE_EASTCREW','TK_Soldier_Crew_EP1',true] Call SetNamespace;
	switch (_resType) do {
		case 0: {['WFBE_GUERCREW','GUE_Soldier_Crew',true] Call SetNamespace};
		case 1: {['WFBE_GUERCREW','TK_GUE_Soldier_EP1',true] Call SetNamespace};
	};
};

_longestHeavyBuildTime = 0;
{
	_c = _x Call GetNamespace;
	if !(isNil '_c') then {
		if ((_c select QUERYUNITTIME) > _longestHeavyBuildTime) then {
			_longestHeavyBuildTime = (_c select QUERYUNITTIME);
		};
	} else {
		diag_log Format ["[WFBE (ERROR)] Config_HeavyFactory: '%1' is not defined in the Core files.",_x];
	};
} forEach (('WFBE_EASTHEAVYUNITS' Call GetNamespace) + ('WFBE_WESTHEAVYUNITS' Call GetNamespace) + ('WFBE_GUERHEAVYUNITS' Call GetNamespace));

['WFBE_LONGESTHEAVYBUILDTIME',_longestHeavyBuildTime,true] Call SetNamespace;
diag_log "[WFBE (INIT)] Config_HeavyFactory: Initialization - [Done]";