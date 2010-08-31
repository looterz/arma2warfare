//*****************************************************************************************
//Description: Light vehicle factory configurations.
//*****************************************************************************************
Private["_c","_config","_data","_done","_m","_p","_soldierCost","_t","_total","_u"];

_u = [];
_c = [];
_m = [];
_t = [];
_p = [];
_z = [];

//WEST
if (WF_A2_Vanilla) then {
	_u = _u		+ ["MMT_USMC"];
	_c = _c		+ [50];
	_m = _m		+ [1];
	_t = _t		+ [10];
	_p = _p		+ [10];
	_z = _z		+ [0];
	
	_u = _u		+ ["M1030"];
	_c = _c		+ [150];
	_m = _m		+ [1];
	_t = _t		+ [15];
	_p = _p		+ [10];
	_z = _z		+ [0];

	_u = _u		+ ["HMMWV"];
	_c = _c		+ [200];
	_m = _m		+ [1];
	_t = _t		+ [15];
	_p = _p		+ [10];
	_z = _z		+ [0];

	_u = _u		+ ["Zodiac"];
	_c = _c		+ [225];
	_m = _m		+ [1];
	_t = _t		+ [15];
	_p = _p		+ [10];
	_z = _z		+ [0];

	_u = _u		+ ["HMMWV_M2"];
	_c = _c		+ [500];
	_m = _m		+ [2];
	_t = _t		+ [17];
	_p = _p		+ [13];
	_z = _z		+ [0];

	_u = _u		+ ["HMMWV_Armored"];
	_c = _c		+ [550];
	_m = _m		+ [2];
	_t = _t		+ [18];
	_p = _p		+ [14];
	_z = _z		+ [1];

	_u = _u		+ ["HMMWV_MK19"];
	_c = _c		+ [700];
	_m = _m		+ [2];
	_t = _t		+ [20];
	_p = _p		+ [15];
	_z = _z		+ [1];

	_u = _u		+ ["HMMWV_TOW"];
	_c = _c		+ [800];
	_m = _m		+ [2];
	_t = _t		+ [20];
	_p = _p		+ [15];
	_z = _z		+ [2];

	_u = _u		+ ["HMMWV_Avenger"];
	_c = _c		+ [950];
	_m = _m		+ [2];
	_t = _t		+ [30];
	_p = _p		+ [25];
	_z = _z		+ [3];

	_u = _u		+ ["HMMWV_Ambulance"];
	_c = _c		+ [350];
	_m = _m		+ [1];
	_t = _t		+ [20];
	_p = _p		+ [0];
	_z = _z		+ [2];

	_u = _u		+ ["MTVR"];
	_c = _c		+ [300];
	_m = _m		+ [1];
	_t = _t		+ [20];
	_p = _p		+ [12];
	_z = _z		+ [0];

	_u = _u		+ ["MtvrRepair"];
	_c = _c		+ [425];
	_m = _m		+ [1];
	_t = _t		+ [22];
	_p = _p		+ [15];
	_z = _z		+ [0];

	_u = _u		+ ["WarfareReammoTruck_USMC"];
	_c = _c		+ [450];
	_m = _m		+ [1];
	_t = _t		+ [22];
	_p = _p		+ [15];
	_z = _z		+ [1];

	_u = _u		+ ["MtvrRefuel"];
	_c = _c		+ [400];
	_m = _m		+ [1];
	_t = _t		+ [22];
	_p = _p		+ [15];
	_z = _z		+ [1];

	if (('WFBE_SUPPLYSYSTEM' Call GetNamespace) == 0) then {
		_u = _u		+ ["WarfareSupplyTruck_USMC"];
		_c = _c		+ [450];
		_m = _m		+ [1];
		_t = _t		+ [22];
		_p = _p		+ [15];
		_z = _z		+ [0];
	};

	_u = _u		+ ["RHIB"];
	_c = _c		+ [750];
	_m = _m		+ [2];
	_t = _t		+ [25];
	_p = _p		+ [15];
	_z = _z		+ [1];

	_u = _u		+ ["RHIB2Turret"];
	_c = _c		+ [950];
	_m = _m		+ [2];
	_t = _t		+ [25];
	_p = _p		+ [15];
	_z = _z		+ [2];

	_u = _u		+ ["LAV25"];
	_c = _c		+ [1250];
	_m = _m		+ [3];
	_t = _t		+ [23];
	_p = _p		+ [18];
	_z = _z		+ [3];
};

