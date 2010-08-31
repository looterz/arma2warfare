Private["_c","_config","_crewCost","_data","_done","_m","_p","_soldierCost","_t","_total","_u"];

_u = [];
_c = [];
_m = [];
_t = [];
_p = [];
_z = [];

//WEST
if (WF_A2_Vanilla) then {
	_u = _u		+ ["AAV"];
	_c = _c		+ [1550];
	_m = _m		+ [3];
	_t = _t		+ [25];
	_p = _p		+ [20];
	_z = _z		+ [0];
	
	_u = _u		+ ["M1A1"];
	_c = _c		+ [3650];
	_m = _m		+ [3];
	_t = _t		+ [40];
	_p = _p		+ [35];
	_z = _z		+ [1];

	_u = _u		+ ["MLRS"];
	_c = _c		+ [4800];
	_m = _m		+ [2];
	_t = _t		+ [40];
	_p = _p		+ [35];
	_z = _z		+ [3];

	_u = _u		+ ["M1A2_TUSK_MG"];
	_c = _c		+ [4950];
	_m = _m		+ [3];
	_t = _t		+ [40];
	_p = _p		+ [35];
	_z = _z		+ [2];
};

if (WF_A2_Arrowhead) then {
	_u = _u		+ ["M1126_ICV_M2_EP1"];
	_c = _c		+ [1650];
	_m = _m		+ [2];
	_t = _t		+ [25];
	_p = _p		+ [20];
	_z = _z		+ [0];

	_u = _u		+ ["M1126_ICV_mk19_EP1"];
	_c = _c		+ [1950];
	_m = _m		+ [2];
	_t = _t		+ [25];
	_p = _p		+ [20];
	_z = _z		+ [0];

	/* Since OA has no HQ model for West, we use this.
	_u = _u		+ ["M1130_CV_EP1"];
	_c = _c		+ [2100];
	_m = _m		+ [2];
	_t = _t		+ [25];
	_p = _p		+ [20];
	_z = _z		+ [1];
	*/
	
	_u = _u		+ ["M1129_MC_EP1"];
	_c = _c		+ [2300];
	_m = _m		+ [2];
	_t = _t		+ [25];
	_p = _p		+ [20];
	_z = _z		+ [1];

	_u = _u		+ ["M1135_ATGMV_EP1"];
	_c = _c		+ [2850];
	_m = _m		+ [2];
	_t = _t		+ [25];
	_p = _p		+ [20];
	_z = _z		+ [2];

	_u = _u		+ ["M1128_MGS_EP1"];
	_c = _c		+ [3150];
	_m = _m		+ [2];
	_t = _t		+ [25];
	_p = _p		+ [20];
	_z = _z		+ [2];

	_u = _u		+ ["M1133_MEV_EP1"];
	_c = _c		+ [1950];
	_m = _m		+ [2];
	_t = _t		+ [25];
	_p = _p		+ [20];
	_z = _z		+ [1];
	
	_u = _u		+ ["M2A2_EP1"];
	_c = _c		+ [3450];
	_m = _m		+ [3];
	_t = _t		+ [30];
	_p = _p		+ [20];
	_z = _z		+ [1];
	
	_u = _u		+ ["M2A3_EP1"];
	_c = _c		+ [3950];
	_m = _m		+ [3];
	_t = _t		+ [30];
	_p = _p		+ [20];
	_z = _z		+ [2];

	_u = _u		+ ["M1A1_US_DES_EP1"];
	_c = _c		+ [4650];
	_m = _m		+ [3];
	_t = _t		+ [40];
	_p = _p		+ [35];
	_z = _z		+ [2];

	_u = _u		+ ["MLRS_DES_EP1"];
	_c = _c		+ [5500];
	_m = _m		+ [2];
	_t = _t		+ [40];
	_p = _p		+ [35];
	_z = _z		+ [3];

	_u = _u		+ ["M1A2_US_TUSK_MG_EP1"];
	_c = _c		+ [5950];
	_m = _m		+ [3];
	_t = _t		+ [40];
	_p = _p		+ [35];
	_z = _z		+ [3];
	
	_u = _u		+ ["M6_EP1"];
	_c = _c		+ [7850];
	_m = _m		+ [3];
	_t = _t		+ [40];
	_p = _p		+ [35];
	_z = _z		+ [3];
};

