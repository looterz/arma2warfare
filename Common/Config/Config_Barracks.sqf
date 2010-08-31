Private["_c","_config","_done","_p","_t","_total","_u"];

_u = [];
_c = [];
_t = [];
_p = [];
_z = [];

//WEST
if (WF_A2_Vanilla) then {
	_u = _u		+ ["USMC_Soldier"];
	_c = _c		+ [150];
	_t = _t		+ [4];
	_p = _p		+ [5];
	_z = _z		+ [0];

	_u = _u		+ ["USMC_Soldier2"];
	_c = _c		+ [120];
	_t = _t		+ [4];
	_p = _p		+ [5];
	_z = _z		+ [0];

	_u = _u		+ ["USMC_Soldier_LAT"];
	_c = _c		+ [225];
	_t = _t		+ [5];
	_p = _p		+ [6];
	_z = _z		+ [1];

	_u = _u		+ ["USMC_Soldier_AT"];
	_c = _c		+ [350];
	_t = _t		+ [5];
	_p = _p		+ [6];
	_z = _z		+ [2];

	_u = _u		+ ["USMC_Soldier_HAT"];
	_c = _c		+ [800];
	_t = _t		+ [6];
	_p = _p		+ [7];
	_z = _z		+ [3];

	_u = _u		+ ["USMC_Soldier_AA"];
	_c = _c		+ [400];
	_t = _t		+ [6];
	_p = _p		+ [7];
	_z = _z		+ [2];

	_u = _u		+ ["USMC_Soldier_AR"];
	_c = _c		+ [210];
	_t = _t		+ [5];
	_p = _p		+ [6];
	_z = _z		+ [1];

	_u = _u		+ ["USMC_Soldier_MG"];
	_c = _c		+ [220];
	_t = _t		+ [5];
	_p = _p		+ [6];
	_z = _z		+ [0];

	_u = _u		+ ["USMC_Soldier_GL"];
	_c = _c		+ [160];
	_t = _t		+ [5];
	_p = _p		+ [6];
	_z = _z		+ [0];

	_u = _u		+ ["USMC_SoldierS_Sniper"];
	_c = _c		+ [320];
	_t = _t		+ [6];
	_p = _p		+ [7];
	_z = _z		+ [2];

	_u = _u		+ ["USMC_Soldier_Medic"];
	_c = _c		+ [190];
	_t = _t		+ [4];
	_p = _p		+ [5];
	_z = _z		+ [0];

	_u = _u		+ ["USMC_SoldierS_Engineer"];
	_c = _c		+ [225];
	_t = _t		+ [5];
	_p = _p		+ [6];
	_z = _z		+ [2];

	_u = _u		+ ["USMC_SoldierS"];
	_c = _c		+ [300];
	_t = _t		+ [7];
	_p = _p		+ [10];
	_z = _z		+ [1];

	_u = _u		+ ["USMC_SoldierS_Spotter"];
	_c = _c		+ [320];
	_t = _t		+ [6];
	_p = _p		+ [8];
	_z = _z		+ [3];

	_u = _u		+ ["FR_GL"];
	_c = _c		+ [260];
	_t = _t		+ [6];
	_p = _p		+ [8];
	_z = _z		+ [2];

	_u = _u		+ ["FR_Corpsman"];
	_c = _c		+ [270];
	_t = _t		+ [6];
	_p = _p		+ [8];
	_z = _z		+ [2];

	_u = _u		+ ["FR_Assault_R"];
	_c = _c		+ [280];
	_t = _t		+ [6];
	_p = _p		+ [8];
	_z = _z		+ [2];

	_u = _u		+ ["FR_Assault_GL"];
	_c = _c		+ [285];
	_t = _t		+ [6];
	_p = _p		+ [8];
	_z = _z		+ [2];

	_u = _u		+ ["FR_AR"];
	_c = _c		+ [290];
	_t = _t		+ [6];
	_p = _p		+ [8];
	_z = _z		+ [2];

	_u = _u		+ ["FR_R"];
	_c = _c		+ [300];
	_t = _t		+ [6];
	_p = _p		+ [8];
	_z = _z		+ [2];

	_u = _u		+ ["FR_Sapper"];
	_c = _c		+ [310];
	_t = _t		+ [6];
	_p = _p		+ [8];
	_z = _z		+ [2];

	_u = _u		+ ["FR_AC"];
	_c = _c		+ [320];
	_t = _t		+ [6];
	_p = _p		+ [8];
	_z = _z		+ [2];

	_u = _u		+ ["FR_Marksman"];
	_c = _c		+ [340];
	_t = _t		+ [6];
	_p = _p		+ [8];
	_z = _z		+ [2];

	_u = _u		+ ["USMC_Soldier_Crew"];
	_c = _c		+ [120];
	_t = _t		+ [4];
	_p = _p		+ [5];
	_z = _z		+ [0];

	_u = _u		+ ["USMC_Soldier_Pilot"];
	_c = _c		+ [120];
	_t = _t		+ [4];
	_p = _p		+ [5];
	_z = _z		+ [0];

	_u = _u		+ ["USMC_Soldier_TL"];
	_c = _c		+ [240];
	_t = _t		+ [5];
	_p = _p		+ [6];
	_z = _z		+ [1];

	_u = _u		+ ["USMC_Soldier_SL"];
	_c = _c		+ [220];
	_t = _t		+ [5];
	_p = _p		+ [7];
	_z = _z		+ [2];
};