if (WF_A2_Arrowhead) then {
	_u = _u		+ ["M1030_US_DES_EP1"];
	_c = _c		+ [150];
	_m = _m		+ [1];
	_t = _t		+ [15];
	_p = _p		+ [10];
	_z = _z		+ [0];	
	
	_u = _u		+ ["ATV_US_EP1"];
	_c = _c		+ [175];
	_m = _m		+ [1];
	_t = _t		+ [15];
	_p = _p		+ [10];
	_z = _z		+ [0];

	_u = _u		+ ["HMMWV_DES_EP1"];
	_c = _c		+ [200];
	_m = _m		+ [1];
	_t = _t		+ [15];
	_p = _p		+ [10];
	_z = _z		+ [0];

	_u = _u		+ ["HMMWV_M1035_DES_EP1"];
	_c = _c		+ [250];
	_m = _m		+ [1];
	_t = _t		+ [15];
	_p = _p		+ [10];
	_z = _z		+ [0];
	
	_u = _u		+ ["HMMWV_Terminal_EP1"];
	_c = _c		+ [300];
	_m = _m		+ [1];
	_t = _t		+ [15];
	_p = _p		+ [10];
	_z = _z		+ [1];

	_u = _u		+ ["HMMWV_MK19_DES_EP1"];
	_c = _c		+ [500];
	_m = _m		+ [2];
	_t = _t		+ [17];
	_p = _p		+ [13];
	_z = _z		+ [1];
	
	_u = _u		+ ["HMMWV_M998A2_SOV_DES_EP1"];
	_c = _c		+ [550];
	_m = _m		+ [2];
	_t = _t		+ [17];
	_p = _p		+ [13];
	_z = _z		+ [1];
	
	_u = _u		+ ["HMMWV_M1151_M2_DES_EP1"];
	_c = _c		+ [575];
	_m = _m		+ [2];
	_t = _t		+ [17];
	_p = _p		+ [13];
	_z = _z		+ [0];

	_u = _u		+ ["HMMWV_M998_crows_M2_DES_EP1"];
	_c = _c		+ [650];
	_m = _m		+ [2];
	_t = _t		+ [20];
	_p = _p		+ [15];
	_z = _z		+ [1];
	
	_u = _u		+ ["HMMWV_M998_crows_MK19_DES_EP1"];
	_c = _c		+ [850];
	_m = _m		+ [2];
	_t = _t		+ [20];
	_p = _p		+ [15];
	_z = _z		+ [1];

	_u = _u		+ ["HMMWV_TOW_DES_EP1"];
	_c = _c		+ [900];
	_m = _m		+ [2];
	_t = _t		+ [20];
	_p = _p		+ [15];
	_z = _z		+ [2];
	
	_u = _u		+ ["HMMWV_Avenger_DES_EP1"];
	_c = _c		+ [1200];
	_m = _m		+ [2];
	_t = _t		+ [20];
	_p = _p		+ [15];
	_z = _z		+ [3];

	_u = _u		+ ["HMMWV_Ambulance_DES_EP1"];
	_c = _c		+ [350];
	_m = _m		+ [1];
	_t = _t		+ [20];
	_p = _p		+ [0];
	_z = _z		+ [2];

	_u = _u		+ ["MTVR_DES_EP1"];
	_c = _c		+ [300];
	_m = _m		+ [1];
	_t = _t		+ [20];
	_p = _p		+ [12];
	_z = _z		+ [0];

	_u = _u		+ ["MtvrRepair_DES_EP1"];
	_c = _c		+ [425];
	_m = _m		+ [1];
	_t = _t		+ [22];
	_p = _p		+ [15];
	_z = _z		+ [0];

	_u = _u		+ ["MtvrReammo_DES_EP1"];
	_c = _c		+ [450];
	_m = _m		+ [1];
	_t = _t		+ [22];
	_p = _p		+ [15];
	_z = _z		+ [1];

	_u = _u		+ ["MtvrRefuel_DES_EP1"];
	_c = _c		+ [400];
	_m = _m		+ [1];
	_t = _t		+ [22];
	_p = _p		+ [15];
	_z = _z		+ [1];

	if (('WFBE_SUPPLYSYSTEM' Call GetNamespace) == 0) then {
		_u = _u		+ ["MtvrSupply_DES_EP1"];
		_c = _c		+ [450];
		_m = _m		+ [1];
		_t = _t		+ [22];
		_p = _p		+ [15];
		_z = _z		+ [0];
	};
};

if (WF_A2_CombinedOps) then {
	_u = _u		+ ["M1030_US_DES_EP1"];
	_c = _c		+ [150];
	_m = _m		+ [1];
	_t = _t		+ [15];
	_p = _p		+ [10];
	_z = _z		+ [0];	
	
	_u = _u		+ ["ATV_US_EP1"];
	_c = _c		+ [175];
	_m = _m		+ [1];
	_t = _t		+ [15];
	_p = _p		+ [10];
	_z = _z		+ [0];

	_u = _u		+ ["HMMWV_DES_EP1"];
	_c = _c		+ [200];
	_m = _m		+ [1];
	_t = _t		+ [15];
	_p = _p		+ [10];
	_z = _z		+ [0];

	_u = _u		+ ["HMMWV_M1035_DES_EP1"];
	_c = _c		+ [250];
	_m = _m		+ [1];
	_t = _t		+ [15];
	_p = _p		+ [10];
	_z = _z		+ [0];
	
	_u = _u		+ ["HMMWV_Terminal_EP1"];
	_c = _c		+ [300];
	_m = _m		+ [1];
	_t = _t		+ [15];
	_p = _p		+ [10];
	_z = _z		+ [1];

	_u = _u		+ ["HMMWV_MK19_DES_EP1"];
	_c = _c		+ [500];
	_m = _m		+ [2];
	_t = _t		+ [17];
	_p = _p		+ [13];
	_z = _z		+ [1];
	
	_u = _u		+ ["HMMWV_M998A2_SOV_DES_EP1"];
	_c = _c		+ [550];
	_m = _m		+ [2];
	_t = _t		+ [17];
	_p = _p		+ [13];
	_z = _z		+ [1];
	
	_u = _u		+ ["HMMWV_M1151_M2_DES_EP1"];
	_c = _c		+ [600];
	_m = _m		+ [2];
	_t = _t		+ [17];
	_p = _p		+ [13];
	_z = _z		+ [1];

	_u = _u		+ ["HMMWV_M998_crows_M2_DES_EP1"];
	_c = _c		+ [650];
	_m = _m		+ [2];
	_t = _t		+ [20];
	_p = _p		+ [15];
	_z = _z		+ [0];
	
	_u = _u		+ ["HMMWV_M998_crows_MK19_DES_EP1"];
	_c = _c		+ [850];
	_m = _m		+ [2];
	_t = _t		+ [20];
	_p = _p		+ [15];
	_z = _z		+ [1];

	_u = _u		+ ["HMMWV_TOW_DES_EP1"];
	_c = _c		+ [1000];
	_m = _m		+ [2];
	_t = _t		+ [20];
	_p = _p		+ [15];
	_z = _z		+ [2];

	_u = _u		+ ["LAV25"];
	_c = _c		+ [1250];
	_m = _m		+ [3];
	_t = _t		+ [23];
	_p = _p		+ [18];
	_z = _z		+ [3];

	_u = _u		+ ["HMMWV_Avenger_DES_EP1"];
	_c = _c		+ [2500];
	_m = _m		+ [2];
	_t = _t		+ [20];
	_p = _p		+ [15];
	_z = _z		+ [2];
	
	_u = _u		+ ["HMMWV_Ambulance_DES_EP1"];
	_c = _c		+ [500];
	_m = _m		+ [1];
	_t = _t		+ [20];
	_p = _p		+ [0];
	_z = _z		+ [2];

	_u = _u		+ ["MTVR_DES_EP1"];
	_c = _c		+ [300];
	_m = _m		+ [1];
	_t = _t		+ [20];
	_p = _p		+ [12];
	_z = _z		+ [0];

	_u = _u		+ ["MtvrRepair_DES_EP1"];
	_c = _c		+ [425];
	_m = _m		+ [1];
	_t = _t		+ [22];
	_p = _p		+ [15];
	_z = _z		+ [0];

	_u = _u		+ ["MtvrReammo_DES_EP1"];
	_c = _c		+ [450];
	_m = _m		+ [1];
	_t = _t		+ [22];
	_p = _p		+ [15];
	_z = _z		+ [1];

	_u = _u		+ ["MtvrRefuel_DES_EP1"];
	_c = _c		+ [400];
	_m = _m		+ [1];
	_t = _t		+ [22];
	_p = _p		+ [15];
	_z = _z		+ [1];

	if (('WFBE_SUPPLYSYSTEM' Call GetNamespace) == 0) then {
		_u = _u		+ ["MtvrSupply_DES_EP1"];
		_c = _c		+ [450];
		_m = _m		+ [1];
		_t = _t		+ [22];
		_p = _p		+ [15];
		_z = _z		+ [0];
	};
};