if (WF_A2_CombinedOps) then {
	
	_u = _u		+ ["AAV"];
	_c = _c		+ [1550];
	_m = _m		+ [3];
	_t = _t		+ [25];
	_p = _p		+ [20];
	_z = _z		+ [0];

	_u = _u		+ ["M1126_ICV_M2_EP1"];
	_c = _c		+ [1650];
	_m = _m		+ [2];
	_t = _t		+ [25];
	_p = _p		+ [20];
	_z = _z		+ [0];

	_u = _u		+ ["M1126_ICV_mk19_EP1"];
	_c = _c		+ [1950];
	_m = _m		+ [2];
	_t = _t		+ [25];
	_p = _p		+ [20];
	_z = _z		+ [0];

	_u = _u		+ ["M1133_MEV_EP1"];
	_c = _c		+ [1950];
	_m = _m		+ [2];
	_t = _t		+ [25];
	_p = _p		+ [20];
	_z = _z		+ [1];

	/* Since OA has no HQ model for West, we use this.
	_u = _u		+ ["M1130_CV_EP1"];
	_c = _c		+ [2100];
	_m = _m		+ [2];
	_t = _t		+ [25];
	_p = _p		+ [20];
	_z = _z		+ [1];
	*/
	
	_u = _u		+ ["M1135_ATGMV_EP1"];
	_c = _c		+ [2850];
	_m = _m		+ [2];
	_t = _t		+ [25];
	_p = _p		+ [20];
	_z = _z		+ [2];

	_u = _u		+ ["M2A2_EP1"];
	_c = _c		+ [3000];
	_m = _m		+ [3];
	_t = _t		+ [30];
	_p = _p		+ [20];
	_z = _z		+ [1];

	_u = _u		+ ["M1128_MGS_EP1"];
	_c = _c		+ [3150];
	_m = _m		+ [2];
	_t = _t		+ [25];
	_p = _p		+ [20];
	_z = _z		+ [2];
	
	_u = _u		+ ["M2A3_EP1"];
	_c = _c		+ [3500];
	_m = _m		+ [3];
	_t = _t		+ [30];
	_p = _p		+ [20];
	_z = _z		+ [2];

	_u = _u		+ ["M6_EP1"];
	_c = if (balancing) then {_c + [6000]} else {_c + [5000]};
	_m = _m		+ [3];
	_t = _t		+ [40];
	_p = _p		+ [35];
	_z = _z		+ [3];

	_u = _u		+ ["M1A1_US_DES_EP1"];
	_c = _c		+ [5000];
	_m = _m		+ [3];
	_t = _t		+ [40];
	_p = _p		+ [35];
	_z = _z		+ [2];

	_u = _u		+ ["MLRS_DES_EP1"];
	_c = _c		+ [5500];
	_m = _m		+ [2];
	_t = _t		+ [40];
	_p = _p		+ [35];
	_z = _z		+ [3];

	_u = _u		+ ["M1A2_US_TUSK_MG_EP1"];
	_c = _c		+ [7500];
	_m = _m		+ [3];
	_t = _t		+ [40];
	_p = _p		+ [35];
	_z = _z		+ [3];
	
};

_westHeavyDescriptions = [];
_westHeavyImages = [];
_westHeavyMannedCosts = [];

_crewCost = 'WFBE_CREWCOST' Call GetNamespace;

_total = Count _u;
_done = [];
for [{_count = 0},{_count < _total},{_count = _count + 1}] do {
	if !((_u select _count) in _done) then {
		_config = configFile >> "CfgVehicles" >> (_u Select _count);
		_westHeavyMannedCosts = _westHeavyMannedCosts + [(_c Select _count) + (_m Select _count) * _crewCost];
		_westHeavyDescriptions = _westHeavyDescriptions + [GetText (_config >> "displayName")];
		_westHeavyImages = _westHeavyImages + [GetText (_config >> "picture")];
		_done = _done + [_u select _count];
	};
};