if (WF_A2_Arrowhead || WF_A2_CombinedOps) then {
	_u = _u		+ ["US_Soldier_Light_EP1"];
	_c = _c		+ [130];
	_t = _t		+ [4];
	_p = _p		+ [5];
	_z = _z		+ [0];

	_u = _u		+ ["US_Soldier_EP1"];
	_c = _c		+ [150];
	_t = _t		+ [4];
	_p = _p		+ [5];
	_z = _z		+ [0];
	
	_u = _u		+ ["US_Soldier_B_EP1"];
	_c = _c		+ [155];
	_t = _t		+ [4];
	_p = _p		+ [5];
	_z = _z		+ [0];

	_u = _u		+ ["US_Soldier_LAT_EP1"];
	_c = _c		+ [225];
	_t = _t		+ [5];
	_p = _p		+ [6];
	_z = _z		+ [1];

	_u = _u		+ ["US_Soldier_AT_EP1"];
	_c = _c		+ [350];
	_t = _t		+ [5];
	_p = _p		+ [6];
	_z = _z		+ [2];

	_u = _u		+ ["US_Soldier_HAT_EP1"];
	_c = _c		+ [800];
	_t = _t		+ [6];
	_p = _p		+ [7];
	_z = _z		+ [3];

	_u = _u		+ ["US_Soldier_AA_EP1"];
	_c = _c		+ [400];
	_t = _t		+ [6];
	_p = _p		+ [7];
	_z = _z		+ [2];

	_u = _u		+ ["US_Soldier_AR_EP1"];
	_c = _c		+ [210];
	_t = _t		+ [5];
	_p = _p		+ [6];
	_z = _z		+ [1];

	_u = _u		+ ["US_Soldier_MG_EP1"];
	_c = _c		+ [220];
	_t = _t		+ [5];
	_p = _p		+ [6];
	_z = _z		+ [0];

	_u = _u		+ ["US_Soldier_GL_EP1"];
	_c = _c		+ [160];
	_t = _t		+ [5];
	_p = _p		+ [6];
	_z = _z		+ [0];

	_u = _u		+ ["US_Soldier_Sniper_EP1"];
	_c = _c		+ [320];
	_t = _t		+ [6];
	_p = _p		+ [7];
	_z = _z		+ [2];
	
	_u = _u		+ ["US_Soldier_SniperH_EP1"];
	_c = _c		+ [350];
	_t = _t		+ [6];
	_p = _p		+ [7];
	_z = _z		+ [3];
	
	_u = _u		+ ["US_Soldier_Sniper_NV_EP1"];
	_c = _c		+ [380];
	_t = _t		+ [6];
	_p = _p		+ [7];
	_z = _z		+ [3];
	
	_u = _u		+ ["US_Soldier_Marksman_EP1"];
	_c = _c		+ [330];
	_t = _t		+ [6];
	_p = _p		+ [7];
	_z = _z		+ [2];

	_u = _u		+ ["US_Soldier_Medic_EP1"];
	_c = _c		+ [190];
	_t = _t		+ [4];
	_p = _p		+ [5];
	_z = _z		+ [0];

	_u = _u		+ ["US_Soldier_Engineer_EP1"];
	_c = _c		+ [225];
	_t = _t		+ [5];
	_p = _p		+ [6];
	_z = _z		+ [2];

	_u = _u		+ ["US_Soldier_AMG_EP1"];
	_c = _c		+ [240];
	_t = _t		+ [6];
	_p = _p		+ [8];
	_z = _z		+ [2];

	_u = _u		+ ["US_Soldier_AAR_EP1"];
	_c = _c		+ [260];
	_t = _t		+ [6];
	_p = _p		+ [8];
	_z = _z		+ [3];

	_u = _u		+ ["US_Soldier_AHAT_EP1"];
	_c = _c		+ [900];
	_t = _t		+ [6];
	_p = _p		+ [8];
	_z = _z		+ [3];

	_u = _u		+ ["US_Soldier_AAT_EP1"];
	_c = _c		+ [450];
	_t = _t		+ [6];
	_p = _p		+ [8];
	_z = _z		+ [3];

	_u = _u		+ ["US_Soldier_Spotter_EP1"];
	_c = _c		+ [320];
	_t = _t		+ [6];
	_p = _p		+ [8];
	_z = _z		+ [3];

	_u = _u		+ ["US_Delta_Force_EP1"];
	_c = _c		+ [260];
	_t = _t		+ [6];
	_p = _p		+ [8];
	_z = _z		+ [3];

	_u = _u		+ ["US_Delta_Force_TL_EP1"];
	_c = _c		+ [270];
	_t = _t		+ [6];
	_p = _p		+ [8];
	_z = _z		+ [3];

	_u = _u		+ ["US_Delta_Force_Medic_EP1"];
	_c = _c		+ [265];
	_t = _t		+ [6];
	_p = _p		+ [8];
	_z = _z		+ [3];

	_u = _u		+ ["US_Delta_Force_Assault_EP1"];
	_c = _c		+ [285];
	_t = _t		+ [6];
	_p = _p		+ [8];
	_z = _z		+ [3];

	_u = _u		+ ["US_Delta_Force_SD_EP1"];
	_c = _c		+ [305];
	_t = _t		+ [6];
	_p = _p		+ [8];
	_z = _z		+ [3];

	_u = _u		+ ["US_Delta_Force_MG_EP1"];
	_c = _c		+ [295];
	_t = _t		+ [6];
	_p = _p		+ [8];
	_z = _z		+ [3];

	_u = _u		+ ["US_Delta_Force_AR_EP1"];
	_c = _c		+ [310];
	_t = _t		+ [6];
	_p = _p		+ [8];
	_z = _z		+ [3];

	_u = _u		+ ["US_Delta_Force_Night_EP1"];
	_c = _c		+ [305];
	_t = _t		+ [6];
	_p = _p		+ [8];
	_z = _z		+ [3];

	_u = _u		+ ["US_Delta_Force_Marksman_EP1"];
	_c = _c		+ [320];
	_t = _t		+ [6];
	_p = _p		+ [8];
	_z = _z		+ [3];

	_u = _u		+ ["US_Delta_Force_M14_EP1"];
	_c = _c		+ [290];
	_t = _t		+ [6];
	_p = _p		+ [8];
	_z = _z		+ [3];

	_u = _u		+ ["US_Delta_Force_Air_Controller_EP1"];
	_c = _c		+ [310];
	_t = _t		+ [6];
	_p = _p		+ [8];
	_z = _z		+ [3];

	_u = _u		+ ["US_Soldier_Crew_EP1"];
	_c = _c		+ [120];
	_t = _t		+ [4];
	_p = _p		+ [5];
	_z = _z		+ [0];

	_u = _u		+ ["US_Soldier_Pilot_EP1"];
	_c = _c		+ [120];
	_t = _t		+ [4];
	_p = _p		+ [5];
	_z = _z		+ [0];

	_u = _u		+ ["US_Soldier_TL_EP1"];
	_c = _c		+ [240];
	_t = _t		+ [5];
	_p = _p		+ [6];
	_z = _z		+ [1];

	_u = _u		+ ["US_Soldier_SL_EP1"];
	_c = _c		+ [220];
	_t = _t		+ [5];
	_p = _p		+ [7];
	_z = _z		+ [2];
	
	_u = _u		+ ["US_Soldier_Officer_EP1"];
	_c = _c		+ [250];
	_t = _t		+ [5];
	_p = _p		+ [7];
	_z = _z		+ [1];
};