_soldierCost = 'WFBE_CREWCOST' Call GetNamespace;

_westLightDescriptions = [];
_westLightImages = [];
_westLightMannedCosts = [];

_total = Count _u;
_done = [];
for [{_count = 0},{_count < _total},{_count = _count + 1}] do {
	if !((_u select _count) in _done) then {
		_config = configFile >> "CfgVehicles" >> (_u Select _count);
		_westLightMannedCosts = _westLightMannedCosts + [(_c Select _count) + (_m Select _count) * _soldierCost];
		_westLightDescriptions = _westLightDescriptions + [GetText (_config >> "displayName")];
		_westLightImages = _westLightImages + [GetText (_config >> "picture")];
		_done = _done + [_u select _count];
	};
};

['WFBE_WESTLIGHTUNITS',_u,true] Call SetNamespace;
['WFBE_WESTLIGHTCOSTS',_c,true] Call SetNamespace;
['WFBE_WESTLIGHTCREWS',_m,true] Call SetNamespace;
['WFBE_WESTLIGHTTIMES',_t,true] Call SetNamespace;
['WFBE_WESTLIGHTPOINTS',_p,true] Call SetNamespace;
['WFBE_WESTLIGHTUPGRADES',_z,true] Call SetNamespace;
['WFBE_WESTLIGHTDESCRIPTIONS',_westLightDescriptions,true] Call SetNamespace;
['WFBE_WESTLIGHTIMAGES',_westLightImages,true] Call SetNamespace;
['WFBE_WESTLIGHTMANNEDCOSTS',_westLightMannedCosts,true] Call SetNamespace;