['WFBE_WESTHEAVYUNITS',_u,true] Call SetNamespace;
['WFBE_WESTHEAVYCOSTS',_c,true] Call SetNamespace;
['WFBE_WESTHEAVYCREWS',_m,true] Call SetNamespace;
['WFBE_WESTHEAVYTIMES',_t,true] Call SetNamespace;
['WFBE_WESTHEAVYPOINTS',_p,true] Call SetNamespace;
['WFBE_WESTHEAVYUPGRADES',_z,true] Call SetNamespace;
['WFBE_WESTHEAVYDESCRIPTIONS',_westHeavyDescriptions,true] Call SetNamespace;
['WFBE_WESTHEAVYIMAGES',_westHeavyImages,true] Call SetNamespace;
['WFBE_WESTHEAVYMANNEDCOSTS',_westHeavyMannedCosts,true] Call SetNamespace;

if (allies) then {
	_westAlliesHeavyDescriptions = [];
	_eastAlliesHeavyDescriptions = [];

	//--- CDF Allies.
	_u			= ["BMP2_Ambul_CDF"];
	_c			= [850];
	_t			= [20];
	_m			= [1];

	_u = _u		+ ["ZSU_CDF"];
	_c = _c		+ [1900];
	_t = _t		+ [25];
	_m = _m		+ [3];

	_u = _u		+ ["BMP2_CDF"];
	_c = _c		+ [2400];
	_t = _t		+ [30];
	_m = _m		+ [3];

	_u = _u		+ ["T72_CDF"];
	_c = _c		+ [3900];
	_t = _t		+ [35];
	_m = _m		+ [3];

	_total = count _u;
	for [{_count = 0},{_count < _total},{_count = _count + 1}] do {
		_config = configFile >> "CfgVehicles" >> (_u select _count);
		_westAlliesHeavyDescriptions = _westAlliesHeavyDescriptions + [getText (_config >> "displayName")];
	};

	['WFBE_WESTALLIESHEAVYUNITS',_u,true] Call SetNamespace;
	['WFBE_WESTALLIESHEAVYCOSTS',_c,true] Call SetNamespace;
	['WFBE_WESTALLIESHEAVYCREWS',_m,true] Call SetNamespace;
	['WFBE_WESTALLIESHEAVYTIMES',_t,true] Call SetNamespace;
	['WFBE_WESTALLIESHEAVYDESCRIPTIONS',_westAlliesHeavyDescriptions,true] Call SetNamespace;
	
	['WFBE_WESTALLIESCREW','CDF_Soldier_Crew',true] Call SetNamespace;
	
	//--- Insurgent Allies.
	_u			= ["BMP2_Ambul_INS"];
	_c			= [850];
	_t			= [20];
	_m			= [1];

	_u = _u		+ ["ZSU_INS"];
	_c = _c		+ [1900];
	_t = _t		+ [25];
	_m = _m		+ [3];

	_u = _u		+ ["BMP2_INS"];
	_c = _c		+ [2400];
	_t = _t		+ [30];
	_m = _m		+ [3];

	_u = _u		+ ["T72_INS"];
	_c = _c		+ [3900];
	_t = _t		+ [35];
	_m = _m		+ [3];

	_total = count _u;
	for [{_count = 0},{_count < _total},{_count = _count + 1}] do {
		_config = configFile >> "CfgVehicles" >> (_u select _count);
		_eastAlliesHeavyDescriptions = _eastAlliesHeavyDescriptions + [getText (_config >> "displayName")];
	};

	['WFBE_EASTALLIESHEAVYUNITS',_u,true] Call SetNamespace;
	['WFBE_EASTALLIESHEAVYCOSTS',_c,true] Call SetNamespace;
	['WFBE_EASTALLIESHEAVYCREWS',_m,true] Call SetNamespace;
	['WFBE_EASTALLIESHEAVYTIMES',_t,true] Call SetNamespace;
	['WFBE_EASTALLIESHEAVYDESCRIPTIONS',_eastAlliesHeavyDescriptions,true] Call SetNamespace;
	
	['WFBE_EASTALLIESCREW','Ins_Soldier_Crew',true] Call SetNamespace;
} else {
	['WFBE_WESTALLIESHEAVYUNITS',[],true] Call SetNamespace;
	['WFBE_WESTALLIESHEAVYCOSTS',[],true] Call SetNamespace;
	['WFBE_WESTALLIESHEAVYDESCRIPTIONS',[],true] Call SetNamespace;
	['WFBE_EASTALLIESHEAVYUNITS',[],true] Call SetNamespace;
	['WFBE_EASTALLIESHEAVYCOSTS',[],true] Call SetNamespace;
	['WFBE_EASTALLIESHEAVYDESCRIPTIONS',[],true] Call SetNamespace;
};