_westBarracksDescriptions = [];
_westBarracksImages = [];

_total = Count _u;
_done = [];
for [{_count = 0},{_count < _total},{_count = _count + 1}] do {
	if !((_u select _count) in _done) then {
		_config = configFile >> "CfgVehicles" >> (_u Select _count);
		_westBarracksDescriptions = _westBarracksDescriptions + [GetText (_config >> "displayName")];
		_westBarracksImages = _westBarracksImages + [GetText (_config >> "portrait")];
		_done = _done + [_u select _count];
	};
};

['WFBE_WESTBARRACKSUNITS',_u,true] Call SetNamespace;
['WFBE_WESTBARRACKSCOSTS',_c,true] Call SetNamespace;
['WFBE_WESTBARRACKSTIMES',_t,true] Call SetNamespace;
['WFBE_WESTBARRACKSPOINTS',_p,true] Call SetNamespace;
['WFBE_WESTBARRACKSUPGRADES',_z,true] Call SetNamespace;
['WFBE_WESTBARRACKSDESCRIPTIONS',_westBarracksDescriptions,true] Call SetNamespace;
['WFBE_WESTBARRACKSIMAGES',_westBarracksImages,true] Call SetNamespace;

if (allies) then {
	_westAlliesBarracksDescriptions = [];
	_eastAlliesBarracksDescriptions = [];

	//--- CDF Allies.
	_u			= ["CDF_Soldier"];
	_c			= [150];
	_t			= [4];
	
	_u = _u		+ ["CDF_Soldier_Engineer"];
	_c = _c		+ [225];
	_t = _t		+ [4];
	
	_u = _u		+ ["CDF_Soldier_Light"];
	_c = _c		+ [175];
	_t = _t		+ [4];
	
	_u = _u		+ ["CDF_Soldier_GL"];
	_c = _c		+ [180];
	_t = _t		+ [4];
	
	_u = _u		+ ["CDF_Soldier_Militia"];
	_c = _c		+ [160];
	_t = _t		+ [4];
	
	_u = _u		+ ["CDF_Soldier_Medic"];
	_c = _c		+ [210];
	_t = _t		+ [4];
	
	_u = _u		+ ["CDF_Soldier_Sniper"];
	_c = _c		+ [230];
	_t = _t		+ [4];
	
	_u = _u		+ ["CDF_Soldier_Spotter"];
	_c = _c		+ [240];
	_t = _t		+ [4];
	
	_u = _u		+ ["CDF_Soldier_Marksman"];
	_c = _c		+ [235];
	_t = _t		+ [4];
	
	_u = _u		+ ["CDF_Soldier_RPG"];
	_c = _c		+ [250];
	_t = _t		+ [4];
	
	_u = _u		+ ["CDF_Soldier_Strela"];
	_c = _c		+ [300];
	_t = _t		+ [4];
	
	_u = _u		+ ["CDF_Soldier_AR"];
	_c = _c		+ [170];
	_t = _t		+ [4];
	
	_u = _u		+ ["CDF_Soldier_MG"];
	_c = _c		+ [180];
	_t = _t		+ [4];
	
	_u = _u		+ ["CDF_Soldier_TL"];
	_c = _c		+ [210];
	_t = _t		+ [4];
	
	_u = _u		+ ["CDF_Soldier_Officer"];
	_c = _c		+ [230];
	_t = _t		+ [4];
	
	_u = _u		+ ["CDF_Commander"];
	_c = _c		+ [275];
	_t = _t		+ [4];
	
	_u = _u		+ ["CDF_Soldier_Pilot"];
	_c = _c		+ [130];
	_t = _t		+ [4];
	
	_u = _u		+ ["CDF_Soldier_Crew"];
	_c = _c		+ [130];
	_t = _t		+ [4];
	
	_total = count _u;
	for [{_count = 0},{_count < _total},{_count = _count + 1}] do {
		_config = configFile >> "CfgVehicles" >> (_u select _count);
		_westAlliesBarracksDescriptions = _westAlliesBarracksDescriptions + [getText (_config >> "displayName")];
	};
	
	['WFBE_WESTALLIESBARRACKSUNITS',_u,true] Call SetNamespace;
	['WFBE_WESTALLIESBARRACKSCOSTS',_c,true] Call SetNamespace;
	['WFBE_WESTALLIESBARRACKSTIMES',_t,true] Call SetNamespace;
	['WFBE_WESTALLIESBARRACKSDESCRIPTIONS',_westAlliesBarracksDescriptions,true] Call SetNamespace;
	
	['WFBE_WESTALLIESSOLDIER','CDF_Soldier',true] Call SetNamespace;
	
	//--- Insurgent Allies.
	_u			= ["Ins_Soldier_1"];
	_c			= [150];
	_t			= [4];
	
	_u = _u		+ ["Ins_Soldier_2"];
	_c = _c		+ [160];
	_t = _t		+ [4];
	
	_u = _u		+ ["Ins_Soldier_GL"];
	_c = _c		+ [175];
	_t = _t		+ [4];
	
	_u = _u		+ ["Ins_Soldier_CO"];
	_c = _c		+ [210];
	_t = _t		+ [4];
	
	_u = _u		+ ["Ins_Commander"];
	_c = _c		+ [250];
	_t = _t		+ [4];
	
	_u = _u		+ ["Ins_Soldier_Medic"];
	_c = _c		+ [175];
	_t = _t		+ [4];
	
	_u = _u		+ ["Ins_Soldier_AR"];
	_c = _c		+ [180];
	_t = _t		+ [4];
	
	_u = _u		+ ["Ins_Soldier_MG"];
	_c = _c		+ [190];
	_t = _t		+ [4];
	
	_u = _u		+ ["Ins_Soldier_AT"];
	_c = _c		+ [220];
	_t = _t		+ [4];
	
	_u = _u		+ ["Ins_Soldier_AA"];
	_c = _c		+ [300];
	_t = _t		+ [4];
	
	_u = _u		+ ["Ins_Soldier_Sniper"];
	_c = _c		+ [220];
	_t = _t		+ [4];
	
	_u = _u		+ ["Ins_Soldier_Sapper"];
	_c = _c		+ [190];
	_t = _t		+ [4];
	
	_u = _u		+ ["Ins_Soldier_Sab"];
	_c = _c		+ [180];
	_t = _t		+ [4];
	
	_u = _u		+ ["Ins_Soldier_Pilot"];
	_c = _c		+ [130];
	_t = _t		+ [4];
	
	_u = _u		+ ["Ins_Soldier_Crew"];
	_c = _c		+ [130];
	_t = _t		+ [4];
	
	_total = count _u;
	for [{_count = 0},{_count < _total},{_count = _count + 1}] do {
		_config = configFile >> "CfgVehicles" >> (_u select _count);
		_eastAlliesBarracksDescriptions = _eastAlliesBarracksDescriptions + [getText (_config >> "displayName")];
	};

	['WFBE_EASTALLIESBARRACKSUNITS',_u,true] Call SetNamespace;
	['WFBE_EASTALLIESBARRACKSCOSTS',_c,true] Call SetNamespace;
	['WFBE_EASTALLIESBARRACKSTIMES',_t,true] Call SetNamespace;
	['WFBE_EASTALLIESBARRACKSDESCRIPTIONS',_eastAlliesBarracksDescriptions,true] Call SetNamespace;
	
	['WFBE_EASTALLIESSOLDIER','Ins_Soldier_1',true] Call SetNamespace;
} else {
	['WFBE_WESTALLIESBARRACKSUNITS',[],true] Call SetNamespace;
	['WFBE_WESTALLIESBARRACKSCOSTS',[],true] Call SetNamespace;
	['WFBE_WESTALLIESBARRACKSDESCRIPTIONS',[],true] Call SetNamespace;
	['WFBE_EASTALLIESBARRACKSUNITS',[],true] Call SetNamespace;
	['WFBE_EASTALLIESBARRACKSCOSTS',[],true] Call SetNamespace;
	['WFBE_EASTALLIESBARRACKSDESCRIPTIONS',[],true] Call SetNamespace;
};