if (allies) then {
	_westAlliesLightDescriptions = [];
	_eastAlliesLightDescriptions = [];

	//--- CDF Allies.
	_u			= ["UAZ_CDF"];
	_c			= [150];
	_t			= [15];
	_m			= [1];

	_u = _u		+ ["Ural_CDF"];
	_c = _c		+ [300];
	_t = _t		+ [20];
	_m = _m		+ [2];

	_u = _u		+ ["UAZ_MG_CDF"];
	_c = _c		+ [350];
	_t = _t		+ [20];
	_m = _m		+ [2];

	_u = _u		+ ["UAZ_AGS30_CDF"];
	_c = _c		+ [500];
	_t = _t		+ [25];
	_m = _m		+ [2];

	_u = _u		+ ["BRDM2_CDF"];
	_c = _c		+ [900];
	_t = _t		+ [25];
	_m = _m		+ [2];

	_u = _u		+ ["BRDM2_ATGM_CDF"];
	_c = _c		+ [1300];
	_t = _t		+ [25];
	_m = _m		+ [2];

	_u = _u		+ ["Ural_ZU23_CDF"];
	_c = _c		+ [1500];
	_t = _t		+ [30];
	_m = _m		+ [2];

	_u = _u		+ ["GRAD_CDF"];
	_c = _c		+ [3200];
	_t = _t		+ [35];
	_m = _m		+ [2];

	_total = count _u;
	for [{_count = 0},{_count < _total},{_count = _count + 1}] do {
		_config = configFile >> "CfgVehicles" >> (_u select _count);
		_westAlliesLightDescriptions = _westAlliesLightDescriptions + [getText (_config >> "displayName")];
	};
	
	['WFBE_WESTALLIESLIGHTUNITS',_u,true] Call SetNamespace;
	['WFBE_WESTALLIESLIGHTCOSTS',_c,true] Call SetNamespace;
	['WFBE_WESTALLIESLIGHTCREWS',_m,true] Call SetNamespace;
	['WFBE_WESTALLIESLIGHTTIMES',_t,true] Call SetNamespace;
	['WFBE_WESTALLIESLIGHTDESCRIPTIONS',_westAlliesLightDescriptions,true] Call SetNamespace;

	//--- Insurgent Allies.
	_u			= ["UAZ_INS"];
	_c			= [150];
	_t			= [15];
	_m			= [1];

	_u = _u		+ ["Ural_INS"];
	_c = _c		+ [300];
	_t = _t		+ [20];
	_m = _m		+ [2];

	_u = _u		+ ["UAZ_MG_INS"];
	_c = _c		+ [350];
	_t = _t		+ [20];
	_m = _m		+ [2];

	_u = _u		+ ["UAZ_AGS30_INS"];
	_c = _c		+ [500];
	_t = _t		+ [25];
	_m = _m		+ [2];
	
	_u = _u		+ ["UAZ_SPG9_INS"];
	_c = _c		+ [600];
	_t = _t		+ [25];
	_m = _m		+ [2];

	_u = _u		+ ["BRDM2_INS"];
	_c = _c		+ [900];
	_t = _t		+ [25];
	_m = _m		+ [2];

	_u = _u		+ ["BRDM2_ATGM_INS"];
	_c = _c		+ [1300];
	_t = _t		+ [25];
	_m = _m		+ [2];

	_u = _u		+ ["Ural_ZU23_INS"];
	_c = _c		+ [1500];
	_t = _t		+ [30];
	_m = _m		+ [2];

	_u = _u		+ ["GRAD_INS"];
	_c = _c		+ [3200];
	_t = _t		+ [35];
	_m = _m		+ [2];

	_total = count _u;
	for [{_count = 0},{_count < _total},{_count = _count + 1}] do {
		_config = configFile >> "CfgVehicles" >> (_u select _count);
		_eastAlliesLightDescriptions = _eastAlliesLightDescriptions + [getText (_config >> "displayName")];
	};

	['WFBE_EASTALLIESLIGHTUNITS',_u,true] Call SetNamespace;
	['WFBE_EASTALLIESLIGHTCOSTS',_c,true] Call SetNamespace;
	['WFBE_EASTALLIESLIGHTCREWS',_m,true] Call SetNamespace;
	['WFBE_EASTALLIESLIGHTTIMES',_t,true] Call SetNamespace;
	['WFBE_EASTALLIESLIGHTDESCRIPTIONS',_eastAlliesLightDescriptions,true] Call SetNamespace;
} else {
	['WFBE_WESTALLIESLIGHTUNITS',[],true] Call SetNamespace;
	['WFBE_WESTALLIESLIGHTCOSTS',[],true] Call SetNamespace;
	['WFBE_WESTALLIESLIGHTDESCRIPTIONS',[],true] Call SetNamespace;
	['WFBE_EASTALLIESLIGHTUNITS',[],true] Call SetNamespace;
	['WFBE_EASTALLIESLIGHTCOSTS',[],true] Call SetNamespace;
	['WFBE_EASTALLIESLIGHTDESCRIPTIONS',[],true] Call SetNamespace;
};

_u = [];
_c = [];
_m = [];
_t = [];
_p = [];
_z = [];

//EAST
if (WF_A2_Vanilla) then {
	_u = _u		+ ["MMT_Civ"];
	_c = _c		+ [50];
	_m = _m		+ [1];
	_t = _t		+ [15];
	_p = _p		+ [10];
	_z = _z		+ [0];

	_u = _u		+ ["TT650_Ins"];
	_c = _c		+ [150];
	_m = _m		+ [1];
	_t = _t		+ [15];
	_p = _p		+ [10];
	_z = _z		+ [0];

	_u = _u		+ ["UAZ_RU"];
	_c = _c		+ [200];
	_m = _m		+ [1];
	_t = _t		+ [15];
	_p = _p		+ [10];
	_z = _z		+ [0];

	_u = _u		+ ["PBX"];
	_c = _c		+ [225];
	_m = _m		+ [1];
	_t = _t		+ [15];
	_p = _p		+ [10];
	_z = _z		+ [0];

	_u = _u		+ ["UAZ_MG_INS"];
	_c = _c		+ [360];
	_m = _m		+ [2];
	_t = _t		+ [17];
	_p = _p		+ [15];
	_z = _z		+ [0];

	_u = _u		+ ["UAZ_AGS30_RU"];
	_c = _c		+ [425];
	_m = _m		+ [2];
	_t = _t		+ [17];
	_p = _p		+ [15];
	_z = _z		+ [1];

	_u = _u		+ ["UAZ_SPG9_INS"];
	_c = _c		+ [750];
	_m = _m		+ [2];
	_t = _t		+ [17];
	_p = _p		+ [15];
	_z = _z		+ [2];

	_u = _u		+ ["Kamaz"];
	_c = _c		+ [300];
	_m = _m		+ [1];
	_t = _t		+ [20];
	_p = _p		+ [12];
	_z = _z		+ [0];

	_u = _u		+ ["KamazRepair"];
	_c = _c		+ [425];
	_m = _m		+ [1];
	_t = _t		+ [22];
	_p = _p		+ [15];
	_z = _z		+ [0];

	_u = _u		+ ["WarfareReammoTruck_RU"];
	_c = _c		+ [450];
	_m = _m		+ [1];
	_t = _t		+ [22];
	_p = _p		+ [15];
	_z = _z		+ [1];

	_u = _u		+ ["KamazRefuel"];
	_c = _c		+ [400];
	_m = _m		+ [1];
	_t = _t		+ [22];
	_p = _p		+ [15];
	_z = _z		+ [1];

	if (('WFBE_SUPPLYSYSTEM' Call GetNamespace) == 0) then {
		_u = _u		+ ["WarfareSupplyTruck_RU"];
		_c = _c		+ [450];
		_m = _m		+ [1];
		_t = _t		+ [22];
		_p = _p		+ [15];
		_z = _z		+ [0];
	};

	_u = _u		+ ["GAZ_Vodnik_MedEvac"];
	_c = _c		+ [425];
	_m = _m		+ [1];
	_t = _t		+ [25];
	_p = _p		+ [0];
	_z = _z		+ [2];

	_u = _u		+ ["BRDM2_INS"];
	_c = _c		+ [900];
	_m = _m		+ [2];
	_t = _t		+ [23];
	_p = _p		+ [10];
	_z = _z		+ [2];

	_u = _u		+ ["BRDM2_ATGM_INS"];
	_c = _c		+ [1520];
	_m = _m		+ [2];
	_t = _t		+ [23];
	_p = _p		+ [10];
	_z = _z		+ [3];

	_u = _u		+ ["GAZ_Vodnik"];
	_c = _c		+ [1000];
	_m = _m		+ [2];
	_t = _t		+ [23];
	_p = _p		+ [10];
	_z = _z		+ [2];

	_u = _u		+ ["GAZ_Vodnik_HMG"];
	_c = _c		+ [1250];
	_m = _m		+ [2];
	_t = _t		+ [24];
	_p = _p		+ [11];
	_z = _z		+ [3];

	_u = _u		+ ["Ural_ZU23_INS"];
	_c = _c		+ [1520];
	_m = _m		+ [2];
	_t = _t		+ [20];
	_p = _p		+ [12];
	_z = _z		+ [3];

	_u = _u		+ ["BTR90"];
	_c = _c		+ [1950];
	_m = _m		+ [3];
	_t = _t		+ [25];
	_p = _p		+ [19];
	_z = _z		+ [3];

	_u = _u		+ ["GRAD_RU"];
	_c = _c		+ [3900];
	_m = _m		+ [2];
	_t = _t		+ [25];
	_p = _p		+ [19];
	_z = _z		+ [3];
};