_u = [];
_c = [];
_m = [];
_t = [];
_p = [];
_z = [];

//EAST
if (WF_A2_Vanilla) then {
	_u = _u		+ ["BMP3"];
	_c = _c		+ [2400];
	_m = _m		+ [3];
	_t = _t		+ [35];
	_p = _p		+ [30];
	_z = _z		+ [0];
	
	_u = _u		+ ["ZSU_INS"];
	_c = _c		+ [2800];
	_m = _m		+ [3];
	_t = _t		+ [35];
	_p = _p		+ [30];
	_z = _z		+ [1];

	_u = _u		+ ["T72_RU"];
	_c = _c		+ [3750];
	_m = _m		+ [3];
	_t = _t		+ [40];
	_p = _p		+ [35];
	_z = _z		+ [1];

	_u = _u		+ ["T90"];
	_c = _c		+ [5250];
	_m = _m		+ [3];
	_t = _t		+ [40];
	_p = _p		+ [35];
	_z = _z		+ [2];

	_u = _u		+ ["2S6M_Tunguska"];
	_c = if (balancing) then {_c + [6650]} else {_c + [9650]};
	_m = _m		+ [3];
	_t = _t		+ [35];
	_p = _p		+ [30];
	_z = _z		+ [3];
};

if (WF_A2_Arrowhead) then {
	_u = _u		+ ["M113_TK_EP1"];
	_c = _c		+ [900];
	_m = _m		+ [2];
	_t = _t		+ [25];
	_p = _p		+ [30];
	_z = _z		+ [0];
	
	_u = _u		+ ["BMP2_TK_EP1"];
	_c = _c		+ [1900];
	_m = _m		+ [3];
	_t = _t		+ [25];
	_p = _p		+ [30];
	_z = _z		+ [0];
	
	_u = _u		+ ["ZSU_TK_EP1"];
	_c = _c		+ [2500];
	_m = _m		+ [3];
	_t = _t		+ [25];
	_p = _p		+ [30];
	_z = _z		+ [1];
	
	_u = _u		+ ["T34_TK_EP1"];
	_c = _c		+ [2800];
	_m = _m		+ [3];
	_t = _t		+ [25];
	_p = _p		+ [30];
	_z = _z		+ [0];
	
	_u = _u		+ ["T55_TK_EP1"];
	_c = _c		+ [3600];
	_m = _m		+ [3];
	_t = _t		+ [25];
	_p = _p		+ [30];
	_z = _z		+ [1];

	_u = _u		+ ["T72_TK_EP1"];
	_c = _c		+ [4050];
	_m = _m		+ [3];
	_t = _t		+ [30];
	_p = _p		+ [35];
	_z = _z		+ [2];
};