_u = [];
_c = [];
_t = [];
_p = [];
_z = [];

//EAST
if (WF_A2_Vanilla || WF_A2_CombinedOps) then {
	_u = _u		+ ["RU_Soldier"];
	_c = _c		+ [150];
	_t = _t		+ [4];
	_p = _p		+ [5];
	_z = _z		+ [0];

	_u = _u		+ ["RU_Soldier2"];
	_c = _c		+ [120];
	_t = _t		+ [4];
	_p = _p		+ [5];
	_z = _z		+ [0];

	_u = _u		+ ["RU_Soldier_LAT"];
	_c = _c		+ [225];
	_t = _t		+ [5];
	_p = _p		+ [6];
	_z = _z		+ [1];

	_u = _u		+ ["RU_Soldier_AT"];
	_c = _c		+ [350];
	_t = _t		+ [5];
	_p = _p		+ [6];
	_z = _z		+ [2];

	_u = _u		+ ["RU_Soldier_HAT"];
	_c = _c		+ [600];
	_t = _t		+ [7];
	_p = _p		+ [7];
	_z = _z		+ [3];

	_u = _u		+ ["RU_Soldier_AA"];
	_c = _c		+ [400];
	_t = _t		+ [6];
	_p = _p		+ [7];
	_z = _z		+ [1];

	_u = _u		+ ["RU_Soldier_AR"];
	_c = _c		+ [210];
	_t = _t		+ [5];
	_p = _p		+ [6];
	_z = _z		+ [1];

	_u = _u		+ ["RU_Soldier_MG"];
	_c = _c		+ [220];
	_t = _t		+ [5];
	_p = _p		+ [6];
	_z = _z		+ [0];

	_u = _u		+ ["RU_Soldier_GL"];
	_c = _c		+ [160];
	_t = _t		+ [5];
	_p = _p		+ [6];
	_z = _z		+ [0];

	_u = _u		+ ["RU_Soldier_Marksman"];
	_c = _c		+ [300];
	_t = _t		+ [6];
	_p = _p		+ [7];
	_z = _z		+ [1];

	_u = _u		+ ["RU_Soldier_Medic"];
	_c = _c		+ [190];
	_t = _t		+ [4];
	_p = _p		+ [5];
	_z = _z		+ [0];

	_u = _u		+ ["RUS_Soldier1"];
	_c = _c		+ [250];
	_t = _t		+ [7];
	_p = _p		+ [10];
	_z = _z		+ [2];

	_u = _u		+ ["RUS_Soldier2"];
	_c = _c		+ [250];
	_t = _t		+ [7];
	_p = _p		+ [10];
	_z = _z		+ [3];

	_u = _u		+ ["RUS_Soldier_GL"];
	_c = _c		+ [270];
	_t = _t		+ [7];
	_p = _p		+ [10];
	_z = _z		+ [3];

	_u = _u		+ ["RUS_Commander"];
	_c = _c		+ [285];
	_t = _t		+ [7];
	_p = _p		+ [10];
	_z = _z		+ [3];

	_u = _u		+ ["RUS_Soldier_Marksman"];
	_c = _c		+ [280];
	_t = _t		+ [7];
	_p = _p		+ [10];
	_z = _z		+ [3];

	_u = _u		+ ["RUS_Soldier3"];
	_c = _c		+ [290];
	_t = _t		+ [7];
	_p = _p		+ [10];
	_z = _z		+ [3];

	_u = _u		+ ["RUS_Soldier_TL"];
	_c = _c		+ [295];
	_t = _t		+ [7];
	_p = _p		+ [10];
	_z = _z		+ [3];

	_u = _u		+ ["MVD_Soldier_GL"];
	_c = _c		+ [310];
	_t = _t		+ [7];
	_p = _p		+ [10];
	_z = _z		+ [3];

	_u = _u		+ ["MVD_Soldier_MG"];
	_c = _c		+ [320];
	_t = _t		+ [7];
	_p = _p		+ [10];
	_z = _z		+ [3];

	_u = _u		+ ["MVD_Soldier_Marksman"];
	_c = _c		+ [330];
	_t = _t		+ [7];
	_p = _p		+ [10];
	_z = _z		+ [3];

	_u = _u		+ ["MVD_Soldier_AT"];
	_c = _c		+ [340];
	_t = _t		+ [7];
	_p = _p		+ [10];
	_z = _z		+ [3];

	_u = _u		+ ["MVD_Soldier_Sniper"];
	_c = _c		+ [345];
	_t = _t		+ [7];
	_p = _p		+ [10];
	_z = _z		+ [3];

	_u = _u		+ ["MVD_Soldier_TL"];
	_c = _c		+ [350];
	_t = _t		+ [7];
	_p = _p		+ [10];
	_z = _z		+ [3];

	_u = _u		+ ["RU_Soldier_Crew"];
	_c = _c		+ [120];
	_t = _t		+ [4];
	_p = _p		+ [5];
	_z = _z		+ [0];

	_u = _u		+ ["RU_Soldier_Pilot"];
	_c = _c		+ [120];
	_t = _t		+ [4];
	_p = _p		+ [5];
	_z = _z		+ [0];

	_u = _u		+ ["RU_Soldier_TL"];
	_c = _c		+ [240];
	_t = _t		+ [5];
	_p = _p		+ [6];
	_z = _z		+ [1];

	_u = _u		+ ["RU_Soldier_SL"];
	_c = _c		+ [220];
	_t = _t		+ [5];
	_p = _p		+ [7];
	_z = _z		+ [2];
};