if (WF_A2_Arrowhead) then {
	_u = _u		+ ["TT650_TK_EP1"];
	_c = _c		+ [150];
	_m = _m		+ [1];
	_t = _t		+ [15];
	_p = _p		+ [10];
	_z = _z		+ [0];

	_u = _u		+ ["UAZ_Unarmed_TK_EP1"];
	_c = _c		+ [200];
	_m = _m		+ [1];
	_t = _t		+ [15];
	_p = _p		+ [10];
	_z = _z		+ [0];

	_u = _u		+ ["SUV_TK_EP1"];
	_c = _c		+ [300];
	_m = _m		+ [1];
	_t = _t		+ [15];
	_p = _p		+ [10];
	_z = _z		+ [0];

	_u = _u		+ ["UAZ_MG_TK_EP1"];
	_c = _c		+ [360];
	_m = _m		+ [2];
	_t = _t		+ [15];
	_p = _p		+ [15];
	_z = _z		+ [0];

	_u = _u		+ ["UAZ_AGS30_TK_EP1"];
	_c = _c		+ [425];
	_m = _m		+ [2];
	_t = _t		+ [15];
	_p = _p		+ [15];
	_z = _z		+ [1];

	_u = _u		+ ["LandRover_MG_TK_EP1"];
	_c = _c		+ [500];
	_m = _m		+ [2];
	_t = _t		+ [15];
	_p = _p		+ [15];
	_z = _z		+ [0];
	
	_u = _u		+ ["LandRover_SPG9_TK_EP1"];
	_c = _c		+ [750];
	_m = _m		+ [2];
	_t = _t		+ [17];
	_p = _p		+ [15];
	_z = _z		+ [2];

	_u = _u		+ ["V3S_TK_EP1"];
	_c = _c		+ [250];
	_m = _m		+ [1];
	_t = _t		+ [20];
	_p = _p		+ [15];
	_z = _z		+ [0];
	
	_u = _u		+ ["V3S_Open_TK_EP1"];
	_c = _c		+ [250];
	_m = _m		+ [1];
	_t = _t		+ [20];
	_p = _p		+ [15];
	_z = _z		+ [0];
	
	_u = _u		+ ["UralRepair_TK_EP1"];
	_c = _c		+ [425];
	_m = _m		+ [1];
	_t = _t		+ [22];
	_p = _p		+ [15];
	_z = _z		+ [0];

	_u = _u		+ ["UralReammo_TK_EP1"];
	_c = _c		+ [450];
	_m = _m		+ [1];
	_t = _t		+ [22];
	_p = _p		+ [15];
	_z = _z		+ [1];

	_u = _u		+ ["UralRefuel_TK_EP1"];
	_c = _c		+ [400];
	_m = _m		+ [1];
	_t = _t		+ [22];
	_p = _p		+ [15];
	_z = _z		+ [1];

	if (('WFBE_SUPPLYSYSTEM' Call GetNamespace) == 0) then {
		_u = _u		+ ["UralSupply_TK_EP1"];
		_c = _c		+ [450];
		_m = _m		+ [1];
		_t = _t		+ [22];
		_p = _p		+ [15];
		_z = _z		+ [0];
	};

	_u = _u		+ ["M113Ambul_TK_EP1"];
	_c = _c		+ [650];
	_m = _m		+ [1];
	_t = _t		+ [25];
	_p = _p		+ [0];
	_z = _z		+ [1];

	_u = _u		+ ["BRDM2_TK_EP1"];
	_c = _c		+ [900];
	_m = _m		+ [2];
	_t = _t		+ [23];
	_p = _p		+ [10];
	_z = _z		+ [1];

	_u = _u		+ ["BRDM2_ATGM_TK_EP1"];
	_c = _c		+ [1220];
	_m = _m		+ [2];
	_t = _t		+ [23];
	_p = _p		+ [10];
	_z = _z		+ [2];
	
	_u = _u		+ ["BTR60_TK_EP1"];
	_c = _c		+ [1400];
	_m = _m		+ [3];
	_t = _t		+ [25];
	_p = _p		+ [10];
	_z = _z		+ [2];

	_u = _u		+ ["Ural_ZU23_TK_EP1"];
	_c = _c		+ [1520];
	_m = _m		+ [2];
	_t = _t		+ [20];
	_p = _p		+ [12];
	_z = _z		+ [3];

	_u = _u		+ ["GRAD_TK_EP1"];
	_c = _c		+ [3100];
	_m = _m		+ [2];
	_t = _t		+ [25];
	_p = _p		+ [19];
	_z = _z		+ [3];
};

