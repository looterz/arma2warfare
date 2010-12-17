/*
	_v - variable name
	_n - building classname
	_d - description (translated).
	_c - cost (in supplies), for stationary defenses cost is in money.
	_t - time to build
	_i - Image on construction menu.
	_s - script executed to build
	_dir - direction from structure to place a unit created by it.
	_dis - distance from structure to place a unit created by it.
*/

if (WF_A2_Vanilla) then {
	/* WEST STRUCTURES */
	WESTHQ = "LAV25_HQ_unfolded";
	WESTBAR = "USMC_WarfareBBarracks";
	WESTLVF = "USMC_WarfareBLightFactory";
	WESTCC = "USMC_WarfareBUAVterminal";
	WESTHEAVY = "USMC_WarfareBHeavyFactory";
	WESTAIR = "USMC_WarfareBAircraftFactory";
	WESTSP = "USMC_WarfareBVehicleServicePoint";
	WESTAAR = "USMC_WarfareBAntiAirRadar";
	
	['WFBE_WESTFLAG','\Ca\Data\flag_usa_co.paa',true] Call SetNamespace;
	['WFBE_WESTFARP','Camp',true] Call SetNamespace;
	
	WFDEPOT = ["WarfareBDepot"];
	WFCAMP = ["WarfareBCamp"];
	WFHANGAR = ["WarfareBAirport"];
	WFFLAG = "FlagCarrierINS";

	_v			= ["Headquarters"];
	_n			= [WESTHQ];
	_d			= [getText (configFile >> "CfgVehicles" >> (_n select (count _n - 1)) >> "displayName")];
	_c			= [('WFBE_HQDEPLOYPRICE' Call GetNamespace)];
	_t			= [if (WF_Debug) then {1} else {30}];
	_i			= ["\CA\Warfare2\Images\con_hq.paa"];
	_s			= ["HQSite"];
	_dis		= [15];
	_dir		= [0];
	_h			= [3];

	_v = _v		+ ["Barracks"];
	_n = _n		+ [WESTBAR];
	_d = _d		+ [getText (configFile >> "CfgVehicles" >> (_n select (count _n - 1)) >> "displayName")];
	_c = _c		+ [200];
	_t = _t		+ [if (WF_Debug) then {1} else {70}];
	_i = _i		+ ["\CA\Warfare2\Images\con_barracks.paa"];
	_s = _s		+ ["SmallSite"];
	_dis = _dis	+ [18];
	_dir = _dir	+ [90];
	_h = _h		+ [3];

	_v = _v		+ ["Light"];
	_n = _n		+ [WESTLVF];
	_d = _d		+ [getText (configFile >> "CfgVehicles" >> (_n select (count _n - 1)) >> "displayName")];
	_c = _c		+ [600];
	_t = _t		+ [if (WF_Debug) then {1} else {90}];
	_i = _i		+ ["\CA\Warfare2\Images\con_light.paa"];
	_s = _s		+ ["MediumSite"];
	_dis = _dis	+ [20];
	_dir = _dir	+ [90];
	_h = _h		+ [4.5];

	_v = _v		+ ["CommandCenter"];
	_n = _n		+ [WESTCC];
	_d = _d		+ [localize "STR_WF_CommandCenter_USMC"];
	_c = _c		+ [1200];
	_t = _t		+ [if (WF_Debug) then {1} else {110}];
	_i = _i		+ ["\CA\Warfare2\Images\con_hq.paa"];
	_s = _s		+ ["SmallSite"];
	_dis = _dis	+ [20];
	_dir = _dir	+ [90];
	_h = _h		+ [4.5];

	_v = _v		+ ["Heavy"];
	_n = _n		+ [WESTHEAVY];
	_d = _d		+ [getText (configFile >> "CfgVehicles" >> (_n select (count _n - 1)) >> "displayName")];
	_c = _c		+ [2800];
	_t = _t		+ [if (WF_Debug) then {1} else {130}];
	_i = _i		+ ["\CA\Warfare2\Images\con_heavy.paa"];
	_s = _s		+ ["MediumSite"];
	_dis = _dis	+ [20];
	_dir = _dir	+ [90];
	_h = _h		+ [4];

	_v = _v		+ ["Aircraft"];
	_n = _n		+ [WESTAIR];
	_d = _d		+ [getText (configFile >> "CfgVehicles" >> (_n select (count _n - 1)) >> "displayName")];
	_c = _c		+ [4400];
	_t = _t		+ [if (WF_Debug) then {1} else {150}];
	_i = _i		+ ["\CA\Warfare2\Images\con_aircraft.paa"];
	_s = _s		+ ["SmallSite"];
	_dis = _dis	+ [31];
	_dir = _dir	+ [90];
	_h = _h		+ [5.5];

	_v = _v		+ ["ServicePoint"];
	_n = _n		+ [WESTSP];
	_d = _d		+ [getText (configFile >> "CfgVehicles" >> (_n select (count _n - 1)) >> "displayName")];
	_c = _c		+ [700];
	_t = _t		+ [if (WF_Debug) then {1} else {70}];
	_i = _i		+ ["\CA\Warfare2\Images\con_light.paa"];
	_s = _s		+ ["SmallSite"];
	_dis = _dis	+ [21];
	_dir = _dir	+ [90];
	_h = _h		+ [5.5];

	if (paramAARadar) then {
		_v = _v		+ ["AARadar"];
		_n = _n		+ [WESTAAR];
		_d = _d		+ [getText (configFile >> "CfgVehicles" >> (_n select (count _n - 1)) >> "displayName")];
		_c = _c		+ [3200];
		_t = _t		+ [if (WF_Debug) then {1} else {280}];
		_i = _i		+ ["\CA\Warfare2\Images\con_light.paa"];
		_s = _s		+ ["MediumSite"];
		_dis = _dis	+ [21];
		_dir = _dir	+ [90];
		_h = _h		+ [5.5];
	};

	for [{_count = count _v - 1},{_count >= 0},{_count = _count - 1}] do {
		[Format["WFBE_WEST%1TYPE",_v select _count],_count,true] Call SetNamespace;
	};

	['WFBE_WESTMHQNAME','LAV25_HQ',true] Call SetNamespace;

	['WFBE_WESTSTRUCTURES',_v,true] Call SetNamespace;
	['WFBE_WESTSTRUCTURENAMES',_n,true] Call SetNamespace;
	['WFBE_WESTSTRUCTUREDESCRIPTIONS',_d,true] Call SetNamespace;
	['WFBE_WESTSTRUCTURECOSTS',_c,true] Call SetNamespace;
	['WFBE_WESTSTRUCTURETIMES',_t,true] Call SetNamespace;
	['WFBE_WESTSTRUCTUREIMAGES',_i,true] Call SetNamespace;
	['WFBE_WESTSTRUCTUREDISTANCES',_dis,true] Call SetNamespace;
	['WFBE_WESTSTRUCTUREDIRECTIONS',_dir,true] Call SetNamespace;
	['WFBE_WESTSTRUCTURESCRIPTS',_s,true] Call SetNamespace;
	['WFBE_WESTSTRUCTUREHEIGHTS',_h,true] Call SetNamespace;

	/* WEST STATIONARY DEFENSES */
	_n			= ["USMC_WarfareBMGNest_M240"];
	_n = _n		+ ["M2HD_mini_TriPod"];	
	_n = _n		+ ["M2StaticMG"];
	_n = _n		+ ["SearchLight"];
	_n = _n		+ ["MK19_TriPod"];
	_n = _n		+ ["TOW_TriPod"];
	_n = _n		+ ["Stinger_Pod"];
	_n = _n		+ ["M252"];
	_n = _n		+ ["M119"];
	_n = _n		+ ["Land_HBarrier3"];
	_n = _n		+ ["Land_HBarrier5"];
	_n = _n		+ ["Land_HBarrier_large"];
	_n = _n		+ ["Base_WarfareBBarrier5x"];
	_n = _n		+ ["Base_WarfareBBarrier10x"];
	_n = _n		+ ["Base_WarfareBBarrier10xTall"];
	_n = _n		+ ["MASH"];
	_n = _n		+ ["Land_fort_bagfence_long"];
	_n = _n		+ ["Land_fort_bagfence_corner"];
	_n = _n		+ ["Land_fort_bagfence_round"];
	_n = _n		+ ["Land_fortified_nest_small"];
	_n = _n		+ ["Land_fortified_nest_big"];
	_n = _n		+ ["Land_Fort_Watchtower"];
	_n = _n		+ ["Land_fort_rampart"];
	_n = _n		+ ["Land_fort_artillery_nest"];
	_n = _n		+ ["Hhedgehog_concreteBig"];
	_n = _n		+ ["Hedgehog"];
	_n = _n		+ ["Land_CamoNet_NATO"];
	_n = _n		+ ["Land_CamoNetVar_NATO"];
	_n = _n		+ ["Land_CamoNetB_NATO"];
	_n = _n		+ ["Sign_Danger"];
	_n = _n		+ ["HeliH"];
	_n = _n		+ ["Land_Campfire"];
	_n = _n		+ ["USOrdnanceBox"];
	_n = _n		+ ["USVehicleBox"];
	_n = _n		+ ["USBasicAmmunitionBox"];
	_n = _n		+ ["USBasicWeaponsBox"];
	_n = _n		+ ["USLaunchersBox"];
	_n = _n		+ ["USSpecialWeaponsBox"];

	['WFBE_WESTDEFENSENAMES',_n,true] Call SetNamespace;

	/* EAST STRUCTURES */
	EASTHQ = "BTR90_HQ_unfolded";
	EASTBAR = "RU_WarfareBBarracks";
	EASTLVF = "RU_WarfareBLightFactory";
	EASTCC = "RU_WarfareBUAVterminal";
	EASTHEAVY = "RU_WarfareBHeavyFactory";
	EASTAIR = "RU_WarfareBAircraftFactory";
	EASTSP = "RU_WarfareBVehicleServicePoint";
	EASTAAR = "RU_WarfareBAntiAirRadar";
	
	['WFBE_EASTFLAG','\Ca\Data\flag_rus_co.paa',true] Call SetNamespace;
	['WFBE_EASTFARP','CampEast',true] Call SetNamespace;
	
	_v			= ["Headquarters"];
	_n			= [EASTHQ];
	_d			= [getText (configFile >> "CfgVehicles" >> (_n select (count _n - 1)) >> "displayName")];
	_c			= [('WFBE_HQDEPLOYPRICE' Call GetNamespace)];
	_t			= [if (WF_Debug) then {1} else {30}];
	_i			= ["\CA\Warfare2\Images\con_hq.paa"];
	_s			= ["HQSite"];
	_dis		= [15];
	_dir		= [0];
	_h			= [3];

	_v = _v		+ ["Barracks"];
	_n = _n		+ [EASTBAR];
	_d = _d		+ [getText (configFile >> "CfgVehicles" >> (_n select (count _n - 1)) >> "displayName")];
	_c = _c		+ [200];
	_t = _t		+ [if (WF_Debug) then {1} else {70}];
	_i = _i		+ ["\CA\Warfare2\Images\con_barracks.paa"];
	_s = _s		+ ["SmallSite"];
	_dis = _dis	+ [18];
	_dir = _dir	+ [90];
	_h = _h		+ [3];

	_v = _v		+ ["Light"];
	_n = _n		+ [EASTLVF];
	_d = _d		+ [getText (configFile >> "CfgVehicles" >> (_n select (count _n - 1)) >> "displayName")];
	_c = _c		+ [600];
	_t = _t		+ [if (WF_Debug) then {1} else {90}];
	_i = _i		+ ["\CA\Warfare2\Images\con_light.paa"];
	_s = _s		+ ["MediumSite"];
	_dis = _dis	+ [20];
	_dir = _dir	+ [90];
	_h = _h		+ [4.5];

	_v = _v		+ ["CommandCenter"];
	_n = _n		+ [EASTCC];
	_d = _d		+ [localize "STR_WF_CommandCenter_RU"];
	_c = _c		+ [1200];
	_t = _t		+ [if (WF_Debug) then {1} else {110}];
	_i = _i		+ ["\CA\Warfare2\Images\con_hq.paa"];
	_s = _s		+ ["SmallSite"];

	_dis = _dis	+ [20];
	_dir = _dir	+ [90];
	_h = _h		+ [4.5];

	_v = _v		+ ["Heavy"];
	_n = _n		+ [EASTHEAVY];
	_d = _d		+ [getText (configFile >> "CfgVehicles" >> (_n select (count _n - 1)) >> "displayName")];
	_c = _c		+ [2800];
	_t = _t		+ [if (WF_Debug) then {1} else {130}];
	_i = _i		+ ["\CA\Warfare2\Images\con_heavy.paa"];
	_s = _s		+ ["MediumSite"];
	_dis = _dis	+ [20];
	_dir = _dir	+ [90];
	_h = _h		+ [4];

	_v = _v		+ ["Aircraft"];
	_n = _n		+ [EASTAIR];
	_d = _d		+ [getText (configFile >> "CfgVehicles" >> (_n select (count _n - 1)) >> "displayName")];
	_c = _c		+ [4400];
	_t = _t		+ [if (WF_Debug) then {1} else {150}];
	_i = _i		+ ["\CA\Warfare2\Images\con_aircraft.paa"];
	_s = _s		+ ["SmallSite"];
	_dis = _dis	+ [21];
	_dir = _dir	+ [90];
	_h = _h		+ [5.5];

	_v = _v		+ ["ServicePoint"];
	_n = _n		+ [EASTSP];
	_d = _d		+ [getText (configFile >> "CfgVehicles" >> (_n select (count _n - 1)) >> "displayName")];
	_c = _c		+ [700];
	_t = _t		+ [if (WF_Debug) then {1} else {70}];
	_i = _i		+ ["\CA\Warfare2\Images\con_light.paa"];
	_s = _s		+ ["SmallSite"];
	_dis = _dis	+ [21];
	_dir = _dir	+ [90];
	_h = _h		+ [5.5];

	if (paramAARadar) then {
		_v = _v		+ ["AARadar"];
		_n = _n		+ [EASTAAR];
		_d = _d		+ [getText (configFile >> "CfgVehicles" >> (_n select (count _n - 1)) >> "displayName")];
		_c = _c		+ [3200];
		_t = _t		+ [if (WF_Debug) then {1} else {280}];
		_i = _i		+ ["\CA\Warfare2\Images\con_light.paa"];
		_s = _s		+ ["MediumSite"];
		_dis = _dis	+ [21];
		_dir = _dir	+ [90];
		_h = _h		+ [5.5];
	};

	for [{_count = count _v - 1},{_count >= 0},{_count = _count - 1}] do {
		[Format["WFBE_EAST%1TYPE",_v select _count],_count,true] Call SetNamespace;
	};

	['WFBE_EASTMHQNAME','BTR90_HQ',true] Call SetNamespace;
	
	['WFBE_EASTSTRUCTURES',_v,true] Call SetNamespace;
	['WFBE_EASTSTRUCTURENAMES',_n,true] Call SetNamespace;
	['WFBE_EASTSTRUCTUREDESCRIPTIONS',_d,true] Call SetNamespace;
	['WFBE_EASTSTRUCTURECOSTS',_c,true] Call SetNamespace;
	['WFBE_EASTSTRUCTURETIMES',_t,true] Call SetNamespace;
	['WFBE_EASTSTRUCTUREIMAGES',_i,true] Call SetNamespace;
	['WFBE_EASTSTRUCTUREDISTANCES',_dis,true] Call SetNamespace;
	['WFBE_EASTSTRUCTUREDIRECTIONS',_dir,true] Call SetNamespace;
	['WFBE_EASTSTRUCTURESCRIPTS',_s,true] Call SetNamespace;
	['WFBE_EASTSTRUCTUREHEIGHTS',_h,true] Call SetNamespace;

	/* EAST STATIONARY DEFENSES */
	_n			= ["RU_WarfareBMGNest_PK"];
	_n = _n		+ ["SearchLight_RUS"];
	_n = _n		+ ["KORD"];
	_n = _n		+ ["KORD_high"];
	_n = _n		+ ["AGS_RU"];
	_n = _n		+ ["SPG9_Ins"];
	_n = _n		+ ["Metis"];
	_n = _n		+ ["Igla_AA_pod_East"];
	_n = _n		+ ["ZU23_Ins"];
	_n = _n		+ ["2b14_82mm"];
	_n = _n		+ ["D30_RU"];
	_n = _n		+ ["Land_HBarrier3"];
	_n = _n		+ ["Land_HBarrier5"];
	_n = _n		+ ["Land_HBarrier_large"];
	_n = _n		+ ["Base_WarfareBBarrier5x"];
	_n = _n		+ ["Base_WarfareBBarrier10x"];
	_n = _n		+ ["Base_WarfareBBarrier10xTall"];
	_n = _n		+ ["MASH"];
	_n = _n		+ ["Land_fort_bagfence_long"];
	_n = _n		+ ["Land_fort_bagfence_corner"];
	_n = _n		+ ["Land_fort_bagfence_round"];
	_n = _n		+ ["Land_fortified_nest_small"];
	_n = _n		+ ["Land_fortified_nest_big"];
	_n = _n		+ ["Land_Fort_Watchtower"];
	_n = _n		+ ["Land_fort_rampart"];
	_n = _n		+ ["Land_fort_artillery_nest"];
	_n = _n		+ ["Hhedgehog_concreteBig"];
	_n = _n		+ ["Hedgehog"];
	_n = _n		+ ["Land_CamoNet_EAST"];
	_n = _n		+ ["Land_CamoNetVar_EAST"];
	_n = _n		+ ["Land_CamoNetB_EAST"];
	_n = _n		+ ["Sign_Danger"];
	_n = _n		+ ["HeliH"];
	_n = _n		+ ["Land_Campfire"];
	_n = _n		+ ["RUOrdnanceBox"];
	_n = _n		+ ["RUVehicleBox"];
	_n = _n		+ ["RUBasicAmmunitionBox"];
	_n = _n		+ ["RUBasicWeaponsBox"];
	_n = _n		+ ["RULaunchersBox"];
	_n = _n		+ ["RUSpecialWeaponsBox"];

	['WFBE_EASTDEFENSENAMES',_n,true] Call SetNamespace;
	
	['WFBE_WESTCONSTRUCTIONSITE','USMC_WarfareBContructionSite',true] Call SetNamespace;
	['WFBE_EASTCONSTRUCTIONSITE','RU_WarfareBContructionSite',true] Call SetNamespace;
	
	/* RESISTANCE STATIONARY DEFENSES */
	_n			= ["GUE_WarfareBMGNest_PK"];
	_n = _n		+ ["ZU23_Gue"];

	['WFBE_RESISTANCEDEFENSENAMES',_n,true] Call SetNamespace;
};