if (WF_A2_Arrowhead) then {
	_u = _u		+ ["TK_Soldier_EP1"];
	_c = _c		+ [120];
	_t = _t		+ [4];
	_p = _p		+ [5];
	_z = _z		+ [0];

	_u = _u		+ ["TK_Soldier_B_EP1"];
	_c = _c		+ [125];
	_t = _t		+ [4];
	_p = _p		+ [5];
	_z = _z		+ [0];

	_u = _u		+ ["TK_Soldier_TWS_EP1"];
	_c = _c		+ [205];
	_t = _t		+ [4];
	_p = _p		+ [5];
	_z = _z		+ [2];

	_u = _u		+ ["TK_Soldier_Engineer_EP1"];
	_c = _c		+ [155];
	_t = _t		+ [4];
	_p = _p		+ [5];
	_z = _z		+ [0];

	_u = _u		+ ["TK_Soldier_LAT_EP1"];
	_c = _c		+ [225];
	_t = _t		+ [5];
	_p = _p		+ [6];
	_z = _z		+ [1];

	_u = _u		+ ["TK_Soldier_AT_EP1"];
	_c = _c		+ [350];
	_t = _t		+ [5];
	_p = _p		+ [6];
	_z = _z		+ [2];

	_u = _u		+ ["TK_Soldier_HAT_EP1"];
	_c = _c		+ [600];
	_t = _t		+ [7];
	_p = _p		+ [7];
	_z = _z		+ [3];

	_u = _u		+ ["TK_Soldier_AA_EP1"];
	_c = _c		+ [400];
	_t = _t		+ [6];
	_p = _p		+ [7];
	_z = _z		+ [1];

	_u = _u		+ ["TK_Soldier_AR_EP1"];
	_c = _c		+ [210];
	_t = _t		+ [5];
	_p = _p		+ [6];
	_z = _z		+ [1];

	_u = _u		+ ["TK_Soldier_MG_EP1"];
	_c = _c		+ [220];
	_t = _t		+ [5];
	_p = _p		+ [6];
	_z = _z		+ [0];

	_u = _u		+ ["TK_Soldier_GL_EP1"];
	_c = _c		+ [160];
	_t = _t		+ [5];
	_p = _p		+ [6];
	_z = _z		+ [0];

	_u = _u		+ ["TK_Soldier_Spotter_EP1"];
	_c = _c		+ [300];
	_t = _t		+ [6];
	_p = _p		+ [7];
	_z = _z		+ [1];

	_u = _u		+ ["TK_Soldier_Medic_EP1"];
	_c = _c		+ [190];
	_t = _t		+ [4];
	_p = _p		+ [5];
	_z = _z		+ [0];

	_u = _u		+ ["TK_Special_Forces_EP1"];
	_c = _c		+ [220];
	_t = _t		+ [7];
	_p = _p		+ [10];
	_z = _z		+ [2];

	_u = _u		+ ["TK_Special_Forces_TL_EP1"];
	_c = _c		+ [240];
	_t = _t		+ [7];
	_p = _p		+ [10];
	_z = _z		+ [3];

	_u = _u		+ ["TK_Special_Forces_MG_EP1"];
	_c = _c		+ [270];
	_t = _t		+ [7];
	_p = _p		+ [10];
	_z = _z		+ [3];

	_u = _u		+ ["TK_Soldier_Crew_EP1"];
	_c = _c		+ [120];
	_t = _t		+ [4];
	_p = _p		+ [5];
	_z = _z		+ [0];

	_u = _u		+ ["TK_Soldier_Pilot_EP1"];
	_c = _c		+ [120];
	_t = _t		+ [4];
	_p = _p		+ [5];
	_z = _z		+ [0];

	_u = _u		+ ["TK_Soldier_SL_EP1"];
	_c = _c		+ [220];
	_t = _t		+ [5];
	_p = _p		+ [7];
	_z = _z		+ [2];
	
	_u = _u		+ ["TK_Soldier_Officer_EP1"];
	_c = _c		+ [250];
	_t = _t		+ [5];
	_p = _p		+ [7];
	_z = _z		+ [1];
};