if (WF_A2_CombinedOps) then {
	_u = _u		+ ["TT650_TK_EP1"];
	_c = _c		+ [150];
	_m = _m		+ [1];
	_t = _t		+ [15];
	_p = _p		+ [10];
	_z = _z		+ [0];

	_u = _u		+ ["UAZ_Unarmed_TK_EP1"];
	_c = _c		+ [200];
	_m = _m		+ [1];
	_t = _t		+ [15];
	_p = _p		+ [10];
	_z = _z		+ [0];

	_u = _u		+ ["SUV_TK_EP1"];
	_c = _c		+ [300];
	_m = _m		+ [1];
	_t = _t		+ [15];
	_p = _p		+ [10];
	_z = _z		+ [0];

	_u = _u		+ ["UAZ_MG_TK_EP1"];
	_c = _c		+ [360];
	_m = _m		+ [2];
	_t = _t		+ [15];
	_p = _p		+ [15];
	_z = _z		+ [0];

	_u = _u		+ ["UAZ_AGS30_TK_EP1"];
	_c = _c		+ [425];
	_m = _m		+ [2];
	_t = _t		+ [15];
	_p = _p		+ [15];
	_z = _z		+ [1];

	_u = _u		+ ["LandRover_MG_TK_EP1"];
	_c = _c		+ [500];
	_m = _m		+ [2];
	_t = _t		+ [15];
	_p = _p		+ [15];
	_z = _z		+ [0];
	
	_u = _u		+ ["LandRover_SPG9_TK_EP1"];
	_c = _c		+ [750];
	_m = _m		+ [2];
	_t = _t		+ [17];
	_p = _p		+ [15];
	_z = _z		+ [2];

	_u = _u		+ ["V3S_TK_EP1"];
	_c = _c		+ [250];
	_m = _m		+ [1];
	_t = _t		+ [20];
	_p = _p		+ [15];
	_z = _z		+ [0];
	
	_u = _u		+ ["V3S_Open_TK_EP1"];
	_c = _c		+ [250];
	_m = _m		+ [1];
	_t = _t		+ [20];
	_p = _p		+ [15];
	_z = _z		+ [0];
	
	_u = _u		+ ["UralRepair_TK_EP1"];
	_c = _c		+ [425];
	_m = _m		+ [1];
	_t = _t		+ [22];
	_p = _p		+ [15];
	_z = _z		+ [0];

	_u = _u		+ ["UralReammo_TK_EP1"];
	_c = _c		+ [450];
	_m = _m		+ [1];
	_t = _t		+ [22];
	_p = _p		+ [15];
	_z = _z		+ [1];

	_u = _u		+ ["UralRefuel_TK_EP1"];
	_c = _c		+ [400];
	_m = _m		+ [1];
	_t = _t		+ [22];
	_p = _p		+ [15];
	_z = _z		+ [1];

	if (('WFBE_SUPPLYSYSTEM' Call GetNamespace) == 0) then {
		_u = _u		+ ["UralSupply_TK_EP1"];
		_c = _c		+ [450];
		_m = _m		+ [1];
		_t = _t		+ [22];
		_p = _p		+ [15];
		_z = _z		+ [0];
	};

	_u = _u		+ ["GAZ_Vodnik_MedEvac"];
	_c = _c		+ [550];
	_m = _m		+ [1];
	_t = _t		+ [25];
	_p = _p		+ [0];
	_z = _z		+ [1];

	_u = _u		+ ["M113Ambul_TK_EP1"];
	_c = _c		+ [650];
	_m = _m		+ [1];
	_t = _t		+ [25];
	_p = _p		+ [0];
	_z = _z		+ [2];

	_u = _u		+ ["GAZ_Vodnik"];
	_c = _c		+ [750];
	_m = _m		+ [2];
	_t = _t		+ [23];
	_p = _p		+ [10];
	_z = _z		+ [1];

	_u = _u		+ ["BRDM2_TK_EP1"];
	_c = _c		+ [900];
	_m = _m		+ [2];
	_t = _t		+ [23];
	_p = _p		+ [10];
	_z = _z		+ [1];

	_u = _u		+ ["BRDM2_ATGM_TK_EP1"];
	_c = _c		+ [1250];
	_m = _m		+ [2];
	_t = _t		+ [23];
	_p = _p		+ [10];
	_z = _z		+ [2];
		
	_u = _u		+ ["BTR60_TK_EP1"];
	_c = _c		+ [1250];
	_m = _m		+ [3];
	_t = _t		+ [25];
	_p = _p		+ [10];
	_z = _z		+ [2];

	_u = _u		+ ["GAZ_Vodnik_HMG"];
	_c = _c		+ [1500];
	_m = _m		+ [2];
	_t = _t		+ [24];
	_p = _p		+ [11];
	_z = _z		+ [2];

	_u = _u		+ ["Ural_ZU23_TK_EP1"];
	_c = _c		+ [1500];
	_m = _m		+ [2];
	_t = _t		+ [20];
	_p = _p		+ [12];
	_z = _z		+ [2];

	_u = _u		+ ["BTR90"];
	_c = _c		+ [1950];
	_m = _m		+ [3];
	_t = _t		+ [25];
	_p = _p		+ [19];
	_z = _z		+ [3];

	_u = _u		+ ["GRAD_TK_EP1"];
	_c = _c		+ [3000];
	_m = _m		+ [2];
	_t = _t		+ [25];
	_p = _p		+ [19];
	_z = _z		+ [2];
};