if (WF_A2_CombinedOps) then {
	_u = _u		+ ["M113_TK_EP1"];
	_c = _c		+ [1000];
	_m = _m		+ [2];
	_t = _t		+ [25];
	_p = _p		+ [30];
	_z = _z		+ [0];
	
	_u = _u		+ ["T34_TK_EP1"];
	_c = _c		+ [2000];
	_m = _m		+ [3];
	_t = _t		+ [25];
	_p = _p		+ [30];
	_z = _z		+ [0];

	_u = _u		+ ["BMP2_TK_EP1"];
	_c = _c		+ [2500];
	_m = _m		+ [3];
	_t = _t		+ [25];
	_p = _p		+ [30];
	_z = _z		+ [0];

	_u = _u		+ ["T55_TK_EP1"];
	_c = _c		+ [3000];
	_m = _m		+ [3];
	_t = _t		+ [25];
	_p = _p		+ [30];
	_z = _z		+ [1];

	_u = _u		+ ["BMP3"];
	_c = _c		+ [3500];
	_m = _m		+ [3];
	_t = _t		+ [35];
	_p = _p		+ [30];
	_z = _z		+ [1];

	_u = _u		+ ["T72_TK_EP1"];
	_c = _c		+ [4000];
	_m = _m		+ [3];
	_t = _t		+ [30];
	_p = _p		+ [35];
	_z = _z		+ [2];

	_u = _u		+ ["ZSU_TK_EP1"];
	_c = if (balancing) then {_c + [4000]} else {_c + [3000]};
	_m = _m		+ [3];
	_t = _t		+ [25];
	_p = _p		+ [30];
	_z = _z		+ [2];

	_u = _u		+ ["T90"];
	_c = _c		+ [5000];
	_m = _m		+ [3];
	_t = _t		+ [40];
	_p = _p		+ [35];
	_z = _z		+ [3];

	_u = _u		+ ["2S6M_Tunguska"];
	_c = _c		+ [7500];
	_m = _m		+ [3];
	_t = _t		+ [35];
	_p = _p		+ [30];
	_z = _z		+ [3];
	
};

_eastHeavyDescriptions = [];
_eastHeavyImages = [];
_eastHeavyMannedCosts = [];

_total = Count _u;
_done = [];
for [{_count = 0},{_count < _total},{_count = _count + 1}] do {
	if !((_u select _count) in _done) then {
		_config = configFile >> "CfgVehicles" >> (_u Select _count);
		_eastHeavyMannedCosts = _eastHeavyMannedCosts + [(_c Select _count) + (_m Select _count) * _crewCost];
		_eastHeavyDescriptions = _eastHeavyDescriptions + [GetText (_config >> "displayName")];
		_eastHeavyImages = _eastHeavyImages + [GetText (_config >> "picture")];
		_done = _done + [_u select _count];
	};
};

['WFBE_EASTHEAVYUNITS',_u,true] Call SetNamespace;
['WFBE_EASTHEAVYCOSTS',_c,true] Call SetNamespace;
['WFBE_EASTHEAVYCREWS',_m,true] Call SetNamespace;
['WFBE_EASTHEAVYTIMES',_t,true] Call SetNamespace;
['WFBE_EASTHEAVYPOINTS',_p,true] Call SetNamespace;
['WFBE_EASTHEAVYUPGRADES',_z,true] Call SetNamespace;
['WFBE_EASTHEAVYDESCRIPTIONS',_eastHeavyDescriptions,true] Call SetNamespace;
['WFBE_EASTHEAVYIMAGES',_eastHeavyImages,true] Call SetNamespace;
['WFBE_EASTHEAVYMANNEDCOSTS',_eastHeavyMannedCosts,true] Call SetNamespace;

_u = [];
_c = [];
_m = [];
_t = [];
_p = [];

//RESISTANCE
if (WF_A2_Vanilla || WF_A2_CombinedOps) then {
	_u = _u		+ ["BMP2_Gue"];
	_c = _c		+ [1900];
	_m = _m		+ [3];
	_t = _t		+ [25];
	_p = _p		+ [25];
	
	_u = _u		+ ["T72_Gue"];
	_c = _c		+ [3200];
	_m = _m		+ [3];
	_t = _t		+ [30];
	_p = _p		+ [25];
};