_eastBarracksDescriptions = [];
_eastBarracksImages = [];

_total = Count _u;
_done = [];
for [{_count = 0},{_count < _total},{_count = _count + 1}] do {
	if !((_u select _count) in _done) then {
		_config = configFile >> "CfgVehicles" >> (_u Select _count);
		_eastBarracksDescriptions = _eastBarracksDescriptions + [GetText (_config >> "displayName")];
		_eastBarracksImages = _eastBarracksImages + [GetText (_config >> "portrait")];
		_done = _done + [_u select _count];
	};
};

['WFBE_EASTBARRACKSUNITS',_u,true] Call SetNamespace;
['WFBE_EASTBARRACKSCOSTS',_c,true] Call SetNamespace;
['WFBE_EASTBARRACKSTIMES',_t,true] Call SetNamespace;
['WFBE_EASTBARRACKSPOINTS',_p,true] Call SetNamespace;
['WFBE_EASTBARRACKSUPGRADES',_z,true] Call SetNamespace;
['WFBE_EASTBARRACKSDESCRIPTIONS',_eastBarracksDescriptions,true] Call SetNamespace;
['WFBE_EASTBARRACKSIMAGES',_eastBarracksImages,true] Call SetNamespace;

_u = [];
_c = [];
_t = [];
_p = [];