_eastLightDescriptions = [];
_eastLightImages = [];
_eastLightMannedCosts = [];

_total = Count _u;
_done = [];
for [{_count = 0},{_count < _total},{_count = _count + 1}] do {
	if !((_u select _count) in _done) then {
		_config = configFile >> "CfgVehicles" >> (_u Select _count);
		_eastLightMannedCosts = _eastLightMannedCosts + [(_c Select _count) + (_m Select _count) * _soldierCost];
		_eastLightDescriptions = _eastLightDescriptions + [GetText (_config >> "displayName")];
		_eastLightImages = _eastLightImages + [GetText (_config >> "picture")];
		_done = _done + [_u select _count];
	};
};

['WFBE_EASTLIGHTUNITS',_u,true] Call SetNamespace;
['WFBE_EASTLIGHTCOSTS',_c,true] Call SetNamespace;
['WFBE_EASTLIGHTCREWS',_m,true] Call SetNamespace;
['WFBE_EASTLIGHTTIMES',_t,true] Call SetNamespace;
['WFBE_EASTLIGHTPOINTS',_p,true] Call SetNamespace;
['WFBE_EASTLIGHTUPGRADES',_z,true] Call SetNamespace;
['WFBE_EASTLIGHTDESCRIPTIONS',_eastLightDescriptions,true] Call SetNamespace;
['WFBE_EASTLIGHTIMAGES',_eastLightImages,true] Call SetNamespace;
['WFBE_EASTLIGHTMANNEDCOSTS',_eastLightMannedCosts,true] Call SetNamespace;

_u = [];
_c = [];
_m = [];
_t = [];
_p = [];

//RESISTANCE
if (WF_A2_Vanilla || WF_A2_CombinedOps) then {
	_u = _u		+ ["TT650_Gue"];
	_c = _c		+ [100];
	_m = _m		+ [1];
	_t = _t		+ [9];
	_p = _p		+ [10];

	_u = _u		+ ["V3S_Gue"];
	_c = _c		+ [150];
	_m = _m		+ [2];
	_t = _t		+ [13];
	_p = _p		+ [12];

	_u = _u		+ ["Pickup_PK_GUE"];
	_c = _c		+ [200];
	_m = _m		+ [2];
	_t = _t		+ [14];
	_p = _p		+ [14];

	_u = _u		+ ["Offroad_DSHKM_Gue"];
	_c = _c		+ [275];
	_m = _m		+ [2];
	_t = _t		+ [15];
	_p = _p		+ [15];

	_u = _u		+ ["Offroad_SPG9_Gue"];
	_c = _c		+ [350];
	_m = _m		+ [2];
	_t = _t		+ [17];
	_p = _p		+ [16];

	_u = _u		+ ["BRDM2_Gue"];
	_c = _c		+ [450];
	_m = _m		+ [2];
	_t = _t		+ [19];
	_p = _p		+ [20];
	
	_u = _u		+ ["Ural_ZU23_Gue"];
	_c = _c		+ [800];
	_m = _m		+ [2];
	_t = _t		+ [19];
	_p = _p		+ [20];
};

if (WF_A2_Arrowhead || WF_A2_CombinedOps) then {
	_u = _u		+ ["V3S_TK_GUE_EP1"];
	_c = _c		+ [150];
	_m = _m		+ [2];
	_t = _t		+ [13];
	_p = _p		+ [12];

	_u = _u		+ ["Pickup_PK_TK_GUE_EP1"];
	_c = _c		+ [200];
	_m = _m		+ [2];
	_t = _t		+ [14];
	_p = _p		+ [14];

	_u = _u		+ ["Offroad_DSHKM_TK_GUE_EP1"];
	_c = _c		+ [275];
	_m = _m		+ [2];
	_t = _t		+ [15];
	_p = _p		+ [15];

	_u = _u		+ ["Offroad_SPG9_TK_GUE_EP1"];
	_c = _c		+ [350];
	_m = _m		+ [2];
	_t = _t		+ [17];
	_p = _p		+ [16];

	_u = _u		+ ["BRDM2_TK_GUE_EP1"];
	_c = _c		+ [450];
	_m = _m		+ [2];
	_t = _t		+ [19];
	_p = _p		+ [20];
	
	_u = _u		+ ["BTR40_TK_GUE_EP1"];
	_c = _c		+ [1000];
	_m = _m		+ [3];
	_t = _t		+ [19];
	_p = _p		+ [20];	
	
	_u = _u		+ ["BTR40_MG_TK_GUE_EP1"];
	_c = _c		+ [1200];
	_m = _m		+ [3];
	_t = _t		+ [19];
	_p = _p		+ [20];	
	
	_u = _u		+ ["Ural_ZU23_TK_GUE_EP1"];
	_c = _c		+ [800];
	_m = _m		+ [2];
	_t = _t		+ [19];
	_p = _p		+ [20];
};

_resistanceLightDescriptions = [];
_resistanceLightImages = [];
_resistanceLightMannedCosts = [];