if (WF_A2_Arrowhead || WF_A2_CombinedOps) then {
	_u = _u		+ ["T34_TK_GUE_EP1"];
	_c = _c		+ [2400];
	_m = _m		+ [3];
	_t = _t		+ [30];
	_p = _p		+ [25];

	_u = _u		+ ["T55_TK_GUE_EP1"];
	_c = _c		+ [2800];
	_m = _m		+ [3];
	_t = _t		+ [30];
	_p = _p		+ [25];
};

_resistanceHeavyDescriptions = [];
_resistanceHeavyImages = [];
_resistanceHeavyMannedCosts = [];

_total = Count _u;
_done = [];
for [{_count = 0},{_count < _total},{_count = _count + 1}] do {
	if !((_u select _count) in _done) then {
		_config = configFile >> "CfgVehicles" >> (_u Select _count);
		_resistanceHeavyMannedCosts = _resistanceHeavyMannedCosts + [(_c Select _count) + (_m Select _count) * _crewCost];
		_resistanceHeavyDescriptions = _resistanceHeavyDescriptions + [GetText (_config >> "displayName")];
		_resistanceHeavyImages = _resistanceHeavyImages + [GetText (_config >> "picture")];
		_done = _done + [_u select _count];
	};
};

['WFBE_GUERHEAVYUNITS',_u,true] Call SetNamespace;
['WFBE_GUERHEAVYCOSTS',_c,true] Call SetNamespace;
['WFBE_GUERHEAVYCREWS',_m,true] Call SetNamespace;
['WFBE_GUERHEAVYTIMES',_t,true] Call SetNamespace;
['WFBE_GUERHEAVYPOINTS',_p,true] Call SetNamespace;
['WFBE_GUERHEAVYDESCRIPTIONS',_resistanceHeavyDescriptions,true] Call SetNamespace;
['WFBE_GUERHEAVYIMAGES',_resistanceHeavyImages,true] Call SetNamespace;
['WFBE_GUERHEAVYMANNEDCOSTS',_resistanceHeavyMannedCosts,true] Call SetNamespace;

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

['WFBE_HEAVYUNITS',('WFBE_WESTHEAVYUNITS' Call GetNamespace) + ('WFBE_EASTHEAVYUNITS' Call GetNamespace) + ('WFBE_GUERHEAVYUNITS' Call GetNamespace) + ('WFBE_WESTALLIESHEAVYUNITS' Call GetNamespace) + ('WFBE_EASTALLIESHEAVYUNITS' Call GetNamespace),true] Call SetNamespace;
['WFBE_HEAVYUNITCOSTS',('WFBE_WESTHEAVYCOSTS' Call GetNamespace) + ('WFBE_EASTHEAVYCOSTS' Call GetNamespace) + ('WFBE_GUERHEAVYCOSTS' Call GetNamespace) + ('WFBE_WESTALLIESHEAVYCOSTS' Call GetNamespace) + ('WFBE_EASTALLIESHEAVYCOSTS' Call GetNamespace),true] Call SetNamespace;
['WFBE_HEAVYUNITDESCRIPTIONS',('WFBE_WESTHEAVYDESCRIPTIONS' Call GetNamespace) + ('WFBE_EASTHEAVYDESCRIPTIONS' Call GetNamespace) + ('WFBE_GUERHEAVYDESCRIPTIONS' Call GetNamespace) + ('WFBE_WESTALLIESHEAVYDESCRIPTIONS' Call GetNamespace) + ('WFBE_EASTALLIESHEAVYDESCRIPTIONS' Call GetNamespace),true] Call SetNamespace;

_longestHeavyBuildTime = 0;
_t = ('WFBE_EASTHEAVYTIMES' Call GetNamespace) + ('WFBE_WESTHEAVYTIMES' Call GetNamespace) + ('WFBE_GUERHEAVYTIMES' Call GetNamespace);
for [{_count = Count _t - 1},{_count >= 0},{_count = _count - 1}] do {
	if (_t Select _count > _longestHeavyBuildTime) then {
		_longestHeavyBuildTime = _t Select _count;
	};
};

['WFBE_LONGESTHEAVYBUILDTIME',_longestHeavyBuildTime,true] Call SetNamespace;