//RESISTANCE
if (WF_A2_Vanilla || WF_A2_CombinedOps) then {
	_u = _u		+ ["GUE_Soldier_1"];
	_c = _c		+ [100];
	_t = _t		+ [4];
	_p = _p		+ [5];
	
	_u = _u		+ ["GUE_Soldier_2"];
	_c = _c		+ [100];
	_t = _t		+ [4];
	_p = _p		+ [5];

	_u = _u		+ ["GUE_Soldier_3"];
	_c = _c		+ [100];
	_t = _t		+ [4];
	_p = _p		+ [5];

	_u = _u		+ ["GUE_Soldier_GL"];
	_c = _c		+ [150];
	_t = _t		+ [5];
	_p = _p		+ [6];

	_u = _u		+ ["GUE_Soldier_AT"];
	_c = _c		+ [200];
	_t = _t		+ [6];
	_p = _p		+ [7];

	_u = _u		+ ["GUE_Soldier_AA"];
	_c = _c		+ [200];
	_t = _t		+ [6];
	_p = _p		+ [7];

	_u = _u		+ ["GUE_Soldier_AR"];
	_c = _c		+ [150];
	_t = _t		+ [4];
	_p = _p		+ [6];

	_u = _u		+ ["GUE_Soldier_MG"];
	_c = _c		+ [150];
	_t = _t		+ [4];
	_p = _p		+ [6];

	_u = _u		+ ["GUE_Soldier_Sniper"];
	_c = _c		+ [175];
	_t = _t		+ [6];
	_p = _p		+ [7];

	_u = _u		+ ["GUE_Soldier_Medic"];
	_c = _c		+ [125];
	_t = _t		+ [4];
	_p = _p		+ [5];

	_u = _u		+ ["GUE_Soldier_Crew"];
	_c = _c		+ [75];
	_t = _t		+ [4];
	_p = _p		+ [5];

	_u = _u		+ ["GUE_Soldier_Pilot"];
	_c = _c		+ [75];
	_t = _t		+ [4];
	_p = _p		+ [5];

	_u = _u		+ ["GUE_Soldier_Scout"];
	_c = _c		+ [150];
	_t = _t		+ [5];
	_p = _p		+ [6];

	_u = _u		+ ["GUE_Soldier_Sab"];
	_c = _c		+ [200];
	_t = _t		+ [6];
	_p = _p		+ [7];

	_u = _u		+ ["GUE_Commander"];
	_c = _c		+ [200];
	_t = _t		+ [6];
	_p = _p		+ [7];

	_u = _u		+ ["GUE_Worker2"];
	_c = _c		+ [80];
	_t = _t		+ [4];
	_p = _p		+ [5];

	_u = _u		+ ["GUE_Woodlander3"];
	_c = _c		+ [80];
	_t = _t		+ [4];
	_p = _p		+ [5];

	_u = _u		+ ["GUE_Villager3"];
	_c = _c		+ [80];
	_t = _t		+ [4];
	_p = _p		+ [5];

	_u = _u		+ ["GUE_Woodlander2"];
	_c = _c		+ [80];
	_t = _t		+ [4];
	_p = _p		+ [5];

	_u = _u		+ ["GUE_Woodlander1"];
	_c = _c		+ [80];
	_t = _t		+ [4];
	_p = _p		+ [5];

	_u = _u		+ ["GUE_Villager4"];
	_c = _c		+ [80];
	_t = _t		+ [4];
	_p = _p		+ [5];
};

if (WF_A2_Arrowhead || WF_A2_CombinedOps) then {
	_u = _u		+ ["TK_GUE_Soldier_EP1"];
	_c = _c		+ [100];
	_t = _t		+ [4];
	_p = _p		+ [5];

	_u = _u		+ ["TK_GUE_Soldier_2_EP1"];
	_c = _c		+ [100];
	_t = _t		+ [4];
	_p = _p		+ [5];

	_u = _u		+ ["TK_GUE_Soldier_3_EP1"];
	_c = _c		+ [100];
	_t = _t		+ [4];
	_p = _p		+ [5];

	_u = _u		+ ["TK_GUE_Soldier_4_EP1"];
	_c = _c		+ [100];
	_t = _t		+ [4];
	_p = _p		+ [5];

	_u = _u		+ ["TK_GUE_Soldier_5_EP1"];
	_c = _c		+ [75];
	_t = _t		+ [4];
	_p = _p		+ [5];

	_u = _u		+ ["TK_GUE_Soldier_AT_EP1"];
	_c = _c		+ [200];
	_t = _t		+ [6];
	_p = _p		+ [7];
	
	_u = _u		+ ["TK_GUE_Soldier_AAT_EP1"];
	_c = _c		+ [160];
	_t = _t		+ [6];
	_p = _p		+ [7];

	_u = _u		+ ["TK_GUE_Soldier_AA_EP1"];
	_c = _c		+ [200];
	_t = _t		+ [6];
	_p = _p		+ [7];

	_u = _u		+ ["TK_GUE_Soldier_AR_EP1"];
	_c = _c		+ [150];
	_t = _t		+ [4];
	_p = _p		+ [6];

	_u = _u		+ ["TK_GUE_Soldier_MG_EP1"];
	_c = _c		+ [150];
	_t = _t		+ [4];
	_p = _p		+ [6];

	_u = _u		+ ["TK_GUE_Soldier_Sniper_EP1"];
	_c = _c		+ [175];
	_t = _t		+ [6];
	_p = _p		+ [7];

	_u = _u		+ ["TK_GUE_Bonesetter_EP1"];
	_c = _c		+ [125];
	_t = _t		+ [4];
	_p = _p		+ [5];

	_u = _u		+ ["TK_GUE_Soldier_HAT_EP1"];
	_c = _c		+ [375];
	_t = _t		+ [4];
	_p = _p		+ [5];

	_u = _u		+ ["TK_GUE_Soldier_TL_EP1"];
	_c = _c		+ [180];
	_t = _t		+ [5];
	_p = _p		+ [6];

	_u = _u		+ ["TK_GUE_Warlord_EP1"];
	_c = _c		+ [200];
	_t = _t		+ [6];
	_p = _p		+ [7];
};