_total = Count _u;
_done = [];
for [{_count = 0},{_count < _total},{_count = _count + 1}] do {
	if !((_u select _count) in _done) then {
		_config = configFile >> "CfgVehicles" >> (_u Select _count);
		_resistanceLightMannedCosts = _resistanceLightMannedCosts + [(_c Select _count) + (_m Select _count) * _soldierCost];
		_resistanceLightDescriptions = _resistanceLightDescriptions + [GetText (_config >> "displayName")];
		_resistanceLightImages = _resistanceLightImages + [GetText (_config >> "picture")];
		_done = _done + [_u select _count];
	};
};

['WFBE_GUERLIGHTUNITS',_u,true] Call SetNamespace;
['WFBE_GUERLIGHTCOSTS',_c,true] Call SetNamespace;
['WFBE_GUERLIGHTCREWS',_m,true] Call SetNamespace;
['WFBE_GUERLIGHTTIMES',_t,true] Call SetNamespace;
['WFBE_GUERLIGHTPOINTS',_p,true] Call SetNamespace;
['WFBE_GUERLIGHTDESCRIPTIONS',_resistanceLightDescriptions,true] Call SetNamespace;
['WFBE_GUERLIGHTIMAGES',_resistanceLightImages,true] Call SetNamespace;
['WFBE_GUERLIGHTMANNEDCOSTS',_resistanceLightMannedCosts,true] Call SetNamespace;

//SPECIAL VEHICLES - If these classes are changed above they must be updated here too.
if (WF_A2_Vanilla) then {
	['WFBE_WESTREPAIRTRUCK','MtvrRepair',true] Call SetNamespace;
	['WFBE_WESTSUPPLYTRUCK','WarfareSupplyTruck_USMC',true] Call SetNamespace;
	['WFBE_WESTAMBULANCES',['HMMWV_Ambulance'],true] Call SetNamespace;

	['WFBE_EASTREPAIRTRUCK','KamazRepair',true] Call SetNamespace;
	['WFBE_EASTSUPPLYTRUCK','WarfareSupplyTruck_RU',true] Call SetNamespace;
	['WFBE_EASTAMBULANCES',['GAZ_Vodnik_MedEvac'],true] Call SetNamespace;
};

if (WF_A2_Arrowhead) then {
	['WFBE_WESTREPAIRTRUCK','MtvrRepair_DES_EP1',true] Call SetNamespace;
	['WFBE_WESTSUPPLYTRUCK','MtvrSupply_DES_EP1',true] Call SetNamespace;
	['WFBE_WESTAMBULANCES',['HMMWV_Ambulance_DES_EP1','M1133_MEV_EP1'],true] Call SetNamespace;

	['WFBE_EASTREPAIRTRUCK','UralRepair_TK_EP1',true] Call SetNamespace;
	['WFBE_EASTSUPPLYTRUCK','UralSupply_TK_EP1',true] Call SetNamespace;
	['WFBE_EASTAMBULANCES',['M113Ambul_TK_EP1'],true] Call SetNamespace;
};

if (WF_A2_CombinedOps) then {
	['WFBE_WESTREPAIRTRUCK','MtvrRepair_DES_EP1',true] Call SetNamespace;
	['WFBE_WESTSUPPLYTRUCK','MtvrSupply_DES_EP1',true] Call SetNamespace;
	['WFBE_WESTAMBULANCES',['HMMWV_Ambulance','HMMWV_Ambulance_DES_EP1','M1133_MEV_EP1','UH60M_MEV_EP1'],true] Call SetNamespace;

	['WFBE_EASTREPAIRTRUCK','UralRepair_TK_EP1',true] Call SetNamespace;
	['WFBE_EASTSUPPLYTRUCK','UralSupply_TK_EP1',true] Call SetNamespace;
	['WFBE_EASTAMBULANCES',['M113Ambul_TK_EP1','GAZ_Vodnik_MedEvac','Mi17_medevac_RU'],true] Call SetNamespace;
};

['WFBE_LIGHTUNITS',('WFBE_WESTLIGHTUNITS' Call GetNamespace) + ('WFBE_EASTLIGHTUNITS' Call GetNamespace) + ('WFBE_GUERLIGHTUNITS' Call GetNamespace) + ('WFBE_WESTALLIESLIGHTUNITS' Call GetNamespace) + ('WFBE_EASTALLIESLIGHTUNITS' Call GetNamespace),true] Call SetNamespace;
['WFBE_LIGHTUNITCOSTS',('WFBE_WESTLIGHTCOSTS' Call GetNamespace) + ('WFBE_EASTLIGHTCOSTS' Call GetNamespace) + ('WFBE_GUERLIGHTCOSTS' Call GetNamespace) + ('WFBE_WESTALLIESLIGHTCOSTS' Call GetNamespace) + ('WFBE_EASTALLIESLIGHTCOSTS' Call GetNamespace),true] Call SetNamespace;
['WFBE_LIGHTUNITDESCRIPTIONS',('WFBE_WESTLIGHTDESCRIPTIONS' Call GetNamespace) + ('WFBE_EASTLIGHTDESCRIPTIONS' Call GetNamespace) + ('WFBE_GUERLIGHTDESCRIPTIONS' Call GetNamespace) + ('WFBE_WESTALLIESLIGHTDESCRIPTIONS' Call GetNamespace) + ('WFBE_EASTALLIESLIGHTDESCRIPTIONS' Call GetNamespace),true] Call SetNamespace;

_longestLightBuildTime = 0;
_t = ('WFBE_EASTLIGHTTIMES' Call GetNamespace) + ('WFBE_WESTLIGHTTIMES' Call GetNamespace) + ('WFBE_GUERLIGHTTIMES' Call GetNamespace);
for [{_count = Count _t - 1},{_count >= 0},{_count = _count - 1}] do {
	if (_t Select _count > _longestLightBuildTime) then {
		_longestLightBuildTime = _t Select _count;
	};
};

['WFBE_LONGESTLIGHTBUILDTIME',_longestLightBuildTime,true] Call SetNamespace;