if (WF_A2_Arrowhead) then {
	/* WEST STRUCTURES */
	WESTHQ = "M1130_HQ_unfolded_EP1";
	WESTBAR = "US_WarfareBBarracks_EP1";
	WESTLVF = "US_WarfareBLightFactory_EP1";
	WESTCC = "US_WarfareBUAVterminal_EP1";
	WESTHEAVY = "US_WarfareBHeavyFactory_EP1";
	WESTAIR = "US_WarfareBAircraftFactory_EP1";
	WESTSP = "US_WarfareBVehicleServicePoint_EP1";
	WESTAAR = "US_WarfareBAntiAirRadar_EP1";
	
	['WFBE_WESTFLAG','\Ca\ca_e\Data\flag_us_co.paa',true] Call SetNamespace;
	['WFBE_WESTFARP','Camp_EP1',true] Call SetNamespace;
	
	WFDEPOT = ["Land_fortified_nest_big_EP1"];
	WFCAMP = ["Land_Fort_Watchtower_EP1"];
	WFHANGAR = ["Land_Mil_hangar_EP1"];
	WFFLAG = "FlagCarrierTakistan_EP1";

	_v			= ["Headquarters"];
	_n			= [WESTHQ];
	_d			= [getText (configFile >> "CfgVehicles" >> (_n select (count _n - 1)) >> "displayName")];
	_c			= [('WFBE_HQDEPLOYPRICE' Call GetNamespace)];
	_t			= [if (WF_Debug) then {1} else {30}];
	_i			= ["\CA\Warfare2\Images\con_hq.paa"];
	_s			= ["HQSite"];
	_dis		= [15];
	_dir		= [0];
	_h			= [3];

	_v = _v		+ ["Barracks"];
	_n = _n		+ [WESTBAR];
	_d = _d		+ [getText (configFile >> "CfgVehicles" >> (_n select (count _n - 1)) >> "displayName")];
	_c = _c		+ [200];
	_t = _t		+ [if (WF_Debug) then {1} else {70}];
	_i = _i		+ ["\CA\Warfare2\Images\con_barracks.paa"];
	_s = _s		+ ["SmallSite"];
	_dis = _dis	+ [18];
	_dir = _dir	+ [90];
	_h = _h		+ [3];

	_v = _v		+ ["Light"];
	_n = _n		+ [WESTLVF];
	_d = _d		+ [getText (configFile >> "CfgVehicles" >> (_n select (count _n - 1)) >> "displayName")];
	_c = _c		+ [600];
	_t = _t		+ [if (WF_Debug) then {1} else {90}];
	_i = _i		+ ["\CA\Warfare2\Images\con_light.paa"];
	_s = _s		+ ["MediumSite"];
	_dis = _dis	+ [20];
	_dir = _dir	+ [90];
	_h = _h		+ [4.5];

	_v = _v		+ ["CommandCenter"];
	_n = _n		+ [WESTCC];
	_d = _d		+ [localize "STR_WF_CommandCenter_USMC"];
	_c = _c		+ [1200];
	_t = _t		+ [if (WF_Debug) then {1} else {110}];
	_i = _i		+ ["\CA\Warfare2\Images\con_hq.paa"];
	_s = _s		+ ["SmallSite"];
	_dis = _dis	+ [20];
	_dir = _dir	+ [90];
	_h = _h		+ [4.5];

	_v = _v		+ ["Heavy"];
	_n = _n		+ [WESTHEAVY];
	_d = _d		+ [getText (configFile >> "CfgVehicles" >> (_n select (count _n - 1)) >> "displayName")];
	_c = _c		+ [2800];
	_t = _t		+ [if (WF_Debug) then {1} else {130}];
	_i = _i		+ ["\CA\Warfare2\Images\con_heavy.paa"];
	_s = _s		+ ["MediumSite"];
	_dis = _dis	+ [20];
	_dir = _dir	+ [90];
	_h = _h		+ [4];

	_v = _v		+ ["Aircraft"];
	_n = _n		+ [WESTAIR];
	_d = _d		+ [localize "STR_WF_AircraftFactory"];
	_c = _c		+ [4400];
	_t = _t		+ [if (WF_Debug) then {1} else {150}];
	_i = _i		+ ["\CA\Warfare2\Images\con_aircraft.paa"];
	_s = _s		+ ["SmallSite"];
	_dis = _dis	+ [31];
	_dir = _dir	+ [90];
	_h = _h		+ [5.5];

	_v = _v		+ ["ServicePoint"];
	_n = _n		+ [WESTSP];
	_d = _d		+ [localize "STR_WF_ServicePoint"];
	_c = _c		+ [700];
	_t = _t		+ [if (WF_Debug) then {1} else {70}];
	_i = _i		+ ["\CA\Warfare2\Images\con_light.paa"];
	_s = _s		+ ["SmallSite"];
	_dis = _dis	+ [21];
	_dir = _dir	+ [90];
	_h = _h		+ [5.5];

	if (paramAARadar) then {
		_v = _v		+ ["AARadar"];
		_n = _n		+ [WESTAAR];
		_d = _d		+ [getText (configFile >> "CfgVehicles" >> (_n select (count _n - 1)) >> "displayName")];
		_c = _c		+ [3200];
		_t = _t		+ [if (WF_Debug) then {1} else {280}];
		_i = _i		+ ["\CA\Warfare2\Images\con_light.paa"];
		_s = _s		+ ["MediumSite"];
		_dis = _dis	+ [21];
		_dir = _dir	+ [90];
		_h = _h		+ [5.5];
	};

	for [{_count = count _v - 1},{_count >= 0},{_count = _count - 1}] do {
		[Format["WFBE_WEST%1TYPE",_v select _count],_count,true] Call SetNamespace;
	};

	['WFBE_WESTMHQNAME','M1130_CV_EP1',true] Call SetNamespace;
	
	['WFBE_WESTSTRUCTURES',_v,true] Call SetNamespace;
	['WFBE_WESTSTRUCTURENAMES',_n,true] Call SetNamespace;
	['WFBE_WESTSTRUCTUREDESCRIPTIONS',_d,true] Call SetNamespace;
	['WFBE_WESTSTRUCTURECOSTS',_c,true] Call SetNamespace;
	['WFBE_WESTSTRUCTURETIMES',_t,true] Call SetNamespace;
	['WFBE_WESTSTRUCTUREIMAGES',_i,true] Call SetNamespace;
	['WFBE_WESTSTRUCTUREDISTANCES',_dis,true] Call SetNamespace;
	['WFBE_WESTSTRUCTUREDIRECTIONS',_dir,true] Call SetNamespace;
	['WFBE_WESTSTRUCTURESCRIPTS',_s,true] Call SetNamespace;
	['WFBE_WESTSTRUCTUREHEIGHTS',_h,true] Call SetNamespace;

	/* WEST STATIONARY DEFENSES */
	_n			= ["WarfareBMGNest_M240_US_EP1"];
	_n = _n		+ ["M2HD_mini_TriPod_US_EP1"];
	_n = _n		+ ["SearchLight_US_EP1"];
	_n = _n		+ ["M2StaticMG_US_EP1"];
	if (paramDLCBAF) then {
		_n = _n		+ ["BAF_GPMG_Minitripod_W"];
		_n = _n		+ ["BAF_GMG_Tripod_W"];
		_n = _n		+ ["BAF_L2A1_Minitripod_W"];
		_n = _n		+ ["BAF_L2A1_Tripod_W"];
	};
	_n = _n		+ ["MK19_TriPod_US_EP1"];
	_n = _n		+ ["TOW_TriPod_US_EP1"];
	_n = _n		+ ["Stinger_Pod_US_EP1"];
	_n = _n		+ ["M252_US_EP1"];
	_n = _n		+ ["M119_US_EP1"];
	_n = _n		+ ["Land_HBarrier3"];
	_n = _n		+ ["Land_HBarrier5"];
	_n = _n		+ ["Land_HBarrier_large"];
	_n = _n		+ ["US_WarfareBBarrier5x_EP1"];
	_n = _n		+ ["US_WarfareBBarrier10x_EP1"];
	_n = _n		+ ["US_WarfareBBarrier10xTall_EP1"];
	_n = _n		+ ["MASH_EP1"];
	_n = _n		+ ["Land_fort_bagfence_long"];
	_n = _n		+ ["Land_fort_bagfence_corner"];
	_n = _n		+ ["Land_fort_bagfence_round"];
	_n = _n		+ ["Land_fortified_nest_small_EP1"];
	_n = _n		+ ["Land_fort_rampart_EP1"];
	_n = _n		+ ["Land_fort_artillery_nest_EP1"];
	_n = _n		+ ["Hhedgehog_concreteBig"];
	_n = _n		+ ["Hedgehog_EP1"];
	_n = _n		+ ["Land_CamoNet_NATO_EP1"];
	_n = _n		+ ["Land_CamoNetVar_NATO_EP1"];
	_n = _n		+ ["Land_CamoNetB_NATO_EP1"];
	_n = _n		+ ["Sign_Danger"];
	_n = _n		+ ["HeliH"];
	_n = _n		+ ["Land_Campfire"];
	_n = _n		+ ["USOrdnanceBox_EP1"];
	_n = _n		+ ["USVehicleBox_EP1"];
	_n = _n		+ ["USBasicAmmunitionBox_EP1"];
	_n = _n		+ ["USBasicWeapons_EP1"];
	_n = _n		+ ["USLaunchers_EP1"];
	_n = _n		+ ["USSpecialWeapons_EP1"];

	['WFBE_WESTDEFENSENAMES',_n,true] Call SetNamespace;

	/* EAST STRUCTURES */
	EASTHQ = "BMP2_HQ_TK_unfolded_EP1";
	EASTBAR = "TK_WarfareBBarracks_EP1";
	EASTLVF = "TK_WarfareBLightFactory_EP1";
	EASTCC = "TK_WarfareBUAVterminal_EP1";
	EASTHEAVY = "TK_WarfareBHeavyFactory_EP1";
	EASTAIR = "TK_WarfareBAircraftFactory_EP1";
	EASTSP = "TK_WarfareBVehicleServicePoint_EP1";
	EASTAAR = "TK_WarfareBAntiAirRadar_EP1";

	['WFBE_EASTFLAG','\Ca\ca_e\Data\flag_tkg_co.paa',true] Call SetNamespace;
	['WFBE_EASTFARP','CampEast_EP1',true] Call SetNamespace;
	
	_v			= ["Headquarters"];
	_n			= [EASTHQ];
	_d			= [getText (configFile >> "CfgVehicles" >> (_n select (count _n - 1)) >> "displayName")];
	_c			= [('WFBE_HQDEPLOYPRICE' Call GetNamespace)];
	_t			= [if (WF_Debug) then {1} else {30}];
	_i			= ["\CA\Warfare2\Images\con_hq.paa"];
	_s			= ["HQSite"];
	_dis		= [15];
	_dir		= [0];
	_h			= [3];

	_v = _v		+ ["Barracks"];
	_n = _n		+ [EASTBAR];
	_d = _d		+ [getText (configFile >> "CfgVehicles" >> (_n select (count _n - 1)) >> "displayName")];
	_c = _c		+ [200];
	_t = _t		+ [if (WF_Debug) then {1} else {70}];
	_i = _i		+ ["\CA\Warfare2\Images\con_barracks.paa"];
	_s = _s		+ ["SmallSite"];
	_dis = _dis	+ [18];
	_dir = _dir	+ [90];
	_h = _h		+ [3];

	_v = _v		+ ["Light"];
	_n = _n		+ [EASTLVF];
	_d = _d		+ [getText (configFile >> "CfgVehicles" >> (_n select (count _n - 1)) >> "displayName")];
	_c = _c		+ [600];
	_t = _t		+ [if (WF_Debug) then {1} else {90}];
	_i = _i		+ ["\CA\Warfare2\Images\con_light.paa"];
	_s = _s		+ ["MediumSite"];
	_dis = _dis	+ [20];
	_dir = _dir	+ [90];
	_h = _h		+ [4.5];

	_v = _v		+ ["CommandCenter"];
	_n = _n		+ [EASTCC];
	_d = _d		+ [localize "STR_WF_CommandCenter_RU"];
	_c = _c		+ [1200];
	_t = _t		+ [if (WF_Debug) then {1} else {110}];
	_i = _i		+ ["\CA\Warfare2\Images\con_hq.paa"];
	_s = _s		+ ["SmallSite"];

	_dis = _dis	+ [20];
	_dir = _dir	+ [90];
	_h = _h		+ [4.5];

	_v = _v		+ ["Heavy"];
	_n = _n		+ [EASTHEAVY];
	_d = _d		+ [getText (configFile >> "CfgVehicles" >> (_n select (count _n - 1)) >> "displayName")];
	_c = _c		+ [2800];
	_t = _t		+ [if (WF_Debug) then {1} else {130}];
	_i = _i		+ ["\CA\Warfare2\Images\con_heavy.paa"];
	_s = _s		+ ["MediumSite"];
	_dis = _dis	+ [20];
	_dir = _dir	+ [90];
	_h = _h		+ [4];

	_v = _v		+ ["Aircraft"];
	_n = _n		+ [EASTAIR];
	_d = _d		+ [localize "STR_WF_AircraftFactory"];
	_c = _c		+ [4400];
	_t = _t		+ [if (WF_Debug) then {1} else {150}];
	_i = _i		+ ["\CA\Warfare2\Images\con_aircraft.paa"];
	_s = _s		+ ["SmallSite"];
	_dis = _dis	+ [21];
	_dir = _dir	+ [90];
	_h = _h		+ [5.5];

	_v = _v		+ ["ServicePoint"];
	_n = _n		+ [EASTSP];
	_d = _d		+ [localize "STR_WF_ServicePoint"];
	_c = _c		+ [700];
	_t = _t		+ [if (WF_Debug) then {1} else {70}];
	_i = _i		+ ["\CA\Warfare2\Images\con_light.paa"];
	_s = _s		+ ["SmallSite"];
	_dis = _dis	+ [21];
	_dir = _dir	+ [90];
	_h = _h		+ [5.5];

	if (paramAARadar) then {
		_v = _v		+ ["AARadar"];
		_n = _n		+ [EASTAAR];
		_d = _d		+ [getText (configFile >> "CfgVehicles" >> (_n select (count _n - 1)) >> "displayName")];
		_c = _c		+ [3200];
		_t = _t		+ [if (WF_Debug) then {1} else {280}];
		_i = _i		+ ["\CA\Warfare2\Images\con_light.paa"];
		_s = _s		+ ["MediumSite"];
		_dis = _dis	+ [21];
		_dir = _dir	+ [90];
		_h = _h		+ [5.5];
	};

	for [{_count = count _v - 1},{_count >= 0},{_count = _count - 1}] do {
		[Format["WFBE_EAST%1TYPE",_v select _count],_count,true] Call SetNamespace;
	};

	['WFBE_EASTMHQNAME','BMP2_HQ_TK_EP1',true] Call SetNamespace;
	
	['WFBE_EASTSTRUCTURES',_v,true] Call SetNamespace;
	['WFBE_EASTSTRUCTURENAMES',_n,true] Call SetNamespace;
	['WFBE_EASTSTRUCTUREDESCRIPTIONS',_d,true] Call SetNamespace;
	['WFBE_EASTSTRUCTURECOSTS',_c,true] Call SetNamespace;
	['WFBE_EASTSTRUCTURETIMES',_t,true] Call SetNamespace;
	['WFBE_EASTSTRUCTUREIMAGES',_i,true] Call SetNamespace;
	['WFBE_EASTSTRUCTUREDISTANCES',_dis,true] Call SetNamespace;
	['WFBE_EASTSTRUCTUREDIRECTIONS',_dir,true] Call SetNamespace;
	['WFBE_EASTSTRUCTURESCRIPTS',_s,true] Call SetNamespace;
	['WFBE_EASTSTRUCTUREHEIGHTS',_h,true] Call SetNamespace;

	/* EAST STATIONARY DEFENSES */
	_n			= ["WarfareBMGNest_PK_TK_EP1"];
	_n = _n		+ ["SearchLight_TK_EP1"];
	_n = _n		+ ["KORD_TK_EP1"];
	_n = _n		+ ["KORD_high_TK_EP1"];
	_n = _n		+ ["AGS_TK_EP1"];
	_n = _n		+ ["SPG9_TK_INS_EP1"];
	_n = _n		+ ["Metis_TK_EP1"];
	_n = _n		+ ["Igla_AA_pod_TK_EP1"];
	_n = _n		+ ["ZU23_TK_EP1"];
	_n = _n		+ ["2b14_82mm_TK_EP1"];
	_n = _n		+ ["D30_TK_EP1"];
	_n = _n		+ ["Land_HBarrier3"];
	_n = _n		+ ["Land_HBarrier5"];
	_n = _n		+ ["Land_HBarrier_large"];
	_n = _n		+ ["TK_WarfareBBarrier5x_EP1"];
	_n = _n		+ ["TK_WarfareBBarrier10x_EP1"];
	_n = _n		+ ["TK_WarfareBBarrier10xTall_EP1"];
	_n = _n		+ ["MASH_EP1"];
	_n = _n		+ ["Land_fort_bagfence_long"];
	_n = _n		+ ["Land_fort_bagfence_corner"];
	_n = _n		+ ["Land_fort_bagfence_round"];
	_n = _n		+ ["Land_fortified_nest_small_EP1"];
	_n = _n		+ ["Land_fort_rampart_EP1"];
	_n = _n		+ ["Land_fort_artillery_nest_EP1"];
	_n = _n		+ ["Hhedgehog_concreteBig"];
	_n = _n		+ ["Hedgehog_EP1"];
	_n = _n		+ ["Land_CamoNet_EAST_EP1"];
	_n = _n		+ ["Land_CamoNetVar_EAST_EP1"];
	_n = _n		+ ["Land_CamoNetB_EAST_EP1"];
	_n = _n		+ ["Sign_Danger"];
	_n = _n		+ ["HeliH"];
	_n = _n		+ ["Land_Campfire"];
	_n = _n		+ ["TKOrdnanceBox_EP1"];
	_n = _n		+ ["TKVehicleBox_EP1"];
	_n = _n		+ ["TKBasicAmmunitionBox_EP1"];
	_n = _n		+ ["TKBasicWeapons_EP1"];
	_n = _n		+ ["TKLaunchers_EP1"];
	_n = _n		+ ["TKSpecialWeapons_EP1"];

	['WFBE_EASTDEFENSENAMES',_n,true] Call SetNamespace;

	['WFBE_WESTCONSTRUCTIONSITE','US_WarfareBContructionSite_EP1',true] Call SetNamespace;
	['WFBE_EASTCONSTRUCTIONSITE','TK_WarfareBContructionSite_EP1',true] Call SetNamespace;

	/* RESISTANCE STATIONARY DEFENSES */
	_n			= ["WarfareBMGNest_PK_TK_GUE_EP1"];
	_n = _n		+ ["ZU23_TK_GUE_EP1"];

	['WFBE_RESISTANCEDEFENSENAMES',_n,true] Call SetNamespace;
};