_resistanceBarracksDescriptions = [];
_resistanceBarracksImages = [];

_total = Count _u;
_done = [];
for [{_count = 0},{_count < _total},{_count = _count + 1}] do {
	if !((_u select _count) in _done) then {
		_config = configFile >> "CfgVehicles" >> (_u Select _count);
		_resistanceBarracksDescriptions = _resistanceBarracksDescriptions + [GetText (_config >> "displayName")];
		_resistanceBarracksImages = _resistanceBarracksImages + [GetText (_config >> "portrait")];
		_done = _done + [_u select _count];
	};
};

['WFBE_GUERBARRACKSUNITS',_u,true] Call SetNamespace;
['WFBE_GUERBARRACKSCOSTS',_c,true] Call SetNamespace;
['WFBE_GUERBARRACKSTIMES',_t,true] Call SetNamespace;
['WFBE_GUERBARRACKSPOINTS',_p,true] Call SetNamespace;
['WFBE_GUERBARRACKSDESCRIPTIONS',_resistanceBarracksDescriptions,true] Call SetNamespace;
['WFBE_GUERBARRACKSIMAGES',_resistanceBarracksImages,true] Call SetNamespace;

if (WF_A2_Vanilla) then {
	['WFBE_WESTSOLDIER','USMC_Soldier',true] Call SetNamespace;
	['WFBE_EASTSOLDIER','RU_Soldier',true] Call SetNamespace;
	['WFBE_GUERSOLDIER','GUE_Soldier_1',true] Call SetNamespace;
};

if (WF_A2_Arrowhead) then {
	['WFBE_WESTSOLDIER','US_Soldier_EP1',true] Call SetNamespace;
	['WFBE_EASTSOLDIER','TK_Soldier_EP1',true] Call SetNamespace;
	['WFBE_GUERSOLDIER','TK_GUE_Soldier_EP1',true] Call SetNamespace;
};

if (WF_A2_CombinedOps) then {
	_resType = 'WFBE_RESISTANCEFACTION' Call GetNamespace;
	if (isNil '_resType') then {_resType = -1};
	['WFBE_WESTSOLDIER','US_Soldier_EP1',true] Call SetNamespace;
	['WFBE_EASTSOLDIER','RU_Soldier',true] Call SetNamespace;
	switch (_resType) do {
		case 0: {['WFBE_GUERSOLDIER','GUE_Soldier_1',true] Call SetNamespace};
		case 1: {['WFBE_GUERSOLDIER','TK_GUE_Soldier_EP1',true] Call SetNamespace};
	};
};

westSoldierBaseClass = "SoldierWB";
eastSoldierBaseClass = "SoldierEB";
resistanceSoldierBaseClass = "SoldierGB";

['WFBE_SOLDIERUNITS',('WFBE_WESTBARRACKSUNITS' Call GetNamespace) + ('WFBE_EASTBARRACKSUNITS' Call GetNamespace) + ('WFBE_GUERBARRACKSUNITS' Call GetNamespace) + ('WFBE_WESTALLIESBARRACKSUNITS' Call GetNamespace) + ('WFBE_EASTALLIESBARRACKSUNITS' Call GetNamespace),true] Call SetNamespace;
['WFBE_SOLDIERUNITCOSTS',('WFBE_WESTBARRACKSCOSTS' Call GetNamespace) + ('WFBE_EASTBARRACKSCOSTS' Call GetNamespace) + ('WFBE_GUERBARRACKSCOSTS' Call GetNamespace) + ('WFBE_WESTALLIESBARRACKSCOSTS' Call GetNamespace) + ('WFBE_EASTALLIESBARRACKSCOSTS' Call GetNamespace),true] Call SetNamespace;
['WFBE_SOLDIERUNITDESCRIPTIONS',('WFBE_WESTBARRACKSDESCRIPTIONS' Call GetNamespace) + ('WFBE_EASTBARRACKSDESCRIPTIONS' Call GetNamespace) + ('WFBE_GUERBARRACKSDESCRIPTIONS' Call GetNamespace) + ('WFBE_WESTALLIESBARRACKSDESCRIPTIONS' Call GetNamespace) + ('WFBE_EASTALLIESBARRACKSDESCRIPTIONS' Call GetNamespace),true] Call SetNamespace;

_longestBarracksBuildTime = 0;
_t = ('WFBE_EASTBARRACKSTIMES' Call GetNamespace) + ('WFBE_WESTBARRACKSTIMES' Call GetNamespace) + ('WFBE_GUERBARRACKSTIMES' Call GetNamespace);
for [{_count = Count _t - 1},{_count >= 0},{_count = _count - 1}] do {
	if (_t Select _count > _longestBarracksBuildTime) then {
		_longestBarracksBuildTime = _t Select _count;
	};
};

['WFBE_LONGESTBARRACKSBUILDTIME',_longestBarracksBuildTime,true] Call SetNamespace;