if (WF_A2_CombinedOps) then {
	/* WEST STRUCTURES */
	WESTHQ = if (WF_Camo) then {"LAV25_HQ_unfolded"} else {"M1130_HQ_unfolded_EP1"};
	WESTBAR = if (WF_Camo) then {"USMC_WarfareBBarracks"} else {"US_WarfareBBarracks_EP1"};
	WESTLVF = if (WF_Camo) then {"USMC_WarfareBLightFactory"} else {"US_WarfareBLightFactory_EP1"};
	WESTCC = if (WF_Camo) then {"USMC_WarfareBUAVterminal"} else {"US_WarfareBUAVterminal_EP1"};
	WESTHEAVY = if (WF_Camo) then {"USMC_WarfareBHeavyFactory"} else {"US_WarfareBHeavyFactory_EP1"};
	WESTAIR = if (WF_Camo) then {"USMC_WarfareBAircraftFactory"} else {"US_WarfareBAircraftFactory_EP1"};
	WESTSP = if (WF_Camo) then {"USMC_WarfareBVehicleServicePoint"} else {"US_WarfareBVehicleServicePoint_EP1"};
	WESTAAR = if (WF_Camo) then {"USMC_WarfareBAntiAirRadar"} else {"US_WarfareBAntiAirRadar_EP1"};
	
	['WFBE_WESTFLAG','\Ca\ca_e\Data\flag_us_co.paa',true] Call SetNamespace;
	['WFBE_WESTFARP','Camp_EP1',true] Call SetNamespace;
	
	WFDEPOT = ["Land_fortified_nest_big_EP1","WarfareBDepot"];
	WFCAMP = ["Land_Fort_Watchtower_EP1","WarfareBCamp"];
	WFHANGAR = ["Land_Mil_hangar_EP1","WarfareBAirport"];
	WFFLAG = "FlagCarrierTakistan_EP1";

	_v			= ["Headquarters"];
	_n			= [WESTHQ];
	_d			= [getText (configFile >> "CfgVehicles" >> (_n select (count _n - 1)) >> "displayName")];
	_c			= [('WFBE_HQDEPLOYPRICE' Call GetNamespace)];
	_t			= [if (WF_Debug) then {1} else {30}];
	_i			= ["\CA\Warfare2\Images\con_hq.paa"];
	_s			= ["HQSite"];
	_dis		= [15];
	_dir		= [0];
	_h			= [3];

	_v = _v		+ ["Barracks"];
	_n = _n		+ [WESTBAR];
	_d = _d		+ [getText (configFile >> "CfgVehicles" >> (_n select (count _n - 1)) >> "displayName")];
	_c = _c		+ [200];
	_t = _t		+ [if (WF_Debug) then {1} else {70}];
	_i = _i		+ ["\CA\Warfare2\Images\con_barracks.paa"];
	_s = _s		+ ["SmallSite"];
	_dis = _dis	+ [18];
	_dir = _dir	+ [90];
	_h = _h		+ [3];

	_v = _v		+ ["Light"];
	_n = _n		+ [WESTLVF];
	_d = _d		+ [getText (configFile >> "CfgVehicles" >> (_n select (count _n - 1)) >> "displayName")];
	_c = _c		+ [600];
	_t = _t		+ [if (WF_Debug) then {1} else {90}];
	_i = _i		+ ["\CA\Warfare2\Images\con_light.paa"];
	_s = _s		+ ["MediumSite"];
	_dis = _dis	+ [20];
	_dir = _dir	+ [90];
	_h = _h		+ [4.5];

	_v = _v		+ ["CommandCenter"];
	_n = _n		+ [WESTCC];
	_d = _d		+ [localize "STR_WF_CommandCenter_USMC"];
	_c = _c		+ [1200];
	_t = _t		+ [if (WF_Debug) then {1} else {110}];
	_i = _i		+ ["\CA\Warfare2\Images\con_hq.paa"];
	_s = _s		+ ["SmallSite"];
	_dis = _dis	+ [20];
	_dir = _dir	+ [90];
	_h = _h		+ [4.5];

	_v = _v		+ ["Heavy"];
	_n = _n		+ [WESTHEAVY];
	_d = _d		+ [getText (configFile >> "CfgVehicles" >> (_n select (count _n - 1)) >> "displayName")];
	_c = _c		+ [2800];
	_t = _t		+ [if (WF_Debug) then {1} else {130}];
	_i = _i		+ ["\CA\Warfare2\Images\con_heavy.paa"];
	_s = _s		+ ["MediumSite"];
	_dis = _dis	+ [20];
	_dir = _dir	+ [90];
	_h = _h		+ [4];

	_v = _v		+ ["Aircraft"];
	_n = _n		+ [WESTAIR];
	_d = _d		+ [localize "STR_WF_AircraftFactory"];
	_c = _c		+ [4400];
	_t = _t		+ [if (WF_Debug) then {1} else {150}];
	_i = _i		+ ["\CA\Warfare2\Images\con_aircraft.paa"];
	_s = _s		+ ["SmallSite"];
	_dis = _dis	+ [31];
	_dir = _dir	+ [90];
	_h = _h		+ [5.5];

	_v = _v		+ ["ServicePoint"];
	_n = _n		+ [WESTSP];
	_d = _d		+ [localize "STR_WF_ServicePoint"];
	_c = _c		+ [700];
	_t = _t		+ [if (WF_Debug) then {1} else {70}];
	_i = _i		+ ["\CA\Warfare2\Images\con_light.paa"];
	_s = _s		+ ["SmallSite"];
	_dis = _dis	+ [21];
	_dir = _dir	+ [90];
	_h = _h		+ [5.5];

	if (paramAARadar) then {
		_v = _v		+ ["AARadar"];
		_n = _n		+ [WESTAAR];
		_d = _d		+ [getText (configFile >> "CfgVehicles" >> (_n select (count _n - 1)) >> "displayName")];
		_c = _c		+ [3200];
		_t = _t		+ [if (WF_Debug) then {1} else {280}];
		_i = _i		+ ["\CA\Warfare2\Images\con_light.paa"];
		_s = _s		+ ["MediumSite"];
		_dis = _dis	+ [21];
		_dir = _dir	+ [90];
		_h = _h		+ [5.5];
	};

	for [{_count = count _v - 1},{_count >= 0},{_count = _count - 1}] do {
		[Format["WFBE_WEST%1TYPE",_v select _count],_count,true] Call SetNamespace;
	};

	['WFBE_WESTMHQNAME',if (WF_Camo) then {'LAV25_HQ'} else {'M1130_CV_EP1'},true] Call SetNamespace;
	
	['WFBE_WESTSTRUCTURES',_v,true] Call SetNamespace;
	['WFBE_WESTSTRUCTURENAMES',_n,true] Call SetNamespace;
	['WFBE_WESTSTRUCTUREDESCRIPTIONS',_d,true] Call SetNamespace;
	['WFBE_WESTSTRUCTURECOSTS',_c,true] Call SetNamespace;
	['WFBE_WESTSTRUCTURETIMES',_t,true] Call SetNamespace;
	['WFBE_WESTSTRUCTUREIMAGES',_i,true] Call SetNamespace;
	['WFBE_WESTSTRUCTUREDISTANCES',_dis,true] Call SetNamespace;
	['WFBE_WESTSTRUCTUREDIRECTIONS',_dir,true] Call SetNamespace;
	['WFBE_WESTSTRUCTURESCRIPTS',_s,true] Call SetNamespace;
	['WFBE_WESTSTRUCTUREHEIGHTS',_h,true] Call SetNamespace;

	/* WEST STATIONARY DEFENSES */
	_n			= ["WarfareBMGNest_M240_US_EP1"];
	_n = _n		+ ["M2HD_mini_TriPod_US_EP1"];
	_n = _n		+ ["SearchLight_US_EP1"];
	_n = _n		+ ["M2StaticMG_US_EP1"];
	if (paramDLCBAF) then {
		_n = _n		+ ["BAF_GPMG_Minitripod_W"];
		_n = _n		+ ["BAF_GMG_Tripod_W"];
		_n = _n		+ ["BAF_L2A1_Minitripod_W"];
		_n = _n		+ ["BAF_L2A1_Tripod_W"];
	};
	_n = _n		+ ["MK19_TriPod_US_EP1"];
	_n = _n		+ ["TOW_TriPod_US_EP1"];
	_n = _n		+ ["Stinger_Pod_US_EP1"];
	_n = _n		+ ["M252_US_EP1"];
	_n = _n		+ ["M119_US_EP1"];
	_n = _n		+ ["Land_HBarrier3"];
	_n = _n		+ ["Land_HBarrier5"];
	_n = _n		+ ["Land_HBarrier_large"];
	_n = _n		+ ["US_WarfareBBarrier5x_EP1"];
	_n = _n		+ ["US_WarfareBBarrier10x_EP1"];
	_n = _n		+ ["US_WarfareBBarrier10xTall_EP1"];
	_n = _n		+ ["MASH_EP1"];
	_n = _n		+ ["Land_fort_bagfence_long"];
	_n = _n		+ ["Land_fort_bagfence_corner"];
	_n = _n		+ ["Land_fort_bagfence_round"];
	_n = _n		+ [if (WF_Camo) then {"Land_fortified_nest_small"} else {"Land_fortified_nest_small_EP1"}];
	_n = _n		+ [if (WF_Camo) then {"Land_fort_rampart"} else {"Land_fort_rampart_EP1"}];
	_n = _n		+ [if (WF_Camo) then {"Land_fort_artillery_nest"} else {"Land_fort_artillery_nest_EP1"}];
	_n = _n		+ ["Hhedgehog_concreteBig"];
	_n = _n		+ ["Hedgehog_EP1"];
	_n = _n		+ [if (WF_Camo) then {"Land_CamoNet_NATO"} else {"Land_CamoNet_NATO_EP1"}];
	_n = _n		+ [if (WF_Camo) then {"Land_CamoNetVar_NATO"} else {"Land_CamoNetVar_NATO_EP1"}];
	_n = _n		+ [if (WF_Camo) then {"Land_CamoNetB_NATO"} else {"Land_CamoNetB_NATO_EP1"}];
	_n = _n		+ ["Sign_Danger"];
	_n = _n		+ ["HeliH"];
	_n = _n		+ ["Land_Campfire"];
	_n = _n		+ ["USOrdnanceBox_EP1"];
	_n = _n		+ ["USVehicleBox_EP1"];
	_n = _n		+ ["USBasicAmmunitionBox_EP1"];
	_n = _n		+ ["USBasicWeapons_EP1"];
	_n = _n		+ ["USLaunchers_EP1"];
	_n = _n		+ ["USSpecialWeapons_EP1"];

	['WFBE_WESTDEFENSENAMES',_n,true] Call SetNamespace;

	/* EAST STRUCTURES */
	EASTHQ = if (WF_Camo) then {"BTR90_HQ_unfolded"} else {"BTR90_HQ_unfolded"};
	EASTBAR = if (WF_Camo) then {"RU_WarfareBBarracks"} else {"TK_WarfareBBarracks_EP1"};
	EASTLVF = if (WF_Camo) then {"RU_WarfareBLightFactory"} else {"TK_WarfareBLightFactory_EP1"};
	EASTCC = if (WF_Camo) then {"RU_WarfareBUAVterminal"} else {"TK_WarfareBUAVterminal_EP1"};
	EASTHEAVY = if (WF_Camo) then {"RU_WarfareBHeavyFactory"} else {"TK_WarfareBHeavyFactory_EP1"};
	EASTAIR = if (WF_Camo) then {"RU_WarfareBAircraftFactory"} else {"TK_WarfareBAircraftFactory_EP1"};
	EASTSP = if (WF_Camo) then {"RU_WarfareBVehicleServicePoint"} else {"TK_WarfareBVehicleServicePoint_EP1"};
	EASTAAR = if (WF_Camo) then {"RU_WarfareBAntiAirRadar"} else {"TK_WarfareBAntiAirRadar_EP1"};
	
	['WFBE_EASTFLAG','\Ca\Data\flag_rus_co.paa',true] Call SetNamespace;
	['WFBE_EASTFARP','CampEast',true] Call SetNamespace;
	
	_v			= ["Headquarters"];
	_n			= [EASTHQ];
	_d			= [getText (configFile >> "CfgVehicles" >> (_n select (count _n - 1)) >> "displayName")];
	_c			= [('WFBE_HQDEPLOYPRICE' Call GetNamespace)];
	_t			= [if (WF_Debug) then {1} else {30}];
	_i			= ["\CA\Warfare2\Images\con_hq.paa"];
	_s			= ["HQSite"];
	_dis		= [15];
	_dir		= [0];
	_h			= [3];

	_v = _v		+ ["Barracks"];
	_n = _n		+ [EASTBAR];
	_d = _d		+ [getText (configFile >> "CfgVehicles" >> (_n select (count _n - 1)) >> "displayName")];
	_c = _c		+ [200];
	_t = _t		+ [if (WF_Debug) then {1} else {70}];
	_i = _i		+ ["\CA\Warfare2\Images\con_barracks.paa"];
	_s = _s		+ ["SmallSite"];
	_dis = _dis	+ [18];
	_dir = _dir	+ [90];
	_h = _h		+ [3];

	_v = _v		+ ["Light"];
	_n = _n		+ [EASTLVF];
	_d = _d		+ [getText (configFile >> "CfgVehicles" >> (_n select (count _n - 1)) >> "displayName")];
	_c = _c		+ [600];
	_t = _t		+ [if (WF_Debug) then {1} else {90}];
	_i = _i		+ ["\CA\Warfare2\Images\con_light.paa"];
	_s = _s		+ ["MediumSite"];
	_dis = _dis	+ [20];
	_dir = _dir	+ [90];
	_h = _h		+ [4.5];

	_v = _v		+ ["CommandCenter"];
	_n = _n		+ [EASTCC];
	_d = _d		+ [localize "STR_WF_CommandCenter_RU"];
	_c = _c		+ [1200];
	_t = _t		+ [if (WF_Debug) then {1} else {110}];
	_i = _i		+ ["\CA\Warfare2\Images\con_hq.paa"];
	_s = _s		+ ["SmallSite"];

	_dis = _dis	+ [20];
	_dir = _dir	+ [90];
	_h = _h		+ [4.5];

	_v = _v		+ ["Heavy"];
	_n = _n		+ [EASTHEAVY];
	_d = _d		+ [getText (configFile >> "CfgVehicles" >> (_n select (count _n - 1)) >> "displayName")];
	_c = _c		+ [2800];
	_t = _t		+ [if (WF_Debug) then {1} else {130}];
	_i = _i		+ ["\CA\Warfare2\Images\con_heavy.paa"];
	_s = _s		+ ["MediumSite"];
	_dis = _dis	+ [20];
	_dir = _dir	+ [90];
	_h = _h		+ [4];

	_v = _v		+ ["Aircraft"];
	_n = _n		+ [EASTAIR];
	_d = _d		+ [localize "STR_WF_AircraftFactory"];
	_c = _c		+ [4400];
	_t = _t		+ [if (WF_Debug) then {1} else {150}];
	_i = _i		+ ["\CA\Warfare2\Images\con_aircraft.paa"];
	_s = _s		+ ["SmallSite"];
	_dis = _dis	+ [21];
	_dir = _dir	+ [90];
	_h = _h		+ [5.5];

	_v = _v		+ ["ServicePoint"];
	_n = _n		+ [EASTSP];
	_d = _d		+ [localize "STR_WF_ServicePoint"];
	_c = _c		+ [700];
	_t = _t		+ [if (WF_Debug) then {1} else {70}];
	_i = _i		+ ["\CA\Warfare2\Images\con_light.paa"];
	_s = _s		+ ["SmallSite"];
	_dis = _dis	+ [21];
	_dir = _dir	+ [90];
	_h = _h		+ [5.5];

	if (paramAARadar) then {
		_v = _v		+ ["AARadar"];
		_n = _n		+ [EASTAAR];
		_d = _d		+ [getText (configFile >> "CfgVehicles" >> (_n select (count _n - 1)) >> "displayName")];
		_c = _c		+ [3200];
		_t = _t		+ [if (WF_Debug) then {1} else {280}];
		_i = _i		+ ["\CA\Warfare2\Images\con_light.paa"];
		_s = _s		+ ["MediumSite"];
		_dis = _dis	+ [21];
		_dir = _dir	+ [90];
		_h = _h		+ [5.5];
	};

	for [{_count = count _v - 1},{_count >= 0},{_count = _count - 1}] do {
		[Format["WFBE_EAST%1TYPE",_v select _count],_count,true] Call SetNamespace;
	};

	['WFBE_EASTMHQNAME','BTR90_HQ',true] Call SetNamespace;
	
	['WFBE_EASTSTRUCTURES',_v,true] Call SetNamespace;
	['WFBE_EASTSTRUCTURENAMES',_n,true] Call SetNamespace;
	['WFBE_EASTSTRUCTUREDESCRIPTIONS',_d,true] Call SetNamespace;
	['WFBE_EASTSTRUCTURECOSTS',_c,true] Call SetNamespace;
	['WFBE_EASTSTRUCTURETIMES',_t,true] Call SetNamespace;
	['WFBE_EASTSTRUCTUREIMAGES',_i,true] Call SetNamespace;
	['WFBE_EASTSTRUCTUREDISTANCES',_dis,true] Call SetNamespace;
	['WFBE_EASTSTRUCTUREDIRECTIONS',_dir,true] Call SetNamespace;
	['WFBE_EASTSTRUCTURESCRIPTS',_s,true] Call SetNamespace;
	['WFBE_EASTSTRUCTUREHEIGHTS',_h,true] Call SetNamespace;

	/* EAST STATIONARY DEFENSES */
	_n			= ["RU_WarfareBMGNest_PK"];
	_n = _n		+ ["SearchLight_TK_EP1"];
	_n = _n		+ ["KORD_TK_EP1"];
	_n = _n		+ ["KORD_high_TK_EP1"];
	_n = _n		+ ["AGS_TK_EP1"];
	_n = _n		+ ["SPG9_TK_INS_EP1"];
	_n = _n		+ ["Metis_TK_EP1"];
	_n = _n		+ ["Igla_AA_pod_TK_EP1"];
	_n = _n		+ ["ZU23_TK_EP1"];
	_n = _n		+ ["2b14_82mm_TK_EP1"];
	_n = _n		+ ["D30_TK_EP1"];
	_n = _n		+ ["Land_HBarrier3"];
	_n = _n		+ ["Land_HBarrier5"];
	_n = _n		+ ["Land_HBarrier_large"];
	_n = _n		+ ["TK_WarfareBBarrier5x_EP1"];
	_n = _n		+ ["TK_WarfareBBarrier10x_EP1"];
	_n = _n		+ ["TK_WarfareBBarrier10xTall_EP1"];
	_n = _n		+ ["MASH_EP1"];
	_n = _n		+ ["Land_fort_bagfence_long"];
	_n = _n		+ ["Land_fort_bagfence_corner"];
	_n = _n		+ ["Land_fort_bagfence_round"];
	_n = _n		+ [if (WF_Camo) then {"Land_fortified_nest_small"} else {"Land_fortified_nest_small_EP1"}];
	_n = _n		+ [if (WF_Camo) then {"Land_fort_rampart"} else {"Land_fort_rampart_EP1"}];
	_n = _n		+ [if (WF_Camo) then {"Land_fort_artillery_nest"} else {"Land_fort_artillery_nest_EP1"}];
	_n = _n		+ ["Hhedgehog_concreteBig"];
	_n = _n		+ ["Hedgehog_EP1"];
	_n = _n		+ [if (WF_Camo) then {"Land_CamoNet_EAST"} else {"Land_CamoNet_EAST_EP1"}];
	_n = _n		+ [if (WF_Camo) then {"Land_CamoNetVar_EAST"} else {"Land_CamoNetVar_EAST_EP1"}];
	_n = _n		+ [if (WF_Camo) then {"Land_CamoNetB_EAST"} else {"Land_CamoNetB_EAST_EP1"}];
	_n = _n		+ ["Sign_Danger"];
	_n = _n		+ ["HeliH"];
	_n = _n		+ ["Land_Campfire"];
	_n = _n		+ ["RUOrdnanceBox"];
	_n = _n		+ ["RUVehicleBox"];
	_n = _n		+ ["RUBasicAmmunitionBox"];
	_n = _n		+ ["RUBasicWeaponsBox"];
	_n = _n		+ ["RULaunchersBox"];
	_n = _n		+ ["RUSpecialWeaponsBox"];

	['WFBE_EASTDEFENSENAMES',_n,true] Call SetNamespace;

	['WFBE_WESTCONSTRUCTIONSITE','US_WarfareBContructionSite_EP1',true] Call SetNamespace;
	['WFBE_EASTCONSTRUCTIONSITE','RU_WarfareBContructionSite',true] Call SetNamespace;

	/* RESISTANCE STATIONARY DEFENSES */
	_n			= ["WarfareBMGNest_PK_TK_GUE_EP1"];
	_n = _n		+ ["GUE_WarfareBMGNest_PK"];
	_n = _n		+ ["ZU23_Gue"];
	_n = _n		+ ["ZU23_TK_GUE_EP1"];

	['WFBE_RESISTANCEDEFENSENAMES',_n,true] Call SetNamespace;
};