//_v - variable name
//_n - building classname
//_d - description (translated).
//_c - cost (in supplies), for stationary defenses cost is in money.
//_t - time to build
//_i - Image on construction menu.
//_s - script executed to build
//_dir - direction from structure to place a unit created by it.
//_dis - distance from structure to place a unit created by it.

//WEST STRUCTURES
if (WF_A2_Vanilla) then {
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
	_t			= [30];
	_i			= ["\CA\Warfare2\Images\con_hq.paa"];
	_s			= ["HQSite"];
	_dis		= [15];
	_dir		= [0];
	_h			= [3];

	_v = _v		+ ["Barracks"];
	_n = _n		+ [WESTBAR];
	_d = _d		+ [getText (configFile >> "CfgVehicles" >> (_n select (count _n - 1)) >> "displayName")];
	_c = _c		+ [200];
	_t = _t		+ [70];
	_i = _i		+ ["\CA\Warfare2\Images\con_barracks.paa"];
	_s = _s		+ ["SmallSite"];
	_dis = _dis	+ [18];
	_dir = _dir	+ [90];
	_h = _h		+ [3];

	_v = _v		+ ["Light"];
	_n = _n		+ [WESTLVF];
	_d = _d		+ [getText (configFile >> "CfgVehicles" >> (_n select (count _n - 1)) >> "displayName")];
	_c = _c		+ [600];
	_t = _t		+ [90];
	_i = _i		+ ["\CA\Warfare2\Images\con_light.paa"];
	_s = _s		+ ["MediumSite"];
	_dis = _dis	+ [20];
	_dir = _dir	+ [90];
	_h = _h		+ [4.5];

	_v = _v		+ ["CommandCenter"];
	_n = _n		+ [WESTCC];
	_d = _d		+ [localize "STR_WF_CommandCenter_USMC"];
	_c = _c		+ [1200];
	_t = _t		+ [110];
	_i = _i		+ ["\CA\Warfare2\Images\con_hq.paa"];
	_s = _s		+ ["SmallSite"];
	_dis = _dis	+ [20];
	_dir = _dir	+ [90];
	_h = _h		+ [4.5];

	_v = _v		+ ["Heavy"];
	_n = _n		+ [WESTHEAVY];
	_d = _d		+ [getText (configFile >> "CfgVehicles" >> (_n select (count _n - 1)) >> "displayName")];
	_c = _c		+ [2800];
	_t = _t		+ [130];
	_i = _i		+ ["\CA\Warfare2\Images\con_heavy.paa"];
	_s = _s		+ ["MediumSite"];
	_dis = _dis	+ [20];
	_dir = _dir	+ [90];
	_h = _h		+ [4];

	_v = _v		+ ["Aircraft"];
	_n = _n		+ [WESTAIR];
	_d = _d		+ [getText (configFile >> "CfgVehicles" >> (_n select (count _n - 1)) >> "displayName")];
	_c = _c		+ [4400];
	_t = _t		+ [150];
	_i = _i		+ ["\CA\Warfare2\Images\con_aircraft.paa"];
	_s = _s		+ ["SmallSite"];
	_dis = _dis	+ [31];
	_dir = _dir	+ [90];
	_h = _h		+ [5.5];

	_v = _v		+ ["ServicePoint"];
	_n = _n		+ [WESTSP];
	_d = _d		+ [getText (configFile >> "CfgVehicles" >> (_n select (count _n - 1)) >> "displayName")];
	_c = _c		+ [700];
	_t = _t		+ [70];
	_i = _i		+ ["\CA\Warfare2\Images\con_light.paa"];
	_s = _s		+ ["SmallSite"];
	_dis = _dis	+ [21];
	_dir = _dir	+ [90];
	_h = _h		+ [5.5];

	if (AARadar) then {
		_v = _v		+ ["AARadar"];
		_n = _n		+ [WESTAAR];
		_d = _d		+ [getText (configFile >> "CfgVehicles" >> (_n select (count _n - 1)) >> "displayName")];
		_c = _c		+ [3200];
		_t = _t		+ [280];
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

	//Note that cost of defenses is in money instead of supplies.
	//WEST STATIONARY DEFENSES
	_v			= ["MGNest"];
	_n			= ["USMC_WarfareBMGNest_M240"];
	_d			= [getText (configFile >> "CfgVehicles" >> (_n select (count _n - 1)) >> "displayName")];
	_c			= [300];
	_t			= [0];
	_i			= ["\CA\Warfare2\Images\con_mg_nest.paa"];
	_s			= ["StationaryDefense"];
	_dis		= [0];
	_dir		= [0];
	_h			= [0];
	_b			= ["Defense"];

	_v = _v		+ ["M2HD"];
	_n = _n		+ ["M2HD_mini_TriPod"];
	_d = _d		+ [getText (configFile >> "CfgVehicles" >> (_n select (count _n - 1)) >> "displayName")];
	_c = _c		+ [200];
	_t = _t		+ [0];
	_i = _i		+ ["\CA\Warfare2\Images\con_gl.paa"];
	_s = _s		+ ["StationaryDefense"];
	_dis = _dis	+ [0];
	_dir = _dir	+ [0];
	_h = _h		+ [0];
	_b = _b 		+ ["Defense"];

	_v = _v		+ ["SearchLight"];
	_n = _n		+ ["SearchLight"];
	_d = _d		+ [getText (configFile >> "CfgVehicles" >> (_n select (count _n - 1)) >> "displayName")];
	_c = _c		+ [175];
	_t = _t		+ [0];
	_i = _i		+ ["\CA\Warfare2\Images\con_reflector.paa"];
	_s = _s		+ ["StationaryDefense"];
	_dis = _dis	+ [0];
	_dir = _dir	+ [0];
	_h = _h		+ [0];
	_b = _b 		+ ["Defense"];

	_v = _v		+ ["M2"];
	_n = _n		+ ["M2StaticMG"];
	_d = _d		+ [getText (configFile >> "CfgVehicles" >> (_n select (count _n - 1)) >> "displayName")];
	_c = _c		+ [225];
	_t = _t		+ [0];
	_i = _i		+ ["\CA\Warfare2\Images\con_gl.paa"];
	_s = _s		+ ["StationaryDefense"];
	_dis = _dis	+ [0];
	_dir = _dir	+ [0];
	_h = _h		+ [0];
	_b = _b 		+ ["Defense"];

	_v = _v		+ ["MK19"];
	_n = _n		+ ["MK19_TriPod"];
	_d = _d		+ [getText (configFile >> "CfgVehicles" >> (_n select (count _n - 1)) >> "displayName")];
	_c = _c		+ [700];
	_t = _t		+ [0];
	_i = _i		+ ["\CA\Warfare2\Images\con_gl.paa"];
	_s = _s		+ ["StationaryDefense"];
	_dis = _dis	+ [0];
	_dir = _dir	+ [0];
	_h = _h		+ [0];
	_b = _b 		+ ["Defense"];

	_v = _v		+ ["ATTripod"];
	_n = _n		+ ["TOW_TriPod"];
	_d = _d		+ [getText (configFile >> "CfgVehicles" >> (_n select (count _n - 1)) >> "displayName")];
	_c = _c		+ [800];
	_t = _t		+ [0];
	_i = _i		+ ["\CA\Warfare2\Images\con_at_pod.paa"];
	_s = _s		+ ["StationaryDefense"];
	_dis = _dis	+ [0];
	_dir = _dir	+ [0];
	_h = _h		+ [0];
	_b = _b 		+ ["Defense"];

	_v = _v		+ ["AATripod"];
	_n = _n		+ ["Stinger_Pod"];
	_d = _d		+ [getText (configFile >> "CfgVehicles" >> (_n select (count _n - 1)) >> "displayName")];
	_c = _c		+ [800];
	_t = _t		+ [0];
	_i = _i		+ ["\CA\Warfare2\Images\con_aa_pod.paa"];
	_s = _s		+ ["StationaryDefense"];
	_dis = _dis	+ [0];
	_dir = _dir	+ [0];
	_h = _h		+ [0];
	_b = _b 		+ ["Defense"];

	_v = _v		+ ["M252"];
	_n = _n		+ ["M252"];
	_d = _d		+ [getText (configFile >> "CfgVehicles" >> (_n select (count _n - 1)) >> "displayName")];
	_c = _c		+ [1100];
	_t = _t		+ [0];
	_i = _i		+ ["\CA\Warfare2\Images\con_gun.paa"];
	_s = _s		+ ["StationaryDefense"];
	_dis = _dis	+ [0];
	_dir = _dir	+ [0];
	_h = _h		+ [0];
	_b = _b 		+ ["Defense"];

	_v = _v		+ ["M119"];
	_n = _n		+ ["M119"];
	_d = _d		+ [getText (configFile >> "CfgVehicles" >> (_n select (count _n - 1)) >> "displayName")];
	_c = _c		+ [2250];
	_t = _t		+ [0];
	_i = _i		+ ["\CA\Warfare2\Images\con_gun.paa"];
	_s = _s		+ ["StationaryDefense"];
	_dis = _dis	+ [0];
	_dir = _dir	+ [0];
	_h = _h		+ [0];
	_b = _b 		+ ["Defense"];

	_v = _v		+ ["SmallWall"];
	_n = _n		+ ["Land_HBarrier3"];
	_d = _d		+ [getText (configFile >> "CfgVehicles" >> (_n select (count _n - 1)) >> "displayName")];
	_c = _c		+ [20];
	_t = _t		+ [0];
	_i = _i		+ ["\CA\Warfare2\Images\con_wall1.paa"];
	_s = _s		+ ["StationaryDefense"];
	_dis = _dis	+ [0];
	_dir = _dir	+ [0];
	_h = _h		+ [0];
	_b = _b 		+ ["Fortification"];

	_v = _v		+ ["MediumWall"];
	_n = _n		+ ["Land_HBarrier5"];
	_d = _d		+ [getText (configFile >> "CfgVehicles" >> (_n select (count _n - 1)) >> "displayName")];
	_c = _c		+ [30];
	_t = _t		+ [0];
	_i = _i		+ ["\CA\Warfare2\Images\con_wall2.paa"];
	_s = _s		+ ["StationaryDefense"];
	_dis = _dis	+ [0];
	_dir = _dir	+ [0];
	_h = _h		+ [0];
	_b = _b 		+ ["Fortification"];

	_v = _v		+ ["LargeWall"];
	_n = _n		+ ["Land_HBarrier_large"];
	_d = _d		+ [getText (configFile >> "CfgVehicles" >> (_n select (count _n - 1)) >> "displayName")];
	_c = _c		+ [50];
	_t = _t		+ [0];
	_i = _i		+ ["\CA\Warfare2\Images\con_wall3.paa"];
	_s = _s		+ ["StationaryDefense"];
	_dis = _dis	+ [0];
	_dir = _dir	+ [0];
	_h = _h		+ [0];
	_b = _b 		+ ["Fortification"];

	_v = _v		+ ["Base_WarfareBBarrier5x"];
	_n = _n		+ ["Base_WarfareBBarrier5x"];
	_d = _d		+ [getText (configFile >> "CfgVehicles" >> (_n select (count _n - 1)) >> "displayName")];
	_c = _c		+ [15];
	_t = _t		+ [0];
	_i = _i		+ ["\CA\Warfare2\Images\con_wall3.paa"];
	_s = _s		+ ["StationaryDefense"];
	_dis = _dis	+ [0];
	_dir = _dir	+ [0];
	_h = _h		+ [0];
	_b = _b 		+ ["Fortification"];

	_v = _v		+ ["Base_WarfareBBarrier10x"];
	_n = _n		+ ["Base_WarfareBBarrier10x"];
	_d = _d		+ [getText (configFile >> "CfgVehicles" >> (_n select (count _n - 1)) >> "displayName")];
	_c = _c		+ [25];
	_t = _t		+ [0];
	_i = _i		+ ["\CA\Warfare2\Images\con_wall3.paa"];
	_s = _s		+ ["StationaryDefense"];
	_dis = _dis	+ [0];
	_dir = _dir	+ [0];
	_h = _h		+ [0];
	_b = _b 		+ ["Fortification"];

	_v = _v		+ ["Base_WarfareBBarrier10xTall"];
	_n = _n		+ ["Base_WarfareBBarrier10xTall"];
	_d = _d		+ [getText (configFile >> "CfgVehicles" >> (_n select (count _n - 1)) >> "displayName")];
	_c = _c		+ [50];
	_t = _t		+ [0];
	_i = _i		+ ["\CA\Warfare2\Images\con_wall3.paa"];
	_s = _s		+ ["StationaryDefense"];
	_dis = _dis	+ [0];
	_dir = _dir	+ [0];
	_h = _h		+ [0];
	_b = _b 		+ ["Fortification"];

	_v = _v		+ ["MASH"];
	_n = _n		+ ["MASH"];
	_d = _d		+ [getText (configFile >> "CfgVehicles" >> (_n select (count _n - 1)) >> "displayName")];
	_c = _c		+ [30];
	_t = _t		+ [0];
	_i = _i		+ ["\CA\Warfare2\Images\con_wall1.paa"];
	_s = _s		+ ["StationaryDefense"];
	_dis = _dis	+ [0];
	_dir = _dir	+ [0];
	_h = _h		+ [0];
	_b = _b 		+ ["Strategic"];

	_v = _v		+ ["Land_fort_bagfence_long"];
	_n = _n		+ ["Land_fort_bagfence_long"];
	_d = _d		+ [getText (configFile >> "CfgVehicles" >> (_n select (count _n - 1)) >> "displayName")];
	_c = _c		+ [10];
	_t = _t		+ [0];
	_i = _i		+ ["\CA\Warfare2\Images\con_wall1.paa"];
	_s = _s		+ ["StationaryDefense"];
	_dis = _dis	+ [0];
	_dir = _dir	+ [0];
	_h = _h		+ [0];
	_b = _b 		+ ["Fortification"];

	_v = _v		+ ["Land_fort_bagfence_corner"];
	_n = _n		+ ["Land_fort_bagfence_corner"];
	_d = _d		+ [getText (configFile >> "CfgVehicles" >> (_n select (count _n - 1)) >> "displayName")];
	_c = _c		+ [8];
	_t = _t		+ [0];
	_i = _i		+ ["\CA\Warfare2\Images\con_wall1.paa"];
	_s = _s		+ ["StationaryDefense"];
	_dis = _dis	+ [0];
	_dir = _dir	+ [0];
	_h = _h		+ [0];
	_b = _b 		+ ["Fortification"];

	_v = _v		+ ["Land_fort_bagfence_round"];
	_n = _n		+ ["Land_fort_bagfence_round"];
	_d = _d		+ [getText (configFile >> "CfgVehicles" >> (_n select (count _n - 1)) >> "displayName")];
	_c = _c		+ [12];
	_t = _t		+ [0];
	_i = _i		+ ["\CA\Warfare2\Images\con_wall1.paa"];
	_s = _s		+ ["StationaryDefense"];
	_dis = _dis	+ [0];
	_dir = _dir	+ [0];
	_h = _h		+ [0];
	_b = _b 		+ ["Fortification"];

	_v = _v		+ ["Land_fortified_nest_small"];
	_n = _n		+ ["Land_fortified_nest_small"];
	_d = _d		+ [getText (configFile >> "CfgVehicles" >> (_n select (count _n - 1)) >> "displayName")];
	_c = _c		+ [40];
	_t = _t		+ [0];
	_i = _i		+ ["\CA\Warfare2\Images\con_wall1.paa"];
	_s = _s		+ ["StationaryDefense"];
	_dis = _dis	+ [0];
	_dir = _dir	+ [0];
	_h = _h		+ [0];
	_b = _b 		+ ["Fortification"];

	_v = _v		+ ["Land_fortified_nest_big"];
	_n = _n		+ ["Land_fortified_nest_big"];
	_d = _d		+ [getText (configFile >> "CfgVehicles" >> (_n select (count _n - 1)) >> "displayName")];
	_c = _c		+ [100];
	_t = _t		+ [0];
	_i = _i		+ ["\CA\Warfare2\Images\con_wall1.paa"];
	_s = _s		+ ["StationaryDefense"];
	_dis = _dis	+ [0];
	_dir = _dir	+ [0];
	_h = _h		+ [0];
	_b = _b 		+ ["Fortification"];

	_v = _v		+ ["Land_Fort_Watchtower"];
	_n = _n		+ ["Land_Fort_Watchtower"];
	_d = _d		+ [getText (configFile >> "CfgVehicles" >> (_n select (count _n - 1)) >> "displayName")];
	_c = _c		+ [150];
	_t = _t		+ [0];
	_i = _i		+ ["\CA\Warfare2\Images\con_wall1.paa"];
	_s = _s		+ ["StationaryDefense"];
	_dis = _dis	+ [0];
	_dir = _dir	+ [0];
	_h = _h		+ [0];
	_b = _b 		+ ["Fortification"];

	_v = _v		+ ["Land_fort_rampart"];
	_n = _n		+ ["Land_fort_rampart"];
	_d = _d		+ [getText (configFile >> "CfgVehicles" >> (_n select (count _n - 1)) >> "displayName")];
	_c = _c		+ [30];
	_t = _t		+ [0];
	_i = _i		+ ["\CA\Warfare2\Images\con_wall1.paa"];
	_s = _s		+ ["StationaryDefense"];
	_dis = _dis	+ [0];
	_dir = _dir	+ [0];
	_h = _h		+ [0];
	_b = _b 		+ ["Fortification"];

	_v = _v		+ ["Land_fort_artillery_nest"];
	_n = _n		+ ["Land_fort_artillery_nest"];
	_d = _d		+ [getText (configFile >> "CfgVehicles" >> (_n select (count _n - 1)) >> "displayName")];
	_c = _c		+ [65];
	_t = _t		+ [0];
	_i = _i		+ ["\CA\Warfare2\Images\con_wall1.paa"];
	_s = _s		+ ["StationaryDefense"];
	_dis = _dis	+ [0];
	_dir = _dir	+ [0];
	_h = _h		+ [0];
	_b = _b 		+ ["Fortification"];

	_v = _v		+ ["Hhedgehog_concreteBig"];
	_n = _n		+ ["Hhedgehog_concreteBig"];
	_d = _d		+ [getText (configFile >> "CfgVehicles" >> (_n select (count _n - 1)) >> "displayName")];
	_c = _c		+ [95];
	_t = _t		+ [0];
	_i = _i		+ ["\CA\Warfare2\Images\con_wall1.paa"];
	_s = _s		+ ["StationaryDefense"];
	_dis = _dis	+ [0];
	_dir = _dir	+ [0];
	_h = _h		+ [0];
	_b = _b 		+ ["Fortification"];

	_v = _v		+ ["Hedgehog"];
	_n = _n		+ ["Hedgehog"];
	_d = _d		+ [getText (configFile >> "CfgVehicles" >> (_n select (count _n - 1)) >> "displayName")];
	_c = _c		+ [5];
	_t = _t		+ [0];
	_i = _i		+ ["\CA\Warfare2\Images\con_wall1.paa"];
	_s = _s		+ ["StationaryDefense"];
	_dis = _dis	+ [0];
	_dir = _dir	+ [0];
	_h = _h		+ [0];
	_b = _b 		+ ["Fortification"];

	_v = _v		+ ["Land_CamoNet"];
	_n = _n		+ ["Land_CamoNet_NATO"];
	_d = _d		+ [getText (configFile >> "CfgVehicles" >> (_n select (count _n - 1)) >> "displayName")];
	_c = _c		+ [35];
	_t = _t		+ [0];
	_i = _i		+ ["\CA\Warfare2\Images\con_wall1.paa"];
	_s = _s		+ ["StationaryDefense"];
	_dis = _dis	+ [0];
	_dir = _dir	+ [0];
	_h = _h		+ [0];
	_b = _b 		+ ["Strategic"];

	_v = _v		+ ["Land_CamoNetVar"];
	_n = _n		+ ["Land_CamoNetVar_NATO"];
	_d = _d		+ [getText (configFile >> "CfgVehicles" >> (_n select (count _n - 1)) >> "displayName")];
	_c = _c		+ [45];
	_t = _t		+ [0];
	_i = _i		+ ["\CA\Warfare2\Images\con_wall1.paa"];
	_s = _s		+ ["StationaryDefense"];
	_dis = _dis	+ [0];
	_dir = _dir	+ [0];
	_h = _h		+ [0];
	_b = _b 		+ ["Strategic"];

	_v = _v		+ ["Land_CamoNetB"];
	_n = _n		+ ["Land_CamoNetB_NATO"];
	_d = _d		+ [getText (configFile >> "CfgVehicles" >> (_n select (count _n - 1)) >> "displayName")];
	_c = _c		+ [55];
	_t = _t		+ [0];
	_i = _i		+ ["\CA\Warfare2\Images\con_wall1.paa"];
	_s = _s		+ ["StationaryDefense"];
	_dis = _dis	+ [0];
	_dir = _dir	+ [0];
	_h = _h		+ [0];
	_b = _b 		+ ["Strategic"];

	_v = _v		+ ["Sign_Danger"];
	_n = _n		+ ["Sign_Danger"];
	_d = _d		+ [localize 'STR_WF_Minefield'];
	_c = _c		+ [1200];
	_t = _t		+ [0];
	_i = _i		+ ["\CA\Warfare2\Images\con_wall1.paa"];
	_s = _s		+ ["StationaryDefense"];
	_dis = _dis	+ [0];
	_dir = _dir	+ [0];
	_h = _h		+ [0];
	_b = _b 		+ ["Strategic"];

	_v = _v		+ ["HeliH"];
	_n = _n		+ ["HeliH"];
	_d = _d		+ [getText (configFile >> "CfgVehicles" >> (_n select (count _n - 1)) >> "displayName")];
	_c = _c		+ [16];
	_t = _t		+ [0];
	_i = _i		+ ["\CA\Warfare2\Images\con_wall1.paa"];
	_s = _s		+ ["StationaryDefense"];
	_dis = _dis	+ [0];
	_dir = _dir	+ [0];
	_h = _h		+ [0];
	_b = _b 		+ ["Strategic"];

	_v = _v		+ ["USOrdnanceBox"];
	_n = _n		+ ["USOrdnanceBox"];
	_d = _d		+ [getText (configFile >> "CfgVehicles" >> (_n select (count _n - 1)) >> "displayName")];
	_c = _c		+ [850];
	_t = _t		+ [0];
	_i = _i		+ ["\CA\Warfare2\Images\con_wall1.paa"];
	_s = _s		+ ["StationaryDefense"];
	_dis = _dis	+ [0];
	_dir = _dir	+ [0];
	_h = _h		+ [0];
	_b = _b 		+ ["Ammo"];

	_v = _v		+ ["USVehicleBox"];
	_n = _n		+ ["USVehicleBox"];
	_d = _d		+ [getText (configFile >> "CfgVehicles" >> (_n select (count _n - 1)) >> "displayName")];
	_c = _c		+ [1200];
	_t = _t		+ [0];
	_i = _i		+ ["\CA\Warfare2\Images\con_wall1.paa"];
	_s = _s		+ ["StationaryDefense"];
	_dis = _dis	+ [0];
	_dir = _dir	+ [0];
	_h = _h		+ [0];
	_b = _b 		+ ["Ammo"];

	_v = _v		+ ["USBasicAmmunitionBox"];
	_n = _n		+ ["USBasicAmmunitionBox"];
	_d = _d		+ [getText (configFile >> "CfgVehicles" >> (_n select (count _n - 1)) >> "displayName")];
	_c = _c		+ [1950];
	_t = _t		+ [0];
	_i = _i		+ ["\CA\Warfare2\Images\con_wall1.paa"];
	_s = _s		+ ["StationaryDefense"];
	_dis = _dis	+ [0];
	_dir = _dir	+ [0];
	_h = _h		+ [0];
	_b = _b 		+ ["Ammo"];

	_v = _v		+ ["USBasicWeaponsBox"];
	_n = _n		+ ["USBasicWeaponsBox"];
	_d = _d		+ [getText (configFile >> "CfgVehicles" >> (_n select (count _n - 1)) >> "displayName")];
	_c = _c		+ [2975];
	_t = _t		+ [0];
	_i = _i		+ ["\CA\Warfare2\Images\con_wall1.paa"];
	_s = _s		+ ["StationaryDefense"];
	_dis = _dis	+ [0];
	_dir = _dir	+ [0];
	_h = _h		+ [0];
	_b = _b 		+ ["Ammo"];

	_v = _v		+ ["USLaunchersBox"];
	_n = _n		+ ["USLaunchersBox"];
	_d = _d		+ [getText (configFile >> "CfgVehicles" >> (_n select (count _n - 1)) >> "displayName")];
	_c = _c		+ [6250];
	_t = _t		+ [0];
	_i = _i		+ ["\CA\Warfare2\Images\con_wall1.paa"];
	_s = _s		+ ["StationaryDefense"];
	_dis = _dis	+ [0];
	_dir = _dir	+ [0];
	_h = _h		+ [0];
	_b = _b 		+ ["Ammo"];

	_v = _v		+ ["USSpecialWeaponsBox"];
	_n = _n		+ ["USSpecialWeaponsBox"];
	_d = _d		+ [getText (configFile >> "CfgVehicles" >> (_n select (count _n - 1)) >> "displayName")];
	_c = _c		+ [7500];
	_t = _t		+ [0];
	_i = _i		+ ["\CA\Warfare2\Images\con_wall1.paa"];
	_s = _s		+ ["StationaryDefense"];
	_dis = _dis	+ [0];
	_dir = _dir	+ [0];
	_h = _h		+ [0];
	_b = _b 		+ ["Ammo"];

	['WFBE_WESTDEFENSES',_v,true] Call SetNamespace;
	['WFBE_WESTDEFENSENAMES',_n,true] Call SetNamespace;
	['WFBE_WESTDEFENSEDESCRIPTIONS',_d,true] Call SetNamespace;
	['WFBE_WESTDEFENSECOSTS',_c,true] Call SetNamespace;
	['WFBE_WESTDEFENSETIMES',_t,true] Call SetNamespace;
	['WFBE_WESTDEFENSEIMAGES',_i,true] Call SetNamespace;
	['WFBE_WESTDEFENSEDISTANCES',_dis,true] Call SetNamespace;
	['WFBE_WESTDEFENSEDIRECTIONS',_dir,true] Call SetNamespace;
	['WFBE_WESTDEFENSESCRIPTS',_s,true] Call SetNamespace;
	['WFBE_WESTDEFENSEHEIGHTS',_h,true] Call SetNamespace;
	['WFBE_WESTDEFENSECATEGORIES',_b,true] Call SetNamespace;

	//EAST STRUCTURES
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
	_t			= [30];
	_i			= ["\CA\Warfare2\Images\con_hq.paa"];
	_s			= ["HQSite"];
	_dis		= [15];
	_dir		= [0];
	_h			= [3];

	_v = _v		+ ["Barracks"];
	_n = _n		+ [EASTBAR];
	_d = _d		+ [getText (configFile >> "CfgVehicles" >> (_n select (count _n - 1)) >> "displayName")];
	_c = _c		+ [200];
	_t = _t		+ [70];
	_i = _i		+ ["\CA\Warfare2\Images\con_barracks.paa"];
	_s = _s		+ ["SmallSite"];
	_dis = _dis	+ [18];
	_dir = _dir	+ [90];
	_h = _h		+ [3];

	_v = _v		+ ["Light"];
	_n = _n		+ [EASTLVF];
	_d = _d		+ [getText (configFile >> "CfgVehicles" >> (_n select (count _n - 1)) >> "displayName")];
	_c = _c		+ [600];
	_t = _t		+ [90];
	_i = _i		+ ["\CA\Warfare2\Images\con_light.paa"];
	_s = _s		+ ["MediumSite"];
	_dis = _dis	+ [20];
	_dir = _dir	+ [90];
	_h = _h		+ [4.5];

	_v = _v		+ ["CommandCenter"];
	_n = _n		+ [EASTCC];
	_d = _d		+ [localize "STR_WF_CommandCenter_RU"];
	_c = _c		+ [1200];
	_t = _t		+ [110];
	_i = _i		+ ["\CA\Warfare2\Images\con_hq.paa"];
	_s = _s		+ ["SmallSite"];

	_dis = _dis	+ [20];
	_dir = _dir	+ [90];
	_h = _h		+ [4.5];

	_v = _v		+ ["Heavy"];
	_n = _n		+ [EASTHEAVY];
	_d = _d		+ [getText (configFile >> "CfgVehicles" >> (_n select (count _n - 1)) >> "displayName")];
	_c = _c		+ [2800];
	_t = _t		+ [130];
	_i = _i		+ ["\CA\Warfare2\Images\con_heavy.paa"];
	_s = _s		+ ["MediumSite"];
	_dis = _dis	+ [20];
	_dir = _dir	+ [90];
	_h = _h		+ [4];

	_v = _v		+ ["Aircraft"];
	_n = _n		+ [EASTAIR];
	_d = _d		+ [getText (configFile >> "CfgVehicles" >> (_n select (count _n - 1)) >> "displayName")];
	_c = _c		+ [4400];
	_t = _t		+ [150];
	_i = _i		+ ["\CA\Warfare2\Images\con_aircraft.paa"];
	_s = _s		+ ["SmallSite"];
	_dis = _dis	+ [21];
	_dir = _dir	+ [90];
	_h = _h		+ [5.5];

	_v = _v		+ ["ServicePoint"];
	_n = _n		+ [EASTSP];
	_d = _d		+ [getText (configFile >> "CfgVehicles" >> (_n select (count _n - 1)) >> "displayName")];
	_c = _c		+ [700];
	_t = _t		+ [70];
	_i = _i		+ ["\CA\Warfare2\Images\con_light.paa"];
	_s = _s		+ ["SmallSite"];
	_dis = _dis	+ [21];
	_dir = _dir	+ [90];
	_h = _h		+ [5.5];

	if (AARadar) then {
		_v = _v		+ ["AARadar"];
		_n = _n		+ [EASTAAR];
		_d = _d		+ [getText (configFile >> "CfgVehicles" >> (_n select (count _n - 1)) >> "displayName")];
		_c = _c		+ [3200];
		_t = _t		+ [280];
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

	//Note that cost of defenses is in money instead of supplies.
	//EAST STATIONARY DEFENSES
	_v			= ["MGNest"];
	_n			= ["RU_WarfareBMGNest_PK"];
	_d			= [getText (configFile >> "CfgVehicles" >> (_n select (count _n - 1)) >> "displayName")];
	_c			= [300];
	_t			= [0];
	_i			= ["\CA\Warfare2\Images\con_mg_nest.paa"];
	_s			= ["StationaryDefense"];
	_dis		= [0];
	_dir		= [0];
	_h			= [0];
	_b			= ["Defense"];

	_v = _v		+ ["SearchLight_RUS"];
	_n = _n		+ ["SearchLight_RUS"];
	_d = _d		+ [getText (configFile >> "CfgVehicles" >> (_n select (count _n - 1)) >> "displayName")];
	_c = _c		+ [175];
	_t = _t		+ [0];
	_i = _i		+ ["\CA\Warfare2\Images\con_reflector.paa"];
	_s = _s		+ ["StationaryDefense"];
	_dis = _dis	+ [0];
	_dir = _dir	+ [0];
	_h = _h		+ [0];
	_b = _b 		+ ["Defense"];

	_v = _v		+ ["KORD"];
	_n = _n		+ ["KORD"];
	//--- Russian Localization Hotfix.
	_d = _d		+ ["KORD Minitripod"];
	_c = _c		+ [250];
	_t = _t		+ [0];
	_i = _i		+ ["\CA\Warfare2\Images\con_gl.paa"];
	_s = _s		+ ["StationaryDefense"];
	_dis = _dis	+ [0];
	_dir = _dir	+ [0];
	_h = _h		+ [0];
	_b = _b 		+ ["Defense"];

	_v = _v		+ ["KORD_high"];
	_n = _n		+ ["KORD_high"];
	//--- Russian Localization Hotfix.
	_d = _d		+ ["KORD"];
	_c = _c		+ [300];
	_t = _t		+ [0];
	_i = _i		+ ["\CA\Warfare2\Images\con_gl.paa"];
	_s = _s		+ ["StationaryDefense"];
	_dis = _dis	+ [0];
	_dir = _dir	+ [0];
	_h = _h		+ [0];
	_b = _b 		+ ["Defense"];

	_v = _v		+ ["AGS30"];
	_n = _n		+ ["AGS_RU"];
	_d = _d		+ [getText (configFile >> "CfgVehicles" >> (_n select (count _n - 1)) >> "displayName")];
	_c = _c		+ [700];
	_t = _t		+ [0];
	_i = _i		+ ["\CA\Warfare2\Images\con_gl.paa"];
	_s = _s		+ ["StationaryDefense"];
	_dis = _dis	+ [0];
	_dir = _dir	+ [0];
	_h = _h		+ [0];
	_b = _b 		+ ["Defense"];

	_v = _v		+ ["SPG9_Ins"];
	_n = _n		+ ["SPG9_Ins"];
	_d = _d		+ [getText (configFile >> "CfgVehicles" >> (_n select (count _n - 1)) >> "displayName")];
	_c = _c		+ [800];
	_t = _t		+ [0];
	_i = _i		+ ["\CA\Warfare2\Images\con_at_pod.paa"];
	_s = _s		+ ["StationaryDefense"];
	_dis = _dis	+ [0];
	_dir = _dir	+ [0];
	_h = _h		+ [0];
	_b = _b 		+ ["Defense"];

	_v = _v		+ ["ATTripod"];
	_n = _n		+ ["Metis"];
	//--- Russian Localization Hotfix.
	_d = _d		+ ["Metis-M 9K115-2"];
	_c = _c		+ [800];
	_t = _t		+ [0];
	_i = _i		+ ["\CA\Warfare2\Images\con_at_pod.paa"];
	_s = _s		+ ["StationaryDefense"];
	_dis = _dis	+ [0];
	_dir = _dir	+ [0];
	_h = _h		+ [0];
	_b = _b 		+ ["Defense"];

	_v = _v		+ ["AATripod"];
	_n = _n		+ ["Igla_AA_pod_East"];
	//--- Russian Localization Hotfix.
	_d = _d 	+ ["Igla AA POD launcher"];
	_c = _c		+ [800];
	_t = _t		+ [0];
	_i = _i		+ ["\CA\Warfare2\Images\con_aa_pod.paa"];
	_s = _s		+ ["StationaryDefense"];
	_dis = _dis	+ [0];
	_dir = _dir	+ [0];
	_h = _h		+ [0];
	_b = _b 		+ ["Defense"];

	_v = _v		+ ["ZU23"];
	_n = _n		+ ["ZU23_Ins"];
	_d = _d		+ [getText (configFile >> "CfgVehicles" >> (_n select (count _n - 1)) >> "displayName")];
	_c = _c		+ [950];
	_t = _t		+ [0];
	_i = _i		+ ["\CA\Warfare2\Images\con_aa_pod.paa"];
	_s = _s		+ ["StationaryDefense"];
	_dis = _dis	+ [0];
	_dir = _dir	+ [0];
	_h = _h		+ [0];
	_b = _b 		+ ["Defense"];

	_v = _v		+ ["2b14_82mm"];
	_n = _n		+ ["2b14_82mm"];
	_d = _d		+ ["Podnos 2B14"];
	_c = _c		+ [1100];
	_t = _t		+ [0];
	_i = _i		+ ["\CA\Warfare2\Images\con_gun.paa"];
	_s = _s		+ ["StationaryDefense"];
	_dis = _dis	+ [0];
	_dir = _dir	+ [0];
	_h = _h		+ [0];
	_b = _b 		+ ["Defense"];

	_v = _v		+ ["D30"];
	_n = _n		+ ["D30_RU"];
	_d = _d		+ [getText (configFile >> "CfgVehicles" >> (_n select (count _n - 1)) >> "displayName")];
	_c = _c		+ [2250];
	_t = _t		+ [0];
	_i = _i		+ ["\CA\Warfare2\Images\con_gun.paa"];
	_s = _s		+ ["StationaryDefense"];
	_dis = _dis	+ [0];
	_dir = _dir	+ [0];
	_h = _h		+ [0];
	_b = _b 		+ ["Defense"];

	_v = _v		+ ["SmallWall"];
	_n = _n		+ ["Land_HBarrier3"];
	_d = _d		+ [getText (configFile >> "CfgVehicles" >> (_n select (count _n - 1)) >> "displayName")];
	_c = _c		+ [20];
	_t = _t		+ [0];
	_i = _i		+ ["\CA\Warfare2\Images\con_wall1.paa"];
	_s = _s		+ ["StationaryDefense"];
	_dis = _dis	+ [0];
	_dir = _dir	+ [0];
	_h = _h		+ [0];
	_b = _b 		+ ["Fortification"];

	_v = _v		+ ["MediumWall"];
	_n = _n		+ ["Land_HBarrier5"];
	_d = _d		+ [getText (configFile >> "CfgVehicles" >> (_n select (count _n - 1)) >> "displayName")];
	_c = _c		+ [30];
	_t = _t		+ [0];
	_i = _i		+ ["\CA\Warfare2\Images\con_wall2.paa"];
	_s = _s		+ ["StationaryDefense"];
	_dis = _dis	+ [0];
	_dir = _dir	+ [0];
	_h = _h		+ [0];
	_b = _b 		+ ["Fortification"];

	_v = _v		+ ["LargeWall"];
	_n = _n		+ ["Land_HBarrier_large"];
	_d = _d		+ [getText (configFile >> "CfgVehicles" >> (_n select (count _n - 1)) >> "displayName")];
	_c = _c		+ [50];
	_t = _t		+ [0];
	_i = _i		+ ["\CA\Warfare2\Images\con_wall3.paa"];
	_s = _s		+ ["StationaryDefense"];
	_dis = _dis	+ [0];
	_dir = _dir	+ [0];
	_h = _h		+ [0];
	_b = _b 		+ ["Fortification"];

	_v = _v		+ ["Base_WarfareBBarrier5x"];
	_n = _n		+ ["Base_WarfareBBarrier5x"];
	_d = _d		+ [getText (configFile >> "CfgVehicles" >> (_n select (count _n - 1)) >> "displayName")];
	_c = _c		+ [15];
	_t = _t		+ [0];
	_i = _i		+ ["\CA\Warfare2\Images\con_wall3.paa"];
	_s = _s		+ ["StationaryDefense"];
	_dis = _dis	+ [0];
	_dir = _dir	+ [0];
	_h = _h		+ [0];
	_b = _b 		+ ["Fortification"];

	_v = _v		+ ["Base_WarfareBBarrier10x"];
	_n = _n		+ ["Base_WarfareBBarrier10x"];
	_d = _d		+ [getText (configFile >> "CfgVehicles" >> (_n select (count _n - 1)) >> "displayName")];
	_c = _c		+ [25];
	_t = _t		+ [0];
	_i = _i		+ ["\CA\Warfare2\Images\con_wall3.paa"];
	_s = _s		+ ["StationaryDefense"];
	_dis = _dis	+ [0];
	_dir = _dir	+ [0];
	_h = _h		+ [0];
	_b = _b 		+ ["Fortification"];

	_v = _v		+ ["Base_WarfareBBarrier10xTall"];
	_n = _n		+ ["Base_WarfareBBarrier10xTall"];
	_d = _d		+ [getText (configFile >> "CfgVehicles" >> (_n select (count _n - 1)) >> "displayName")];
	_c = _c		+ [50];
	_t = _t		+ [0];
	_i = _i		+ ["\CA\Warfare2\Images\con_wall3.paa"];
	_s = _s		+ ["StationaryDefense"];
	_dis = _dis	+ [0];
	_dir = _dir	+ [0];
	_h = _h		+ [0];
	_b = _b 		+ ["Fortification"];

	_v = _v		+ ["MASH"];
	_n = _n		+ ["MASH"];
	_d = _d		+ [getText (configFile >> "CfgVehicles" >> (_n select (count _n - 1)) >> "displayName")];
	_c = _c		+ [30];
	_t = _t		+ [0];
	_i = _i		+ ["\CA\Warfare2\Images\con_wall1.paa"];
	_s = _s		+ ["StationaryDefense"];
	_dis = _dis	+ [0];
	_dir = _dir	+ [0];
	_h = _h		+ [0];
	_b = _b 		+ ["Strategic"];

	_v = _v		+ ["Land_fort_bagfence_long"];
	_n = _n		+ ["Land_fort_bagfence_long"];
	_d = _d		+ [getText (configFile >> "CfgVehicles" >> (_n select (count _n - 1)) >> "displayName")];
	_c = _c		+ [10];
	_t = _t		+ [0];
	_i = _i		+ ["\CA\Warfare2\Images\con_wall1.paa"];
	_s = _s		+ ["StationaryDefense"];
	_dis = _dis	+ [0];
	_dir = _dir	+ [0];
	_h = _h		+ [0];
	_b = _b 		+ ["Fortification"];

	_v = _v		+ ["Land_fort_bagfence_corner"];
	_n = _n		+ ["Land_fort_bagfence_corner"];
	_d = _d		+ [getText (configFile >> "CfgVehicles" >> (_n select (count _n - 1)) >> "displayName")];
	_c = _c		+ [8];
	_t = _t		+ [0];
	_i = _i		+ ["\CA\Warfare2\Images\con_wall1.paa"];
	_s = _s		+ ["StationaryDefense"];
	_dis = _dis	+ [0];
	_dir = _dir	+ [0];
	_h = _h		+ [0];
	_b = _b 		+ ["Fortification"];

	_v = _v		+ ["Land_fort_bagfence_round"];
	_n = _n		+ ["Land_fort_bagfence_round"];
	_d = _d		+ [getText (configFile >> "CfgVehicles" >> (_n select (count _n - 1)) >> "displayName")];
	_c = _c		+ [12];
	_t = _t		+ [0];
	_i = _i		+ ["\CA\Warfare2\Images\con_wall1.paa"];
	_s = _s		+ ["StationaryDefense"];
	_dis = _dis	+ [0];
	_dir = _dir	+ [0];
	_h = _h		+ [0];
	_b = _b 		+ ["Fortification"];

	_v = _v		+ ["Land_fortified_nest_small"];
	_n = _n		+ ["Land_fortified_nest_small"];
	_d = _d		+ [getText (configFile >> "CfgVehicles" >> (_n select (count _n - 1)) >> "displayName")];
	_c = _c		+ [40];
	_t = _t		+ [0];
	_i = _i		+ ["\CA\Warfare2\Images\con_wall1.paa"];
	_s = _s		+ ["StationaryDefense"];
	_dis = _dis	+ [0];
	_dir = _dir	+ [0];
	_h = _h		+ [0];
	_b = _b 		+ ["Fortification"];

	_v = _v		+ ["Land_fortified_nest_big"];
	_n = _n		+ ["Land_fortified_nest_big"];
	_d = _d		+ [getText (configFile >> "CfgVehicles" >> (_n select (count _n - 1)) >> "displayName")];
	_c = _c		+ [100];
	_t = _t		+ [0];
	_i = _i		+ ["\CA\Warfare2\Images\con_wall1.paa"];
	_s = _s		+ ["StationaryDefense"];
	_dis = _dis	+ [0];
	_dir = _dir	+ [0];
	_h = _h		+ [0];
	_b = _b 		+ ["Fortification"];

	_v = _v		+ ["Land_Fort_Watchtower"];
	_n = _n		+ ["Land_Fort_Watchtower"];
	_d = _d		+ [getText (configFile >> "CfgVehicles" >> (_n select (count _n - 1)) >> "displayName")];
	_c = _c		+ [150];
	_t = _t		+ [0];
	_i = _i		+ ["\CA\Warfare2\Images\con_wall1.paa"];
	_s = _s		+ ["StationaryDefense"];
	_dis = _dis	+ [0];
	_dir = _dir	+ [0];
	_h = _h		+ [0];
	_b = _b 		+ ["Fortification"];

	_v = _v		+ ["Land_fort_rampart"];
	_n = _n		+ ["Land_fort_rampart"];
	_d = _d		+ [getText (configFile >> "CfgVehicles" >> (_n select (count _n - 1)) >> "displayName")];
	_c = _c		+ [30];
	_t = _t		+ [0];
	_i = _i		+ ["\CA\Warfare2\Images\con_wall1.paa"];
	_s = _s		+ ["StationaryDefense"];
	_dis = _dis	+ [0];
	_dir = _dir	+ [0];
	_h = _h		+ [0];
	_b = _b 		+ ["Fortification"];

	_v = _v		+ ["Land_fort_artillery_nest"];
	_n = _n		+ ["Land_fort_artillery_nest"];
	_d = _d		+ [getText (configFile >> "CfgVehicles" >> (_n select (count _n - 1)) >> "displayName")];
	_c = _c		+ [65];
	_t = _t		+ [0];
	_i = _i		+ ["\CA\Warfare2\Images\con_wall1.paa"];
	_s = _s		+ ["StationaryDefense"];
	_dis = _dis	+ [0];
	_dir = _dir	+ [0];
	_h = _h		+ [0];
	_b = _b 		+ ["Fortification"];

	_v = _v		+ ["Hhedgehog_concreteBig"];
	_n = _n		+ ["Hhedgehog_concreteBig"];
	_d = _d		+ [getText (configFile >> "CfgVehicles" >> (_n select (count _n - 1)) >> "displayName")];
	_c = _c		+ [95];
	_t = _t		+ [0];
	_i = _i		+ ["\CA\Warfare2\Images\con_wall1.paa"];
	_s = _s		+ ["StationaryDefense"];
	_dis = _dis	+ [0];
	_dir = _dir	+ [0];
	_h = _h		+ [0];
	_b = _b 		+ ["Fortification"];

	_v = _v		+ ["Hedgehog"];
	_n = _n		+ ["Hedgehog"];
	_d = _d		+ [getText (configFile >> "CfgVehicles" >> (_n select (count _n - 1)) >> "displayName")];
	_c = _c		+ [5];
	_t = _t		+ [0];
	_i = _i		+ ["\CA\Warfare2\Images\con_wall1.paa"];
	_s = _s		+ ["StationaryDefense"];
	_dis = _dis	+ [0];
	_dir = _dir	+ [0];
	_h = _h		+ [0];
	_b = _b 		+ ["Fortification"];

	_v = _v		+ ["Land_CamoNet"];
	_n = _n		+ ["Land_CamoNet_EAST"];
	_d = _d		+ [getText (configFile >> "CfgVehicles" >> (_n select (count _n - 1)) >> "displayName")];
	_c = _c		+ [35];
	_t = _t		+ [0];
	_i = _i		+ ["\CA\Warfare2\Images\con_wall1.paa"];
	_s = _s		+ ["StationaryDefense"];
	_dis = _dis	+ [0];
	_dir = _dir	+ [0];
	_h = _h		+ [0];
	_b = _b 		+ ["Strategic"];

	_v = _v		+ ["Land_CamoNetVar"];
	_n = _n		+ ["Land_CamoNetVar_EAST"];
	_d = _d		+ [getText (configFile >> "CfgVehicles" >> (_n select (count _n - 1)) >> "displayName")];
	_c = _c		+ [45];
	_t = _t		+ [0];
	_i = _i		+ ["\CA\Warfare2\Images\con_wall1.paa"];
	_s = _s		+ ["StationaryDefense"];
	_dis = _dis	+ [0];
	_dir = _dir	+ [0];
	_h = _h		+ [0];
	_b = _b 		+ ["Strategic"];

	_v = _v		+ ["Land_CamoNetB"];
	_n = _n		+ ["Land_CamoNetB_EAST"];
	_d = _d		+ [getText (configFile >> "CfgVehicles" >> (_n select (count _n - 1)) >> "displayName")];
	_c = _c		+ [55];
	_t = _t		+ [0];
	_i = _i		+ ["\CA\Warfare2\Images\con_wall1.paa"];
	_s = _s		+ ["StationaryDefense"];
	_dis = _dis	+ [0];
	_dir = _dir	+ [0];
	_h = _h		+ [0];
	_b = _b 		+ ["Strategic"];

	_v = _v		+ ["Sign_Danger"];
	_n = _n		+ ["Sign_Danger"];
	_d = _d		+ [localize 'STR_WF_Minefield'];
	_c = _c		+ [1200];
	_t = _t		+ [0];
	_i = _i		+ ["\CA\Warfare2\Images\con_wall1.paa"];
	_s = _s		+ ["StationaryDefense"];
	_dis = _dis	+ [0];
	_dir = _dir	+ [0];
	_h = _h		+ [0];
	_b = _b 		+ ["Strategic"];

	_v = _v		+ ["HeliH"];
	_n = _n		+ ["HeliH"];
	_d = _d		+ [getText (configFile >> "CfgVehicles" >> (_n select (count _n - 1)) >> "displayName")];
	_c = _c		+ [16];
	_t = _t		+ [0];
	_i = _i		+ ["\CA\Warfare2\Images\con_wall1.paa"];
	_s = _s		+ ["StationaryDefense"];
	_dis = _dis	+ [0];
	_dir = _dir	+ [0];
	_h = _h		+ [0];
	_b = _b 		+ ["Strategic"];

	_v = _v		+ ["RUOrdnanceBox"];
	_n = _n		+ ["RUOrdnanceBox"];
	_d = _d		+ [getText (configFile >> "CfgVehicles" >> (_n select (count _n - 1)) >> "displayName")];
	_c = _c		+ [850];
	_t = _t		+ [0];
	_i = _i		+ ["\CA\Warfare2\Images\con_wall1.paa"];
	_s = _s		+ ["StationaryDefense"];
	_dis = _dis	+ [0];
	_dir = _dir	+ [0];
	_h = _h		+ [0];
	_b = _b 		+ ["Ammo"];

	_v = _v		+ ["RUVehicleBox"];
	_n = _n		+ ["RUVehicleBox"];
	_d = _d		+ [getText (configFile >> "CfgVehicles" >> (_n select (count _n - 1)) >> "displayName")];
	_c = _c		+ [1200];
	_t = _t		+ [0];
	_i = _i		+ ["\CA\Warfare2\Images\con_wall1.paa"];
	_s = _s		+ ["StationaryDefense"];
	_dis = _dis	+ [0];
	_dir = _dir	+ [0];
	_h = _h		+ [0];
	_b = _b 		+ ["Ammo"];

	_v = _v		+ ["RUBasicAmmunitionBox"];
	_n = _n		+ ["RUBasicAmmunitionBox"];
	_d = _d		+ [getText (configFile >> "CfgVehicles" >> (_n select (count _n - 1)) >> "displayName")];
	_c = _c		+ [1950];
	_t = _t		+ [0];
	_i = _i		+ ["\CA\Warfare2\Images\con_wall1.paa"];
	_s = _s		+ ["StationaryDefense"];
	_dis = _dis	+ [0];
	_dir = _dir	+ [0];
	_h = _h		+ [0];
	_b = _b 		+ ["Ammo"];

	_v = _v		+ ["RUBasicWeaponsBox"];
	_n = _n		+ ["RUBasicWeaponsBox"];
	_d = _d		+ [getText (configFile >> "CfgVehicles" >> (_n select (count _n - 1)) >> "displayName")];
	_c = _c		+ [2975];
	_t = _t		+ [0];
	_i = _i		+ ["\CA\Warfare2\Images\con_wall1.paa"];
	_s = _s		+ ["StationaryDefense"];
	_dis = _dis	+ [0];
	_dir = _dir	+ [0];
	_h = _h		+ [0];
	_b = _b 		+ ["Ammo"];

	_v = _v		+ ["RULaunchersBox"];
	_n = _n		+ ["RULaunchersBox"];
	_d = _d		+ [getText (configFile >> "CfgVehicles" >> (_n select (count _n - 1)) >> "displayName")];
	_c = _c		+ [6250];
	_t = _t		+ [0];
	_i = _i		+ ["\CA\Warfare2\Images\con_wall1.paa"];
	_s = _s		+ ["StationaryDefense"];
	_dis = _dis	+ [0];
	_dir = _dir	+ [0];
	_h = _h		+ [0];
	_b = _b 		+ ["Ammo"];

	_v = _v		+ ["RUSpecialWeaponsBox"];
	_n = _n		+ ["RUSpecialWeaponsBox"];
	_d = _d		+ [getText (configFile >> "CfgVehicles" >> (_n select (count _n - 1)) >> "displayName")];
	_c = _c		+ [7500];
	_t = _t		+ [0];
	_i = _i		+ ["\CA\Warfare2\Images\con_wall1.paa"];
	_s = _s		+ ["StationaryDefense"];
	_dis = _dis	+ [0];
	_dir = _dir	+ [0];
	_h = _h		+ [0];
	_b = _b 		+ ["Ammo"];

	['WFBE_EASTDEFENSES',_v,true] Call SetNamespace;
	['WFBE_EASTDEFENSENAMES',_n,true] Call SetNamespace;
	['WFBE_EASTDEFENSEDESCRIPTIONS',_d,true] Call SetNamespace;
	['WFBE_EASTDEFENSECOSTS',_c,true] Call SetNamespace;
	['WFBE_EASTDEFENSETIMES',_t,true] Call SetNamespace;
	['WFBE_EASTDEFENSEIMAGES',_i,true] Call SetNamespace;
	['WFBE_EASTDEFENSEDISTANCES',_dis,true] Call SetNamespace;
	['WFBE_EASTDEFENSEDIRECTIONS',_dir,true] Call SetNamespace;
	['WFBE_EASTDEFENSESCRIPTS',_s,true] Call SetNamespace;
	['WFBE_EASTDEFENSEHEIGHTS',_h,true] Call SetNamespace;
	['WFBE_EASTDEFENSECATEGORIES',_b,true] Call SetNamespace;
	
	['WFBE_WESTCONSTRUCTIONSITE','USMC_WarfareBContructionSite',true] Call SetNamespace;
	['WFBE_EASTCONSTRUCTIONSITE','RU_WarfareBContructionSite',true] Call SetNamespace;
	
	//RESISTANCE STATIONARY DEFENSES
	_v			= ["MGNest"];
	_n			= ["GUE_WarfareBMGNest_PK"];
	_d			= [getText (configFile >> "CfgVehicles" >> (_n select (count _n - 1)) >> "displayName")];
	_c			= [300];
	_t			= [0];
	_i			= ["\CA\Warfare2\Images\con_mg_nest.paa"];
	_s			= ["StationaryDefense"];
	_dis		= [0];
	_dir		= [0];
	_h			= [0];

	['WFBE_RESISTANCEDEFENSES',_v,true] Call SetNamespace;
	['WFBE_RESISTANCEDEFENSENAMES',_n,true] Call SetNamespace;
	['WFBE_RESISTANCEDEFENSEDESCRIPTIONS',_d,true] Call SetNamespace;
	['WFBE_RESISTANCEDEFENSECOSTS',_c,true] Call SetNamespace;
	['WFBE_RESISTANCEDEFENSETIMES',_t,true] Call SetNamespace;
	['WFBE_RESISTANCEDEFENSEIMAGES',_i,true] Call SetNamespace;
	['WFBE_RESISTANCEDEFENSEDISTANCES',_dis,true] Call SetNamespace;
	['WFBE_RESISTANCEDEFENSEDIRECTIONS',_dir,true] Call SetNamespace;
	['WFBE_RESISTANCEDEFENSESCRIPTS',_s,true] Call SetNamespace;
	['WFBE_RESISTANCEDEFENSEHEIGHTS',_h,true] Call SetNamespace;
};

if (WF_A2_Arrowhead) then {
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
	_t			= [30];
	_i			= ["\CA\Warfare2\Images\con_hq.paa"];
	_s			= ["HQSite"];
	_dis		= [15];
	_dir		= [0];
	_h			= [3];

	_v = _v		+ ["Barracks"];
	_n = _n		+ [WESTBAR];
	_d = _d		+ [getText (configFile >> "CfgVehicles" >> (_n select (count _n - 1)) >> "displayName")];
	_c = _c		+ [200];
	_t = _t		+ [70];
	_i = _i		+ ["\CA\Warfare2\Images\con_barracks.paa"];
	_s = _s		+ ["SmallSite"];
	_dis = _dis	+ [18];
	_dir = _dir	+ [90];
	_h = _h		+ [3];

	_v = _v		+ ["Light"];
	_n = _n		+ [WESTLVF];
	_d = _d		+ [getText (configFile >> "CfgVehicles" >> (_n select (count _n - 1)) >> "displayName")];
	_c = _c		+ [600];
	_t = _t		+ [90];
	_i = _i		+ ["\CA\Warfare2\Images\con_light.paa"];
	_s = _s		+ ["MediumSite"];
	_dis = _dis	+ [20];
	_dir = _dir	+ [90];
	_h = _h		+ [4.5];

	_v = _v		+ ["CommandCenter"];
	_n = _n		+ [WESTCC];
	_d = _d		+ [localize "STR_WF_CommandCenter_USMC"];
	_c = _c		+ [1200];
	_t = _t		+ [110];
	_i = _i		+ ["\CA\Warfare2\Images\con_hq.paa"];
	_s = _s		+ ["SmallSite"];
	_dis = _dis	+ [20];
	_dir = _dir	+ [90];
	_h = _h		+ [4.5];

	_v = _v		+ ["Heavy"];
	_n = _n		+ [WESTHEAVY];
	_d = _d		+ [getText (configFile >> "CfgVehicles" >> (_n select (count _n - 1)) >> "displayName")];
	_c = _c		+ [2800];
	_t = _t		+ [130];
	_i = _i		+ ["\CA\Warfare2\Images\con_heavy.paa"];
	_s = _s		+ ["MediumSite"];
	_dis = _dis	+ [20];
	_dir = _dir	+ [90];
	_h = _h		+ [4];

	_v = _v		+ ["Aircraft"];
	_n = _n		+ [WESTAIR];
	_d = _d		+ [localize "STR_WF_AircraftFactory"];
	_c = _c		+ [4400];
	_t = _t		+ [150];
	_i = _i		+ ["\CA\Warfare2\Images\con_aircraft.paa"];
	_s = _s		+ ["SmallSite"];
	_dis = _dis	+ [31];
	_dir = _dir	+ [90];
	_h = _h		+ [5.5];

	_v = _v		+ ["ServicePoint"];
	_n = _n		+ [WESTSP];
	_d = _d		+ [localize "STR_WF_ServicePoint"];
	_c = _c		+ [700];
	_t = _t		+ [70];
	_i = _i		+ ["\CA\Warfare2\Images\con_light.paa"];
	_s = _s		+ ["SmallSite"];
	_dis = _dis	+ [21];
	_dir = _dir	+ [90];
	_h = _h		+ [5.5];

	if (AARadar) then {
		_v = _v		+ ["AARadar"];
		_n = _n		+ [WESTAAR];
		_d = _d		+ [getText (configFile >> "CfgVehicles" >> (_n select (count _n - 1)) >> "displayName")];
		_c = _c		+ [3200];
		_t = _t		+ [280];
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

	//Note that cost of defenses is in money instead of supplies.
	//WEST STATIONARY DEFENSES
	_v			= ["MGNest"];
	_n			= ["WarfareBMGNest_M240_US_EP1"];
	_d			= [getText (configFile >> "CfgVehicles" >> (_n select (count _n - 1)) >> "displayName")];
	_c			= [300];
	_t			= [0];
	_i			= ["\CA\Warfare2\Images\con_mg_nest.paa"];
	_s			= ["StationaryDefense"];
	_dis		= [0];
	_dir		= [0];
	_h			= [0];
	_b			= ["Defense"];

	_v = _v		+ ["M2HD"];
	_n = _n		+ ["M2HD_mini_TriPod_US_EP1"];
	_d = _d		+ [getText (configFile >> "CfgVehicles" >> (_n select (count _n - 1)) >> "displayName")];
	_c = _c		+ [200];
	_t = _t		+ [0];
	_i = _i		+ ["\CA\Warfare2\Images\con_gl.paa"];
	_s = _s		+ ["StationaryDefense"];
	_dis = _dis	+ [0];
	_dir = _dir	+ [0];
	_h = _h		+ [0];
	_b = _b 		+ ["Defense"];

	_v = _v		+ ["SearchLight"];
	_n = _n		+ ["SearchLight_US_EP1"];
	_d = _d		+ [getText (configFile >> "CfgVehicles" >> (_n select (count _n - 1)) >> "displayName")];
	_c = _c		+ [175];
	_t = _t		+ [0];
	_i = _i		+ ["\CA\Warfare2\Images\con_reflector.paa"];
	_s = _s		+ ["StationaryDefense"];
	_dis = _dis	+ [0];
	_dir = _dir	+ [0];
	_h = _h		+ [0];
	_b = _b 		+ ["Defense"];

	_v = _v		+ ["M2"];
	_n = _n		+ ["M2StaticMG_US_EP1"];
	_d = _d		+ [getText (configFile >> "CfgVehicles" >> (_n select (count _n - 1)) >> "displayName")];
	_c = _c		+ [225];
	_t = _t		+ [0];
	_i = _i		+ ["\CA\Warfare2\Images\con_gl.paa"];
	_s = _s		+ ["StationaryDefense"];
	_dis = _dis	+ [0];
	_dir = _dir	+ [0];
	_h = _h		+ [0];
	_b = _b 		+ ["Defense"];

	_v = _v		+ ["MK19"];
	_n = _n		+ ["MK19_TriPod_US_EP1"];
	_d = _d		+ [getText (configFile >> "CfgVehicles" >> (_n select (count _n - 1)) >> "displayName")];
	_c = _c		+ [700];
	_t = _t		+ [0];
	_i = _i		+ ["\CA\Warfare2\Images\con_gl.paa"];
	_s = _s		+ ["StationaryDefense"];
	_dis = _dis	+ [0];
	_dir = _dir	+ [0];
	_h = _h		+ [0];
	_b = _b 		+ ["Defense"];

	_v = _v		+ ["ATTripod"];
	_n = _n		+ ["TOW_TriPod"];
	_d = _d		+ [getText (configFile >> "CfgVehicles" >> (_n select (count _n - 1)) >> "displayName")];
	_c = _c		+ [800];
	_t = _t		+ [0];
	_i = _i		+ ["\CA\Warfare2\Images\con_at_pod.paa"];
	_s = _s		+ ["StationaryDefense"];
	_dis = _dis	+ [0];
	_dir = _dir	+ [0];
	_h = _h		+ [0];
	_b = _b 		+ ["Defense"];

	_v = _v		+ ["AATripod"];
	_n = _n		+ ["Stinger_Pod_US_EP1"];
	_d = _d		+ [getText (configFile >> "CfgVehicles" >> (_n select (count _n - 1)) >> "displayName")];
	_c = _c		+ [800];
	_t = _t		+ [0];
	_i = _i		+ ["\CA\Warfare2\Images\con_aa_pod.paa"];
	_s = _s		+ ["StationaryDefense"];
	_dis = _dis	+ [0];
	_dir = _dir	+ [0];
	_h = _h		+ [0];
	_b = _b 		+ ["Defense"];

	_v = _v		+ ["M252"];
	_n = _n		+ ["M252_US_EP1"];
	_d = _d		+ [getText (configFile >> "CfgVehicles" >> (_n select (count _n - 1)) >> "displayName")];
	_c = _c		+ [1100];
	_t = _t		+ [0];
	_i = _i		+ ["\CA\Warfare2\Images\con_gun.paa"];
	_s = _s		+ ["StationaryDefense"];
	_dis = _dis	+ [0];
	_dir = _dir	+ [0];
	_h = _h		+ [0];
	_b = _b 		+ ["Defense"];

	_v = _v		+ ["M119"];
	_n = _n		+ ["M119_US_EP1"];
	_d = _d		+ [getText (configFile >> "CfgVehicles" >> (_n select (count _n - 1)) >> "displayName")];
	_c = _c		+ [2250];
	_t = _t		+ [0];
	_i = _i		+ ["\CA\Warfare2\Images\con_gun.paa"];
	_s = _s		+ ["StationaryDefense"];
	_dis = _dis	+ [0];
	_dir = _dir	+ [0];
	_h = _h		+ [0];
	_b = _b 		+ ["Defense"];

	_v = _v		+ ["SmallWall"];
	_n = _n		+ ["Land_HBarrier3"];
	_d = _d		+ [getText (configFile >> "CfgVehicles" >> (_n select (count _n - 1)) >> "displayName")];
	_c = _c		+ [20];
	_t = _t		+ [0];
	_i = _i		+ ["\CA\Warfare2\Images\con_wall1.paa"];
	_s = _s		+ ["StationaryDefense"];
	_dis = _dis	+ [0];
	_dir = _dir	+ [0];
	_h = _h		+ [0];
	_b = _b 		+ ["Fortification"];

	_v = _v		+ ["MediumWall"];
	_n = _n		+ ["Land_HBarrier5"];
	_d = _d		+ [getText (configFile >> "CfgVehicles" >> (_n select (count _n - 1)) >> "displayName")];
	_c = _c		+ [30];
	_t = _t		+ [0];
	_i = _i		+ ["\CA\Warfare2\Images\con_wall2.paa"];
	_s = _s		+ ["StationaryDefense"];
	_dis = _dis	+ [0];
	_dir = _dir	+ [0];
	_h = _h		+ [0];
	_b = _b 		+ ["Fortification"];

	_v = _v		+ ["LargeWall"];
	_n = _n		+ ["Land_HBarrier_large"];
	_d = _d		+ [getText (configFile >> "CfgVehicles" >> (_n select (count _n - 1)) >> "displayName")];
	_c = _c		+ [50];
	_t = _t		+ [0];
	_i = _i		+ ["\CA\Warfare2\Images\con_wall3.paa"];
	_s = _s		+ ["StationaryDefense"];
	_dis = _dis	+ [0];
	_dir = _dir	+ [0];
	_h = _h		+ [0];
	_b = _b 		+ ["Fortification"];

	_v = _v		+ ["Base_WarfareBBarrier5x"];
	_n = _n		+ ["US_WarfareBBarrier5x_EP1"];
	_d = _d		+ [getText (configFile >> "CfgVehicles" >> (_n select (count _n - 1)) >> "displayName")];
	_c = _c		+ [15];
	_t = _t		+ [0];
	_i = _i		+ ["\CA\Warfare2\Images\con_wall3.paa"];
	_s = _s		+ ["StationaryDefense"];
	_dis = _dis	+ [0];
	_dir = _dir	+ [0];
	_h = _h		+ [0];
	_b = _b 		+ ["Fortification"];

	_v = _v		+ ["Base_WarfareBBarrier10x"];
	_n = _n		+ ["US_WarfareBBarrier10x_EP1"];
	_d = _d		+ [getText (configFile >> "CfgVehicles" >> (_n select (count _n - 1)) >> "displayName")];
	_c = _c		+ [25];
	_t = _t		+ [0];
	_i = _i		+ ["\CA\Warfare2\Images\con_wall3.paa"];
	_s = _s		+ ["StationaryDefense"];
	_dis = _dis	+ [0];
	_dir = _dir	+ [0];
	_h = _h		+ [0];
	_b = _b 		+ ["Fortification"];

	_v = _v		+ ["Base_WarfareBBarrier10xTall"];
	_n = _n		+ ["US_WarfareBBarrier10xTall_EP1"];
	_d = _d		+ [getText (configFile >> "CfgVehicles" >> (_n select (count _n - 1)) >> "displayName")];
	_c = _c		+ [50];
	_t = _t		+ [0];
	_i = _i		+ ["\CA\Warfare2\Images\con_wall3.paa"];
	_s = _s		+ ["StationaryDefense"];
	_dis = _dis	+ [0];
	_dir = _dir	+ [0];
	_h = _h		+ [0];
	_b = _b 		+ ["Fortification"];

	_v = _v		+ ["MASH"];
	_n = _n		+ ["MASH_EP1"];
	_d = _d		+ [getText (configFile >> "CfgVehicles" >> (_n select (count _n - 1)) >> "displayName")];
	_c = _c		+ [30];
	_t = _t		+ [0];
	_i = _i		+ ["\CA\Warfare2\Images\con_wall1.paa"];
	_s = _s		+ ["StationaryDefense"];
	_dis = _dis	+ [0];
	_dir = _dir	+ [0];
	_h = _h		+ [0];
	_b = _b 		+ ["Strategic"];

	_v = _v		+ ["Land_fort_bagfence_long"];
	_n = _n		+ ["Land_fort_bagfence_long"];
	_d = _d		+ [getText (configFile >> "CfgVehicles" >> (_n select (count _n - 1)) >> "displayName")];
	_c = _c		+ [10];
	_t = _t		+ [0];
	_i = _i		+ ["\CA\Warfare2\Images\con_wall1.paa"];
	_s = _s		+ ["StationaryDefense"];
	_dis = _dis	+ [0];
	_dir = _dir	+ [0];
	_h = _h		+ [0];
	_b = _b 		+ ["Fortification"];

	_v = _v		+ ["Land_fort_bagfence_corner"];
	_n = _n		+ ["Land_fort_bagfence_corner"];
	_d = _d		+ [getText (configFile >> "CfgVehicles" >> (_n select (count _n - 1)) >> "displayName")];
	_c = _c		+ [8];
	_t = _t		+ [0];
	_i = _i		+ ["\CA\Warfare2\Images\con_wall1.paa"];
	_s = _s		+ ["StationaryDefense"];
	_dis = _dis	+ [0];
	_dir = _dir	+ [0];
	_h = _h		+ [0];
	_b = _b 		+ ["Fortification"];

	_v = _v		+ ["Land_fort_bagfence_round"];
	_n = _n		+ ["Land_fort_bagfence_round"];
	_d = _d		+ [getText (configFile >> "CfgVehicles" >> (_n select (count _n - 1)) >> "displayName")];
	_c = _c		+ [12];
	_t = _t		+ [0];
	_i = _i		+ ["\CA\Warfare2\Images\con_wall1.paa"];
	_s = _s		+ ["StationaryDefense"];
	_dis = _dis	+ [0];
	_dir = _dir	+ [0];
	_h = _h		+ [0];
	_b = _b 		+ ["Fortification"];

	_v = _v		+ ["Land_fortified_nest_small"];
	_n = _n		+ ["Land_fortified_nest_small_EP1"];
	_d = _d		+ [getText (configFile >> "CfgVehicles" >> (_n select (count _n - 1)) >> "displayName")];
	_c = _c		+ [40];
	_t = _t		+ [0];
	_i = _i		+ ["\CA\Warfare2\Images\con_wall1.paa"];
	_s = _s		+ ["StationaryDefense"];
	_dis = _dis	+ [0];
	_dir = _dir	+ [0];
	_h = _h		+ [0];
	_b = _b 		+ ["Fortification"];

	_v = _v		+ ["Land_fort_rampart"];
	_n = _n		+ ["Land_fort_rampart_EP1"];
	_d = _d		+ [getText (configFile >> "CfgVehicles" >> (_n select (count _n - 1)) >> "displayName")];
	_c = _c		+ [30];
	_t = _t		+ [0];
	_i = _i		+ ["\CA\Warfare2\Images\con_wall1.paa"];
	_s = _s		+ ["StationaryDefense"];
	_dis = _dis	+ [0];
	_dir = _dir	+ [0];
	_h = _h		+ [0];
	_b = _b 		+ ["Fortification"];

	_v = _v		+ ["Land_fort_artillery_nest"];
	_n = _n		+ ["Land_fort_artillery_nest_EP1"];
	_d = _d		+ [localize "STR_WF_ArtilleryNest"];
	_c = _c		+ [65];
	_t = _t		+ [0];
	_i = _i		+ ["\CA\Warfare2\Images\con_wall1.paa"];
	_s = _s		+ ["StationaryDefense"];
	_dis = _dis	+ [0];
	_dir = _dir	+ [0];
	_h = _h		+ [0];
	_b = _b 		+ ["Fortification"];

	_v = _v		+ ["Hhedgehog_concreteBig"];
	_n = _n		+ ["Hhedgehog_concreteBig"];
	_d = _d		+ [getText (configFile >> "CfgVehicles" >> (_n select (count _n - 1)) >> "displayName")];
	_c = _c		+ [95];
	_t = _t		+ [0];
	_i = _i		+ ["\CA\Warfare2\Images\con_wall1.paa"];
	_s = _s		+ ["StationaryDefense"];
	_dis = _dis	+ [0];
	_dir = _dir	+ [0];
	_h = _h		+ [0];
	_b = _b 		+ ["Fortification"];

	_v = _v		+ ["Hedgehog"];
	_n = _n		+ ["Hedgehog_EP1"];
	_d = _d		+ [getText (configFile >> "CfgVehicles" >> (_n select (count _n - 1)) >> "displayName")];
	_c = _c		+ [5];
	_t = _t		+ [0];
	_i = _i		+ ["\CA\Warfare2\Images\con_wall1.paa"];
	_s = _s		+ ["StationaryDefense"];
	_dis = _dis	+ [0];
	_dir = _dir	+ [0];
	_h = _h		+ [0];
	_b = _b 		+ ["Fortification"];

	_v = _v		+ ["Land_CamoNet"];
	_n = _n		+ ["Land_CamoNet_NATO_EP1"];
	_d = _d		+ [getText (configFile >> "CfgVehicles" >> (_n select (count _n - 1)) >> "displayName")];
	_c = _c		+ [35];
	_t = _t		+ [0];
	_i = _i		+ ["\CA\Warfare2\Images\con_wall1.paa"];
	_s = _s		+ ["StationaryDefense"];
	_dis = _dis	+ [0];
	_dir = _dir	+ [0];
	_h = _h		+ [0];
	_b = _b 		+ ["Strategic"];

	_v = _v		+ ["Land_CamoNetVar"];
	_n = _n		+ ["Land_CamoNetVar_NATO_EP1"];
	_d = _d		+ [getText (configFile >> "CfgVehicles" >> (_n select (count _n - 1)) >> "displayName")];
	_c = _c		+ [45];
	_t = _t		+ [0];
	_i = _i		+ ["\CA\Warfare2\Images\con_wall1.paa"];
	_s = _s		+ ["StationaryDefense"];
	_dis = _dis	+ [0];
	_dir = _dir	+ [0];
	_h = _h		+ [0];
	_b = _b 		+ ["Strategic"];

	_v = _v		+ ["Land_CamoNetB"];
	_n = _n		+ ["Land_CamoNetB_NATO_EP1"];
	_d = _d		+ [getText (configFile >> "CfgVehicles" >> (_n select (count _n - 1)) >> "displayName")];
	_c = _c		+ [55];
	_t = _t		+ [0];
	_i = _i		+ ["\CA\Warfare2\Images\con_wall1.paa"];
	_s = _s		+ ["StationaryDefense"];
	_dis = _dis	+ [0];
	_dir = _dir	+ [0];
	_h = _h		+ [0];
	_b = _b 		+ ["Strategic"];

	_v = _v		+ ["Sign_Danger"];
	_n = _n		+ ["Sign_Danger"];
	_d = _d		+ [localize 'STR_WF_Minefield'];
	_c = _c		+ [1200];
	_t = _t		+ [0];
	_i = _i		+ ["\CA\Warfare2\Images\con_wall1.paa"];
	_s = _s		+ ["StationaryDefense"];
	_dis = _dis	+ [0];
	_dir = _dir	+ [0];
	_h = _h		+ [0];
	_b = _b 		+ ["Strategic"];

	_v = _v		+ ["HeliH"];
	_n = _n		+ ["HeliH"];
	_d = _d		+ [getText (configFile >> "CfgVehicles" >> (_n select (count _n - 1)) >> "displayName")];
	_c = _c		+ [16];
	_t = _t		+ [0];
	_i = _i		+ ["\CA\Warfare2\Images\con_wall1.paa"];
	_s = _s		+ ["StationaryDefense"];
	_dis = _dis	+ [0];
	_dir = _dir	+ [0];
	_h = _h		+ [0];
	_b = _b 		+ ["Strategic"];

	_v = _v		+ ["USOrdnanceBox"];
	_n = _n		+ ["USOrdnanceBox_EP1"];
	_d = _d		+ [getText (configFile >> "CfgVehicles" >> (_n select (count _n - 1)) >> "displayName")];
	_c = _c		+ [850];
	_t = _t		+ [0];
	_i = _i		+ ["\CA\Warfare2\Images\con_wall1.paa"];
	_s = _s		+ ["StationaryDefense"];
	_dis = _dis	+ [0];
	_dir = _dir	+ [0];
	_h = _h		+ [0];
	_b = _b 		+ ["Ammo"];

	_v = _v		+ ["USVehicleBox"];
	_n = _n		+ ["USVehicleBox_EP1"];
	_d = _d		+ [getText (configFile >> "CfgVehicles" >> (_n select (count _n - 1)) >> "displayName")];
	_c = _c		+ [1200];
	_t = _t		+ [0];
	_i = _i		+ ["\CA\Warfare2\Images\con_wall1.paa"];
	_s = _s		+ ["StationaryDefense"];
	_dis = _dis	+ [0];
	_dir = _dir	+ [0];
	_h = _h		+ [0];
	_b = _b 		+ ["Ammo"];

	_v = _v		+ ["USBasicAmmunitionBox"];
	_n = _n		+ ["USBasicAmmunitionBox_EP1"];
	_d = _d		+ [getText (configFile >> "CfgVehicles" >> (_n select (count _n - 1)) >> "displayName")];
	_c = _c		+ [1950];
	_t = _t		+ [0];
	_i = _i		+ ["\CA\Warfare2\Images\con_wall1.paa"];
	_s = _s		+ ["StationaryDefense"];
	_dis = _dis	+ [0];
	_dir = _dir	+ [0];
	_h = _h		+ [0];
	_b = _b 		+ ["Ammo"];

	_v = _v		+ ["USBasicWeaponsBox"];
	_n = _n		+ ["USBasicWeapons_EP1"];
	_d = _d		+ [getText (configFile >> "CfgVehicles" >> (_n select (count _n - 1)) >> "displayName")];
	_c = _c		+ [2975];
	_t = _t		+ [0];
	_i = _i		+ ["\CA\Warfare2\Images\con_wall1.paa"];
	_s = _s		+ ["StationaryDefense"];
	_dis = _dis	+ [0];
	_dir = _dir	+ [0];
	_h = _h		+ [0];
	_b = _b 		+ ["Ammo"];

	_v = _v		+ ["USLaunchersBox"];
	_n = _n		+ ["USLaunchers_EP1"];
	_d = _d		+ [getText (configFile >> "CfgVehicles" >> (_n select (count _n - 1)) >> "displayName")];
	_c = _c		+ [6250];
	_t = _t		+ [0];
	_i = _i		+ ["\CA\Warfare2\Images\con_wall1.paa"];
	_s = _s		+ ["StationaryDefense"];
	_dis = _dis	+ [0];
	_dir = _dir	+ [0];
	_h = _h		+ [0];
	_b = _b 		+ ["Ammo"];

	_v = _v		+ ["USSpecialWeaponsBox"];
	_n = _n		+ ["USSpecialWeapons_EP1"];
	_d = _d		+ [getText (configFile >> "CfgVehicles" >> (_n select (count _n - 1)) >> "displayName")];
	_c = _c		+ [7500];
	_t = _t		+ [0];
	_i = _i		+ ["\CA\Warfare2\Images\con_wall1.paa"];
	_s = _s		+ ["StationaryDefense"];
	_dis = _dis	+ [0];
	_dir = _dir	+ [0];
	_h = _h		+ [0];
	_b = _b 		+ ["Ammo"];

	['WFBE_WESTDEFENSES',_v,true] Call SetNamespace;
	['WFBE_WESTDEFENSENAMES',_n,true] Call SetNamespace;
	['WFBE_WESTDEFENSEDESCRIPTIONS',_d,true] Call SetNamespace;
	['WFBE_WESTDEFENSECOSTS',_c,true] Call SetNamespace;
	['WFBE_WESTDEFENSETIMES',_t,true] Call SetNamespace;
	['WFBE_WESTDEFENSEIMAGES',_i,true] Call SetNamespace;
	['WFBE_WESTDEFENSEDISTANCES',_dis,true] Call SetNamespace;
	['WFBE_WESTDEFENSEDIRECTIONS',_dir,true] Call SetNamespace;
	['WFBE_WESTDEFENSESCRIPTS',_s,true] Call SetNamespace;
	['WFBE_WESTDEFENSEHEIGHTS',_h,true] Call SetNamespace;
	['WFBE_WESTDEFENSECATEGORIES',_b,true] Call SetNamespace;

	//EAST STRUCTURES
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
	_t			= [30];
	_i			= ["\CA\Warfare2\Images\con_hq.paa"];
	_s			= ["HQSite"];
	_dis		= [15];
	_dir		= [0];
	_h			= [3];

	_v = _v		+ ["Barracks"];
	_n = _n		+ [EASTBAR];
	_d = _d		+ [getText (configFile >> "CfgVehicles" >> (_n select (count _n - 1)) >> "displayName")];
	_c = _c		+ [200];
	_t = _t		+ [70];
	_i = _i		+ ["\CA\Warfare2\Images\con_barracks.paa"];
	_s = _s		+ ["SmallSite"];
	_dis = _dis	+ [18];
	_dir = _dir	+ [90];
	_h = _h		+ [3];

	_v = _v		+ ["Light"];
	_n = _n		+ [EASTLVF];
	_d = _d		+ [getText (configFile >> "CfgVehicles" >> (_n select (count _n - 1)) >> "displayName")];
	_c = _c		+ [600];
	_t = _t		+ [90];
	_i = _i		+ ["\CA\Warfare2\Images\con_light.paa"];
	_s = _s		+ ["MediumSite"];
	_dis = _dis	+ [20];
	_dir = _dir	+ [90];
	_h = _h		+ [4.5];

	_v = _v		+ ["CommandCenter"];
	_n = _n		+ [EASTCC];
	_d = _d		+ [localize "STR_WF_CommandCenter_RU"];
	_c = _c		+ [1200];
	_t = _t		+ [110];
	_i = _i		+ ["\CA\Warfare2\Images\con_hq.paa"];
	_s = _s		+ ["SmallSite"];

	_dis = _dis	+ [20];
	_dir = _dir	+ [90];
	_h = _h		+ [4.5];

	_v = _v		+ ["Heavy"];
	_n = _n		+ [EASTHEAVY];
	_d = _d		+ [getText (configFile >> "CfgVehicles" >> (_n select (count _n - 1)) >> "displayName")];
	_c = _c		+ [2800];
	_t = _t		+ [130];
	_i = _i		+ ["\CA\Warfare2\Images\con_heavy.paa"];
	_s = _s		+ ["MediumSite"];
	_dis = _dis	+ [20];
	_dir = _dir	+ [90];
	_h = _h		+ [4];

	_v = _v		+ ["Aircraft"];
	_n = _n		+ [EASTAIR];
	_d = _d		+ [localize "STR_WF_AircraftFactory"];
	_c = _c		+ [4400];
	_t = _t		+ [150];
	_i = _i		+ ["\CA\Warfare2\Images\con_aircraft.paa"];
	_s = _s		+ ["SmallSite"];
	_dis = _dis	+ [21];
	_dir = _dir	+ [90];
	_h = _h		+ [5.5];

	_v = _v		+ ["ServicePoint"];
	_n = _n		+ [EASTSP];
	_d = _d		+ [localize "STR_WF_ServicePoint"];
	_c = _c		+ [700];
	_t = _t		+ [70];
	_i = _i		+ ["\CA\Warfare2\Images\con_light.paa"];
	_s = _s		+ ["SmallSite"];
	_dis = _dis	+ [21];
	_dir = _dir	+ [90];
	_h = _h		+ [5.5];

	if (AARadar) then {
		_v = _v		+ ["AARadar"];
		_n = _n		+ [EASTAAR];
		_d = _d		+ [getText (configFile >> "CfgVehicles" >> (_n select (count _n - 1)) >> "displayName")];
		_c = _c		+ [3200];
		_t = _t		+ [280];
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

	//Note that cost of defenses is in money instead of supplies.
	//EAST STATIONARY DEFENSES
	_v			= ["MGNest"];
	_n			= ["WarfareBMGNest_PK_TK_EP1"];
	_d			= [getText (configFile >> "CfgVehicles" >> (_n select (count _n - 1)) >> "displayName")];
	_c			= [300];
	_t			= [0];
	_i			= ["\CA\Warfare2\Images\con_mg_nest.paa"];
	_s			= ["StationaryDefense"];
	_dis		= [0];
	_dir		= [0];
	_h			= [0];
	_b			= ["Defense"];

	_v = _v		+ ["SearchLight"];
	_n = _n		+ ["SearchLight_TK_EP1"];
	_d = _d		+ [getText (configFile >> "CfgVehicles" >> (_n select (count _n - 1)) >> "displayName")];
	_c = _c		+ [175];
	_t = _t		+ [0];
	_i = _i		+ ["\CA\Warfare2\Images\con_reflector.paa"];
	_s = _s		+ ["StationaryDefense"];
	_dis = _dis	+ [0];
	_dir = _dir	+ [0];
	_h = _h		+ [0];
	_b = _b 		+ ["Defense"];

	_v = _v		+ ["KORD"];
	_n = _n		+ ["KORD_TK_EP1"];
	//--- Russian Localization Hotfix.
	_d = _d		+ ["KORD Minitripod"];
	_c = _c		+ [250];
	_t = _t		+ [0];
	_i = _i		+ ["\CA\Warfare2\Images\con_gl.paa"];
	_s = _s		+ ["StationaryDefense"];
	_dis = _dis	+ [0];
	_dir = _dir	+ [0];
	_h = _h		+ [0];
	_b = _b 		+ ["Defense"];

	_v = _v		+ ["KORD_high"];
	_n = _n		+ ["KORD_high_TK_EP1"];
	//--- Russian Localization Hotfix.
	_d = _d		+ ["KORD"];
	_c = _c		+ [300];
	_t = _t		+ [0];
	_i = _i		+ ["\CA\Warfare2\Images\con_gl.paa"];
	_s = _s		+ ["StationaryDefense"];
	_dis = _dis	+ [0];
	_dir = _dir	+ [0];
	_h = _h		+ [0];
	_b = _b 		+ ["Defense"];

	_v = _v		+ ["AGS30"];
	_n = _n		+ ["AGS_TK_EP1"];
	_d = _d		+ [getText (configFile >> "CfgVehicles" >> (_n select (count _n - 1)) >> "displayName")];
	_c = _c		+ [700];
	_t = _t		+ [0];
	_i = _i		+ ["\CA\Warfare2\Images\con_gl.paa"];
	_s = _s		+ ["StationaryDefense"];
	_dis = _dis	+ [0];
	_dir = _dir	+ [0];
	_h = _h		+ [0];
	_b = _b 		+ ["Defense"];

	_v = _v		+ ["SPG9_Ins"];
	_n = _n		+ ["SPG9_TK_INS_EP1"];
	_d = _d		+ [getText (configFile >> "CfgVehicles" >> (_n select (count _n - 1)) >> "displayName")];
	_c = _c		+ [800];
	_t = _t		+ [0];
	_i = _i		+ ["\CA\Warfare2\Images\con_at_pod.paa"];
	_s = _s		+ ["StationaryDefense"];
	_dis = _dis	+ [0];
	_dir = _dir	+ [0];
	_h = _h		+ [0];
	_b = _b 		+ ["Defense"];

	_v = _v		+ ["ATTripod"];
	_n = _n		+ ["Metis_TK_EP1"];
	//--- Russian Localization Hotfix.
	_d = _d		+ ["Metis-M 9K115-2"];
	_c = _c		+ [800];
	_t = _t		+ [0];
	_i = _i		+ ["\CA\Warfare2\Images\con_at_pod.paa"];
	_s = _s		+ ["StationaryDefense"];
	_dis = _dis	+ [0];
	_dir = _dir	+ [0];
	_h = _h		+ [0];
	_b = _b 		+ ["Defense"];

	_v = _v		+ ["AATripod"];
	_n = _n		+ ["Igla_AA_pod_TK_EP1"];
	//--- Russian Localization Hotfix.
	_d = _d 	+ ["Igla AA POD launcher"];
	_c = _c		+ [800];
	_t = _t		+ [0];
	_i = _i		+ ["\CA\Warfare2\Images\con_aa_pod.paa"];
	_s = _s		+ ["StationaryDefense"];
	_dis = _dis	+ [0];
	_dir = _dir	+ [0];
	_h = _h		+ [0];
	_b = _b 		+ ["Defense"];

	_v = _v		+ ["ZU23"];
	_n = _n		+ ["ZU23_TK_EP1"];
	_d = _d		+ [getText (configFile >> "CfgVehicles" >> (_n select (count _n - 1)) >> "displayName")];
	_c = _c		+ [950];
	_t = _t		+ [0];
	_i = _i		+ ["\CA\Warfare2\Images\con_aa_pod.paa"];
	_s = _s		+ ["StationaryDefense"];
	_dis = _dis	+ [0];
	_dir = _dir	+ [0];
	_h = _h		+ [0];
	_b = _b 		+ ["Defense"];

	_v = _v		+ ["2b14_82mm"];
	_n = _n		+ ["2b14_82mm_TK_EP1"];
	_d = _d		+ ["Podnos 2B14"];
	_c = _c		+ [1100];
	_t = _t		+ [0];
	_i = _i		+ ["\CA\Warfare2\Images\con_gun.paa"];
	_s = _s		+ ["StationaryDefense"];
	_dis = _dis	+ [0];
	_dir = _dir	+ [0];
	_h = _h		+ [0];
	_b = _b 		+ ["Defense"];

	_v = _v		+ ["D30"];
	_n = _n		+ ["D30_TK_EP1"];
	_d = _d		+ [getText (configFile >> "CfgVehicles" >> (_n select (count _n - 1)) >> "displayName")];
	_c = _c		+ [2250];
	_t = _t		+ [0];
	_i = _i		+ ["\CA\Warfare2\Images\con_gun.paa"];
	_s = _s		+ ["StationaryDefense"];
	_dis = _dis	+ [0];
	_dir = _dir	+ [0];
	_h = _h		+ [0];
	_b = _b 		+ ["Defense"];

	_v = _v		+ ["SmallWall"];
	_n = _n		+ ["Land_HBarrier3"];
	_d = _d		+ [getText (configFile >> "CfgVehicles" >> (_n select (count _n - 1)) >> "displayName")];
	_c = _c		+ [20];
	_t = _t		+ [0];
	_i = _i		+ ["\CA\Warfare2\Images\con_wall1.paa"];
	_s = _s		+ ["StationaryDefense"];
	_dis = _dis	+ [0];
	_dir = _dir	+ [0];
	_h = _h		+ [0];
	_b = _b 		+ ["Fortification"];

	_v = _v		+ ["MediumWall"];
	_n = _n		+ ["Land_HBarrier5"];
	_d = _d		+ [getText (configFile >> "CfgVehicles" >> (_n select (count _n - 1)) >> "displayName")];
	_c = _c		+ [30];
	_t = _t		+ [0];
	_i = _i		+ ["\CA\Warfare2\Images\con_wall2.paa"];
	_s = _s		+ ["StationaryDefense"];
	_dis = _dis	+ [0];
	_dir = _dir	+ [0];
	_h = _h		+ [0];
	_b = _b 		+ ["Fortification"];

	_v = _v		+ ["LargeWall"];
	_n = _n		+ ["Land_HBarrier_large"];
	_d = _d		+ [getText (configFile >> "CfgVehicles" >> (_n select (count _n - 1)) >> "displayName")];
	_c = _c		+ [50];
	_t = _t		+ [0];
	_i = _i		+ ["\CA\Warfare2\Images\con_wall3.paa"];
	_s = _s		+ ["StationaryDefense"];
	_dis = _dis	+ [0];
	_dir = _dir	+ [0];
	_h = _h		+ [0];
	_b = _b 		+ ["Fortification"];

	_v = _v		+ ["Base_WarfareBBarrier5x"];
	_n = _n		+ ["TK_WarfareBBarrier5x_EP1"];
	_d = _d		+ [getText (configFile >> "CfgVehicles" >> (_n select (count _n - 1)) >> "displayName")];
	_c = _c		+ [15];
	_t = _t		+ [0];
	_i = _i		+ ["\CA\Warfare2\Images\con_wall3.paa"];
	_s = _s		+ ["StationaryDefense"];
	_dis = _dis	+ [0];
	_dir = _dir	+ [0];
	_h = _h		+ [0];
	_b = _b 		+ ["Fortification"];

	_v = _v		+ ["Base_WarfareBBarrier10x"];
	_n = _n		+ ["TK_WarfareBBarrier10x_EP1"];
	_d = _d		+ [getText (configFile >> "CfgVehicles" >> (_n select (count _n - 1)) >> "displayName")];
	_c = _c		+ [25];
	_t = _t		+ [0];
	_i = _i		+ ["\CA\Warfare2\Images\con_wall3.paa"];
	_s = _s		+ ["StationaryDefense"];
	_dis = _dis	+ [0];
	_dir = _dir	+ [0];
	_h = _h		+ [0];
	_b = _b 		+ ["Fortification"];

	_v = _v		+ ["Base_WarfareBBarrier10xTall"];
	_n = _n		+ ["TK_WarfareBBarrier10xTall_EP1"];
	_d = _d		+ [getText (configFile >> "CfgVehicles" >> (_n select (count _n - 1)) >> "displayName")];
	_c = _c		+ [50];
	_t = _t		+ [0];
	_i = _i		+ ["\CA\Warfare2\Images\con_wall3.paa"];
	_s = _s		+ ["StationaryDefense"];
	_dis = _dis	+ [0];
	_dir = _dir	+ [0];
	_h = _h		+ [0];
	_b = _b 		+ ["Fortification"];

	_v = _v		+ ["MASH"];
	_n = _n		+ ["MASH_EP1"];
	_d = _d		+ [getText (configFile >> "CfgVehicles" >> (_n select (count _n - 1)) >> "displayName")];
	_c = _c		+ [30];
	_t = _t		+ [0];
	_i = _i		+ ["\CA\Warfare2\Images\con_wall1.paa"];
	_s = _s		+ ["StationaryDefense"];
	_dis = _dis	+ [0];
	_dir = _dir	+ [0];
	_h = _h		+ [0];
	_b = _b 		+ ["Strategic"];

	_v = _v		+ ["Land_fort_bagfence_long"];
	_n = _n		+ ["Land_fort_bagfence_long"];
	_d = _d		+ [getText (configFile >> "CfgVehicles" >> (_n select (count _n - 1)) >> "displayName")];
	_c = _c		+ [10];
	_t = _t		+ [0];
	_i = _i		+ ["\CA\Warfare2\Images\con_wall1.paa"];
	_s = _s		+ ["StationaryDefense"];
	_dis = _dis	+ [0];
	_dir = _dir	+ [0];
	_h = _h		+ [0];
	_b = _b 		+ ["Fortification"];

	_v = _v		+ ["Land_fort_bagfence_corner"];
	_n = _n		+ ["Land_fort_bagfence_corner"];
	_d = _d		+ [getText (configFile >> "CfgVehicles" >> (_n select (count _n - 1)) >> "displayName")];
	_c = _c		+ [8];
	_t = _t		+ [0];
	_i = _i		+ ["\CA\Warfare2\Images\con_wall1.paa"];
	_s = _s		+ ["StationaryDefense"];
	_dis = _dis	+ [0];
	_dir = _dir	+ [0];
	_h = _h		+ [0];
	_b = _b 		+ ["Fortification"];

	_v = _v		+ ["Land_fort_bagfence_round"];
	_n = _n		+ ["Land_fort_bagfence_round"];
	_d = _d		+ [getText (configFile >> "CfgVehicles" >> (_n select (count _n - 1)) >> "displayName")];
	_c = _c		+ [12];
	_t = _t		+ [0];
	_i = _i		+ ["\CA\Warfare2\Images\con_wall1.paa"];
	_s = _s		+ ["StationaryDefense"];
	_dis = _dis	+ [0];
	_dir = _dir	+ [0];
	_h = _h		+ [0];
	_b = _b 		+ ["Fortification"];

	_v = _v		+ ["Land_fortified_nest_small"];
	_n = _n		+ ["Land_fortified_nest_small_EP1"];
	_d = _d		+ [getText (configFile >> "CfgVehicles" >> (_n select (count _n - 1)) >> "displayName")];
	_c = _c		+ [40];
	_t = _t		+ [0];
	_i = _i		+ ["\CA\Warfare2\Images\con_wall1.paa"];
	_s = _s		+ ["StationaryDefense"];
	_dis = _dis	+ [0];
	_dir = _dir	+ [0];
	_h = _h		+ [0];
	_b = _b 		+ ["Fortification"];

	_v = _v		+ ["Land_fort_rampart"];
	_n = _n		+ ["Land_fort_rampart_EP1"];
	_d = _d		+ [getText (configFile >> "CfgVehicles" >> (_n select (count _n - 1)) >> "displayName")];
	_c = _c		+ [30];
	_t = _t		+ [0];
	_i = _i		+ ["\CA\Warfare2\Images\con_wall1.paa"];
	_s = _s		+ ["StationaryDefense"];
	_dis = _dis	+ [0];
	_dir = _dir	+ [0];
	_h = _h		+ [0];
	_b = _b 		+ ["Fortification"];

	_v = _v		+ ["Land_fort_artillery_nest"];
	_n = _n		+ ["Land_fort_artillery_nest_EP1"];
	_d = _d		+ [localize "STR_WF_ArtilleryNest"];
	_c = _c		+ [65];
	_t = _t		+ [0];
	_i = _i		+ ["\CA\Warfare2\Images\con_wall1.paa"];
	_s = _s		+ ["StationaryDefense"];
	_dis = _dis	+ [0];
	_dir = _dir	+ [0];
	_h = _h		+ [0];
	_b = _b 		+ ["Fortification"];

	_v = _v		+ ["Hhedgehog_concreteBig"];
	_n = _n		+ ["Hhedgehog_concreteBig"];
	_d = _d		+ [getText (configFile >> "CfgVehicles" >> (_n select (count _n - 1)) >> "displayName")];
	_c = _c		+ [95];
	_t = _t		+ [0];
	_i = _i		+ ["\CA\Warfare2\Images\con_wall1.paa"];
	_s = _s		+ ["StationaryDefense"];
	_dis = _dis	+ [0];
	_dir = _dir	+ [0];
	_h = _h		+ [0];
	_b = _b 		+ ["Fortification"];

	_v = _v		+ ["Hedgehog"];
	_n = _n		+ ["Hedgehog_EP1"];
	_d = _d		+ [getText (configFile >> "CfgVehicles" >> (_n select (count _n - 1)) >> "displayName")];
	_c = _c		+ [5];
	_t = _t		+ [0];
	_i = _i		+ ["\CA\Warfare2\Images\con_wall1.paa"];
	_s = _s		+ ["StationaryDefense"];
	_dis = _dis	+ [0];
	_dir = _dir	+ [0];
	_h = _h		+ [0];
	_b = _b 		+ ["Fortification"];

	_v = _v		+ ["Land_CamoNet"];
	_n = _n		+ ["Land_CamoNet_EAST_EP1"];
	_d = _d		+ [getText (configFile >> "CfgVehicles" >> (_n select (count _n - 1)) >> "displayName")];
	_c = _c		+ [35];
	_t = _t		+ [0];
	_i = _i		+ ["\CA\Warfare2\Images\con_wall1.paa"];
	_s = _s		+ ["StationaryDefense"];
	_dis = _dis	+ [0];
	_dir = _dir	+ [0];
	_h = _h		+ [0];
	_b = _b 		+ ["Strategic"];

	_v = _v		+ ["Land_CamoNetVar"];
	_n = _n		+ ["Land_CamoNetVar_EAST_EP1"];
	_d = _d		+ [getText (configFile >> "CfgVehicles" >> (_n select (count _n - 1)) >> "displayName")];
	_c = _c		+ [45];
	_t = _t		+ [0];
	_i = _i		+ ["\CA\Warfare2\Images\con_wall1.paa"];
	_s = _s		+ ["StationaryDefense"];
	_dis = _dis	+ [0];
	_dir = _dir	+ [0];
	_h = _h		+ [0];
	_b = _b 		+ ["Strategic"];

	_v = _v		+ ["Land_CamoNetB"];
	_n = _n		+ ["Land_CamoNetB_EAST_EP1"];
	_d = _d		+ [getText (configFile >> "CfgVehicles" >> (_n select (count _n - 1)) >> "displayName")];
	_c = _c		+ [55];
	_t = _t		+ [0];
	_i = _i		+ ["\CA\Warfare2\Images\con_wall1.paa"];
	_s = _s		+ ["StationaryDefense"];
	_dis = _dis	+ [0];
	_dir = _dir	+ [0];
	_h = _h		+ [0];
	_b = _b 		+ ["Strategic"];

	_v = _v		+ ["Sign_Danger"];
	_n = _n		+ ["Sign_Danger"];
	_d = _d		+ [localize 'STR_WF_Minefield'];
	_c = _c		+ [1200];
	_t = _t		+ [0];
	_i = _i		+ ["\CA\Warfare2\Images\con_wall1.paa"];
	_s = _s		+ ["StationaryDefense"];
	_dis = _dis	+ [0];
	_dir = _dir	+ [0];
	_h = _h		+ [0];
	_b = _b 		+ ["Strategic"];

	_v = _v		+ ["HeliH"];
	_n = _n		+ ["HeliH"];
	_d = _d		+ [getText (configFile >> "CfgVehicles" >> (_n select (count _n - 1)) >> "displayName")];
	_c = _c		+ [16];
	_t = _t		+ [0];
	_i = _i		+ ["\CA\Warfare2\Images\con_wall1.paa"];
	_s = _s		+ ["StationaryDefense"];
	_dis = _dis	+ [0];
	_dir = _dir	+ [0];
	_h = _h		+ [0];
	_b = _b 		+ ["Strategic"];

	_v = _v		+ ["RUOrdnanceBox"];
	_n = _n		+ ["TKOrdnanceBox_EP1"];
	_d = _d		+ [getText (configFile >> "CfgVehicles" >> (_n select (count _n - 1)) >> "displayName")];
	_c = _c		+ [850];
	_t = _t		+ [0];
	_i = _i		+ ["\CA\Warfare2\Images\con_wall1.paa"];
	_s = _s		+ ["StationaryDefense"];
	_dis = _dis	+ [0];
	_dir = _dir	+ [0];
	_h = _h		+ [0];
	_b = _b 		+ ["Ammo"];

	_v = _v		+ ["RUVehicleBox"];
	_n = _n		+ ["TKVehicleBox_EP1"];
	_d = _d		+ [getText (configFile >> "CfgVehicles" >> (_n select (count _n - 1)) >> "displayName")];
	_c = _c		+ [1200];
	_t = _t		+ [0];
	_i = _i		+ ["\CA\Warfare2\Images\con_wall1.paa"];
	_s = _s		+ ["StationaryDefense"];
	_dis = _dis	+ [0];
	_dir = _dir	+ [0];
	_h = _h		+ [0];
	_b = _b 		+ ["Ammo"];

	_v = _v		+ ["RUBasicAmmunitionBox"];
	_n = _n		+ ["TKBasicAmmunitionBox_EP1"];
	_d = _d		+ [getText (configFile >> "CfgVehicles" >> (_n select (count _n - 1)) >> "displayName")];
	_c = _c		+ [1950];
	_t = _t		+ [0];
	_i = _i		+ ["\CA\Warfare2\Images\con_wall1.paa"];
	_s = _s		+ ["StationaryDefense"];
	_dis = _dis	+ [0];
	_dir = _dir	+ [0];
	_h = _h		+ [0];
	_b = _b 		+ ["Ammo"];

	_v = _v		+ ["RUBasicWeaponsBox"];
	_n = _n		+ ["TKBasicWeapons_EP1"];
	_d = _d		+ [getText (configFile >> "CfgVehicles" >> (_n select (count _n - 1)) >> "displayName")];
	_c = _c		+ [2975];
	_t = _t		+ [0];
	_i = _i		+ ["\CA\Warfare2\Images\con_wall1.paa"];
	_s = _s		+ ["StationaryDefense"];
	_dis = _dis	+ [0];
	_dir = _dir	+ [0];
	_h = _h		+ [0];
	_b = _b 		+ ["Ammo"];

	_v = _v		+ ["RULaunchersBox"];
	_n = _n		+ ["TKLaunchers_EP1"];
	_d = _d		+ [getText (configFile >> "CfgVehicles" >> (_n select (count _n - 1)) >> "displayName")];
	_c = _c		+ [6250];
	_t = _t		+ [0];
	_i = _i		+ ["\CA\Warfare2\Images\con_wall1.paa"];
	_s = _s		+ ["StationaryDefense"];
	_dis = _dis	+ [0];
	_dir = _dir	+ [0];
	_h = _h		+ [0];
	_b = _b 		+ ["Ammo"];

	_v = _v		+ ["RUSpecialWeaponsBox"];
	_n = _n		+ ["TKSpecialWeapons_EP1"];
	_d = _d		+ [getText (configFile >> "CfgVehicles" >> (_n select (count _n - 1)) >> "displayName")];
	_c = _c		+ [7500];
	_t = _t		+ [0];
	_i = _i		+ ["\CA\Warfare2\Images\con_wall1.paa"];
	_s = _s		+ ["StationaryDefense"];
	_dis = _dis	+ [0];
	_dir = _dir	+ [0];
	_h = _h		+ [0];
	_b = _b 		+ ["Ammo"];

	['WFBE_EASTDEFENSES',_v,true] Call SetNamespace;
	['WFBE_EASTDEFENSENAMES',_n,true] Call SetNamespace;
	['WFBE_EASTDEFENSEDESCRIPTIONS',_d,true] Call SetNamespace;
	['WFBE_EASTDEFENSECOSTS',_c,true] Call SetNamespace;
	['WFBE_EASTDEFENSETIMES',_t,true] Call SetNamespace;
	['WFBE_EASTDEFENSEIMAGES',_i,true] Call SetNamespace;
	['WFBE_EASTDEFENSEDISTANCES',_dis,true] Call SetNamespace;
	['WFBE_EASTDEFENSEDIRECTIONS',_dir,true] Call SetNamespace;
	['WFBE_EASTDEFENSESCRIPTS',_s,true] Call SetNamespace;
	['WFBE_EASTDEFENSEHEIGHTS',_h,true] Call SetNamespace;
	['WFBE_EASTDEFENSECATEGORIES',_b,true] Call SetNamespace;
	
	['WFBE_WESTCONSTRUCTIONSITE','US_WarfareBContructionSite_EP1',true] Call SetNamespace;
	['WFBE_EASTCONSTRUCTIONSITE','TK_WarfareBContructionSite_EP1',true] Call SetNamespace;

	//RESISTANCE STATIONARY DEFENSES
	_v			= ["MGNest"];
	_n			= ["WarfareBMGNest_PK_TK_GUE_EP1"];
	_d			= [getText (configFile >> "CfgVehicles" >> (_n select (count _n - 1)) >> "displayName")];
	_c			= [300];
	_t			= [0];
	_i			= ["\CA\Warfare2\Images\con_mg_nest.paa"];
	_s			= ["StationaryDefense"];
	_dis		= [0];
	_dir		= [0];
	_h			= [0];

	['WFBE_RESISTANCEDEFENSES',_v,true] Call SetNamespace;
	['WFBE_RESISTANCEDEFENSENAMES',_n,true] Call SetNamespace;
	['WFBE_RESISTANCEDEFENSEDESCRIPTIONS',_d,true] Call SetNamespace;
	['WFBE_RESISTANCEDEFENSECOSTS',_c,true] Call SetNamespace;
	['WFBE_RESISTANCEDEFENSETIMES',_t,true] Call SetNamespace;
	['WFBE_RESISTANCEDEFENSEIMAGES',_i,true] Call SetNamespace;
	['WFBE_RESISTANCEDEFENSEDISTANCES',_dis,true] Call SetNamespace;
	['WFBE_RESISTANCEDEFENSEDIRECTIONS',_dir,true] Call SetNamespace;
	['WFBE_RESISTANCEDEFENSESCRIPTS',_s,true] Call SetNamespace;
	['WFBE_RESISTANCEDEFENSEHEIGHTS',_h,true] Call SetNamespace;
};

if (WF_A2_CombinedOps) then {
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
	
	WFDEPOT = ["Land_fortified_nest_big_EP1","WarfareBDepot"];
	WFCAMP = ["Land_Fort_Watchtower_EP1","WarfareBCamp"];
	WFHANGAR = ["Land_Mil_hangar_EP1","WarfareBAirport"];
	WFFLAG = "FlagCarrierTakistan_EP1";

	_v			= ["Headquarters"];
	_n			= [WESTHQ];
	_d			= [getText (configFile >> "CfgVehicles" >> (_n select (count _n - 1)) >> "displayName")];
	_c			= [('WFBE_HQDEPLOYPRICE' Call GetNamespace)];
	_t			= [30];
	_i			= ["\CA\Warfare2\Images\con_hq.paa"];
	_s			= ["HQSite"];
	_dis		= [15];
	_dir		= [0];
	_h			= [3];

	_v = _v		+ ["Barracks"];
	_n = _n		+ [WESTBAR];
	_d = _d		+ [getText (configFile >> "CfgVehicles" >> (_n select (count _n - 1)) >> "displayName")];
	_c = _c		+ [200];
	_t = _t		+ [70];
	_i = _i		+ ["\CA\Warfare2\Images\con_barracks.paa"];
	_s = _s		+ ["SmallSite"];
	_dis = _dis	+ [18];
	_dir = _dir	+ [90];
	_h = _h		+ [3];

	_v = _v		+ ["Light"];
	_n = _n		+ [WESTLVF];
	_d = _d		+ [getText (configFile >> "CfgVehicles" >> (_n select (count _n - 1)) >> "displayName")];
	_c = _c		+ [600];
	_t = _t		+ [90];
	_i = _i		+ ["\CA\Warfare2\Images\con_light.paa"];
	_s = _s		+ ["MediumSite"];
	_dis = _dis	+ [20];
	_dir = _dir	+ [90];
	_h = _h		+ [4.5];

	_v = _v		+ ["CommandCenter"];
	_n = _n		+ [WESTCC];
	_d = _d		+ [localize "STR_WF_CommandCenter_USMC"];
	_c = _c		+ [1200];
	_t = _t		+ [110];
	_i = _i		+ ["\CA\Warfare2\Images\con_hq.paa"];
	_s = _s		+ ["SmallSite"];
	_dis = _dis	+ [20];
	_dir = _dir	+ [90];
	_h = _h		+ [4.5];

	_v = _v		+ ["Heavy"];
	_n = _n		+ [WESTHEAVY];
	_d = _d		+ [getText (configFile >> "CfgVehicles" >> (_n select (count _n - 1)) >> "displayName")];
	_c = _c		+ [2800];
	_t = _t		+ [130];
	_i = _i		+ ["\CA\Warfare2\Images\con_heavy.paa"];
	_s = _s		+ ["MediumSite"];
	_dis = _dis	+ [20];
	_dir = _dir	+ [90];
	_h = _h		+ [4];

	_v = _v		+ ["Aircraft"];
	_n = _n		+ [WESTAIR];
	_d = _d		+ [localize "STR_WF_AircraftFactory"];
	_c = _c		+ [4400];
	_t = _t		+ [150];
	_i = _i		+ ["\CA\Warfare2\Images\con_aircraft.paa"];
	_s = _s		+ ["SmallSite"];
	_dis = _dis	+ [31];
	_dir = _dir	+ [90];
	_h = _h		+ [5.5];

	_v = _v		+ ["ServicePoint"];
	_n = _n		+ [WESTSP];
	_d = _d		+ [localize "STR_WF_ServicePoint"];
	_c = _c		+ [700];
	_t = _t		+ [70];
	_i = _i		+ ["\CA\Warfare2\Images\con_light.paa"];
	_s = _s		+ ["SmallSite"];
	_dis = _dis	+ [21];
	_dir = _dir	+ [90];
	_h = _h		+ [5.5];

	if (AARadar) then {
		_v = _v		+ ["AARadar"];
		_n = _n		+ [WESTAAR];
		_d = _d		+ [getText (configFile >> "CfgVehicles" >> (_n select (count _n - 1)) >> "displayName")];
		_c = _c		+ [3200];
		_t = _t		+ [280];
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

	//Note that cost of defenses is in money instead of supplies.
	//WEST STATIONARY DEFENSES
	_v			= ["MGNest"];
	_n			= ["WarfareBMGNest_M240_US_EP1"];
	_d			= [getText (configFile >> "CfgVehicles" >> (_n select (count _n - 1)) >> "displayName")];
	_c			= [300];
	_t			= [0];
	_i			= ["\CA\Warfare2\Images\con_mg_nest.paa"];
	_s			= ["StationaryDefense"];
	_dis		= [0];
	_dir		= [0];
	_h			= [0];
	_b			= ["Defense"];

	_v = _v		+ ["M2HD"];
	_n = _n		+ ["M2HD_mini_TriPod_US_EP1"];
	_d = _d		+ [getText (configFile >> "CfgVehicles" >> (_n select (count _n - 1)) >> "displayName")];
	_c = _c		+ [200];
	_t = _t		+ [0];
	_i = _i		+ ["\CA\Warfare2\Images\con_gl.paa"];
	_s = _s		+ ["StationaryDefense"];
	_dis = _dis	+ [0];
	_dir = _dir	+ [0];
	_h = _h		+ [0];
	_b = _b 		+ ["Defense"];

	_v = _v		+ ["SearchLight"];
	_n = _n		+ ["SearchLight_US_EP1"];
	_d = _d		+ [getText (configFile >> "CfgVehicles" >> (_n select (count _n - 1)) >> "displayName")];
	_c = _c		+ [175];
	_t = _t		+ [0];
	_i = _i		+ ["\CA\Warfare2\Images\con_reflector.paa"];
	_s = _s		+ ["StationaryDefense"];
	_dis = _dis	+ [0];
	_dir = _dir	+ [0];
	_h = _h		+ [0];
	_b = _b 		+ ["Defense"];

	_v = _v		+ ["M2"];
	_n = _n		+ ["M2StaticMG_US_EP1"];
	_d = _d		+ [getText (configFile >> "CfgVehicles" >> (_n select (count _n - 1)) >> "displayName")];
	_c = _c		+ [225];
	_t = _t		+ [0];
	_i = _i		+ ["\CA\Warfare2\Images\con_gl.paa"];
	_s = _s		+ ["StationaryDefense"];
	_dis = _dis	+ [0];
	_dir = _dir	+ [0];
	_h = _h		+ [0];
	_b = _b 		+ ["Defense"];

	_v = _v		+ ["MK19"];
	_n = _n		+ ["MK19_TriPod_US_EP1"];
	_d = _d		+ [getText (configFile >> "CfgVehicles" >> (_n select (count _n - 1)) >> "displayName")];
	_c = _c		+ [700];
	_t = _t		+ [0];
	_i = _i		+ ["\CA\Warfare2\Images\con_gl.paa"];
	_s = _s		+ ["StationaryDefense"];
	_dis = _dis	+ [0];
	_dir = _dir	+ [0];
	_h = _h		+ [0];
	_b = _b 		+ ["Defense"];

	_v = _v		+ ["ATTripod"];
	_n = _n		+ ["TOW_TriPod"];
	_d = _d		+ [getText (configFile >> "CfgVehicles" >> (_n select (count _n - 1)) >> "displayName")];
	_c = _c		+ [800];
	_t = _t		+ [0];
	_i = _i		+ ["\CA\Warfare2\Images\con_at_pod.paa"];
	_s = _s		+ ["StationaryDefense"];
	_dis = _dis	+ [0];
	_dir = _dir	+ [0];
	_h = _h		+ [0];
	_b = _b 		+ ["Defense"];

	_v = _v		+ ["AATripod"];
	_n = _n		+ ["Stinger_Pod_US_EP1"];
	_d = _d		+ [getText (configFile >> "CfgVehicles" >> (_n select (count _n - 1)) >> "displayName")];
	_c = _c		+ [800];
	_t = _t		+ [0];
	_i = _i		+ ["\CA\Warfare2\Images\con_aa_pod.paa"];
	_s = _s		+ ["StationaryDefense"];
	_dis = _dis	+ [0];
	_dir = _dir	+ [0];
	_h = _h		+ [0];
	_b = _b 		+ ["Defense"];

	_v = _v		+ ["M252"];
	_n = _n		+ ["M252_US_EP1"];
	_d = _d		+ [getText (configFile >> "CfgVehicles" >> (_n select (count _n - 1)) >> "displayName")];
	_c = _c		+ [1100];
	_t = _t		+ [0];
	_i = _i		+ ["\CA\Warfare2\Images\con_gun.paa"];
	_s = _s		+ ["StationaryDefense"];
	_dis = _dis	+ [0];
	_dir = _dir	+ [0];
	_h = _h		+ [0];
	_b = _b 		+ ["Defense"];

	_v = _v		+ ["M119"];
	_n = _n		+ ["M119_US_EP1"];
	_d = _d		+ [getText (configFile >> "CfgVehicles" >> (_n select (count _n - 1)) >> "displayName")];
	_c = _c		+ [2250];
	_t = _t		+ [0];
	_i = _i		+ ["\CA\Warfare2\Images\con_gun.paa"];
	_s = _s		+ ["StationaryDefense"];
	_dis = _dis	+ [0];
	_dir = _dir	+ [0];
	_h = _h		+ [0];
	_b = _b 		+ ["Defense"];

	_v = _v		+ ["SmallWall"];
	_n = _n		+ ["Land_HBarrier3"];
	_d = _d		+ [getText (configFile >> "CfgVehicles" >> (_n select (count _n - 1)) >> "displayName")];
	_c = _c		+ [20];
	_t = _t		+ [0];
	_i = _i		+ ["\CA\Warfare2\Images\con_wall1.paa"];
	_s = _s		+ ["StationaryDefense"];
	_dis = _dis	+ [0];
	_dir = _dir	+ [0];
	_h = _h		+ [0];
	_b = _b 		+ ["Fortification"];

	_v = _v		+ ["MediumWall"];
	_n = _n		+ ["Land_HBarrier5"];
	_d = _d		+ [getText (configFile >> "CfgVehicles" >> (_n select (count _n - 1)) >> "displayName")];
	_c = _c		+ [30];
	_t = _t		+ [0];
	_i = _i		+ ["\CA\Warfare2\Images\con_wall2.paa"];
	_s = _s		+ ["StationaryDefense"];
	_dis = _dis	+ [0];
	_dir = _dir	+ [0];
	_h = _h		+ [0];
	_b = _b 		+ ["Fortification"];

	_v = _v		+ ["LargeWall"];
	_n = _n		+ ["Land_HBarrier_large"];
	_d = _d		+ [getText (configFile >> "CfgVehicles" >> (_n select (count _n - 1)) >> "displayName")];
	_c = _c		+ [50];
	_t = _t		+ [0];
	_i = _i		+ ["\CA\Warfare2\Images\con_wall3.paa"];
	_s = _s		+ ["StationaryDefense"];
	_dis = _dis	+ [0];
	_dir = _dir	+ [0];
	_h = _h		+ [0];
	_b = _b 		+ ["Fortification"];

	_v = _v		+ ["Base_WarfareBBarrier5x"];
	_n = _n		+ ["US_WarfareBBarrier5x_EP1"];
	_d = _d		+ [getText (configFile >> "CfgVehicles" >> (_n select (count _n - 1)) >> "displayName")];
	_c = _c		+ [15];
	_t = _t		+ [0];
	_i = _i		+ ["\CA\Warfare2\Images\con_wall3.paa"];
	_s = _s		+ ["StationaryDefense"];
	_dis = _dis	+ [0];
	_dir = _dir	+ [0];
	_h = _h		+ [0];
	_b = _b 		+ ["Fortification"];

	_v = _v		+ ["Base_WarfareBBarrier10x"];
	_n = _n		+ ["US_WarfareBBarrier10x_EP1"];
	_d = _d		+ [getText (configFile >> "CfgVehicles" >> (_n select (count _n - 1)) >> "displayName")];
	_c = _c		+ [25];
	_t = _t		+ [0];
	_i = _i		+ ["\CA\Warfare2\Images\con_wall3.paa"];
	_s = _s		+ ["StationaryDefense"];
	_dis = _dis	+ [0];
	_dir = _dir	+ [0];
	_h = _h		+ [0];
	_b = _b 		+ ["Fortification"];

	_v = _v		+ ["Base_WarfareBBarrier10xTall"];
	_n = _n		+ ["US_WarfareBBarrier10xTall_EP1"];
	_d = _d		+ [getText (configFile >> "CfgVehicles" >> (_n select (count _n - 1)) >> "displayName")];
	_c = _c		+ [50];
	_t = _t		+ [0];
	_i = _i		+ ["\CA\Warfare2\Images\con_wall3.paa"];
	_s = _s		+ ["StationaryDefense"];
	_dis = _dis	+ [0];
	_dir = _dir	+ [0];
	_h = _h		+ [0];
	_b = _b 		+ ["Fortification"];

	_v = _v		+ ["MASH"];
	_n = _n		+ ["MASH_EP1"];
	_d = _d		+ [getText (configFile >> "CfgVehicles" >> (_n select (count _n - 1)) >> "displayName")];
	_c = _c		+ [30];
	_t = _t		+ [0];
	_i = _i		+ ["\CA\Warfare2\Images\con_wall1.paa"];
	_s = _s		+ ["StationaryDefense"];
	_dis = _dis	+ [0];
	_dir = _dir	+ [0];
	_h = _h		+ [0];
	_b = _b 		+ ["Strategic"];

	_v = _v		+ ["Land_fort_bagfence_long"];
	_n = _n		+ ["Land_fort_bagfence_long"];
	_d = _d		+ [getText (configFile >> "CfgVehicles" >> (_n select (count _n - 1)) >> "displayName")];
	_c = _c		+ [10];
	_t = _t		+ [0];
	_i = _i		+ ["\CA\Warfare2\Images\con_wall1.paa"];
	_s = _s		+ ["StationaryDefense"];
	_dis = _dis	+ [0];
	_dir = _dir	+ [0];
	_h = _h		+ [0];
	_b = _b 		+ ["Fortification"];

	_v = _v		+ ["Land_fort_bagfence_corner"];
	_n = _n		+ ["Land_fort_bagfence_corner"];
	_d = _d		+ [getText (configFile >> "CfgVehicles" >> (_n select (count _n - 1)) >> "displayName")];
	_c = _c		+ [8];
	_t = _t		+ [0];
	_i = _i		+ ["\CA\Warfare2\Images\con_wall1.paa"];
	_s = _s		+ ["StationaryDefense"];
	_dis = _dis	+ [0];
	_dir = _dir	+ [0];
	_h = _h		+ [0];
	_b = _b 		+ ["Fortification"];

	_v = _v		+ ["Land_fort_bagfence_round"];
	_n = _n		+ ["Land_fort_bagfence_round"];
	_d = _d		+ [getText (configFile >> "CfgVehicles" >> (_n select (count _n - 1)) >> "displayName")];
	_c = _c		+ [12];
	_t = _t		+ [0];
	_i = _i		+ ["\CA\Warfare2\Images\con_wall1.paa"];
	_s = _s		+ ["StationaryDefense"];
	_dis = _dis	+ [0];
	_dir = _dir	+ [0];
	_h = _h		+ [0];
	_b = _b 		+ ["Fortification"];

	_v = _v		+ ["Land_fortified_nest_small"];
	_n = _n		+ ["Land_fortified_nest_small_EP1"];
	_d = _d		+ [getText (configFile >> "CfgVehicles" >> (_n select (count _n - 1)) >> "displayName")];
	_c = _c		+ [40];
	_t = _t		+ [0];
	_i = _i		+ ["\CA\Warfare2\Images\con_wall1.paa"];
	_s = _s		+ ["StationaryDefense"];
	_dis = _dis	+ [0];
	_dir = _dir	+ [0];
	_h = _h		+ [0];
	_b = _b 		+ ["Fortification"];

	_v = _v		+ ["Land_fort_rampart"];
	_n = _n		+ ["Land_fort_rampart_EP1"];
	_d = _d		+ [getText (configFile >> "CfgVehicles" >> (_n select (count _n - 1)) >> "displayName")];
	_c = _c		+ [30];
	_t = _t		+ [0];
	_i = _i		+ ["\CA\Warfare2\Images\con_wall1.paa"];
	_s = _s		+ ["StationaryDefense"];
	_dis = _dis	+ [0];
	_dir = _dir	+ [0];
	_h = _h		+ [0];
	_b = _b 		+ ["Fortification"];

	_v = _v		+ ["Land_fort_artillery_nest"];
	_n = _n		+ ["Land_fort_artillery_nest_EP1"];
	_d = _d		+ [localize "STR_WF_ArtilleryNest"];
	_c = _c		+ [65];
	_t = _t		+ [0];
	_i = _i		+ ["\CA\Warfare2\Images\con_wall1.paa"];
	_s = _s		+ ["StationaryDefense"];
	_dis = _dis	+ [0];
	_dir = _dir	+ [0];
	_h = _h		+ [0];
	_b = _b 		+ ["Fortification"];

	_v = _v		+ ["Hhedgehog_concreteBig"];
	_n = _n		+ ["Hhedgehog_concreteBig"];
	_d = _d		+ [getText (configFile >> "CfgVehicles" >> (_n select (count _n - 1)) >> "displayName")];
	_c = _c		+ [95];
	_t = _t		+ [0];
	_i = _i		+ ["\CA\Warfare2\Images\con_wall1.paa"];
	_s = _s		+ ["StationaryDefense"];
	_dis = _dis	+ [0];
	_dir = _dir	+ [0];
	_h = _h		+ [0];
	_b = _b 		+ ["Fortification"];

	_v = _v		+ ["Hedgehog"];
	_n = _n		+ ["Hedgehog_EP1"];
	_d = _d		+ [getText (configFile >> "CfgVehicles" >> (_n select (count _n - 1)) >> "displayName")];
	_c = _c		+ [5];
	_t = _t		+ [0];
	_i = _i		+ ["\CA\Warfare2\Images\con_wall1.paa"];
	_s = _s		+ ["StationaryDefense"];
	_dis = _dis	+ [0];
	_dir = _dir	+ [0];
	_h = _h		+ [0];
	_b = _b 		+ ["Fortification"];

	_v = _v		+ ["Land_CamoNet"];
	_n = _n		+ ["Land_CamoNet_NATO_EP1"];
	_d = _d		+ [getText (configFile >> "CfgVehicles" >> (_n select (count _n - 1)) >> "displayName")];
	_c = _c		+ [35];
	_t = _t		+ [0];
	_i = _i		+ ["\CA\Warfare2\Images\con_wall1.paa"];
	_s = _s		+ ["StationaryDefense"];
	_dis = _dis	+ [0];
	_dir = _dir	+ [0];
	_h = _h		+ [0];
	_b = _b 		+ ["Strategic"];

	_v = _v		+ ["Land_CamoNetVar"];
	_n = _n		+ ["Land_CamoNetVar_NATO_EP1"];
	_d = _d		+ [getText (configFile >> "CfgVehicles" >> (_n select (count _n - 1)) >> "displayName")];
	_c = _c		+ [45];
	_t = _t		+ [0];
	_i = _i		+ ["\CA\Warfare2\Images\con_wall1.paa"];
	_s = _s		+ ["StationaryDefense"];
	_dis = _dis	+ [0];
	_dir = _dir	+ [0];
	_h = _h		+ [0];
	_b = _b 		+ ["Strategic"];

	_v = _v		+ ["Land_CamoNetB"];
	_n = _n		+ ["Land_CamoNetB_NATO_EP1"];
	_d = _d		+ [getText (configFile >> "CfgVehicles" >> (_n select (count _n - 1)) >> "displayName")];
	_c = _c		+ [55];
	_t = _t		+ [0];
	_i = _i		+ ["\CA\Warfare2\Images\con_wall1.paa"];
	_s = _s		+ ["StationaryDefense"];
	_dis = _dis	+ [0];
	_dir = _dir	+ [0];
	_h = _h		+ [0];
	_b = _b 		+ ["Strategic"];

	_v = _v		+ ["Sign_Danger"];
	_n = _n		+ ["Sign_Danger"];
	_d = _d		+ [localize 'STR_WF_Minefield'];
	_c = _c		+ [1200];
	_t = _t		+ [0];
	_i = _i		+ ["\CA\Warfare2\Images\con_wall1.paa"];
	_s = _s		+ ["StationaryDefense"];
	_dis = _dis	+ [0];
	_dir = _dir	+ [0];
	_h = _h		+ [0];
	_b = _b 		+ ["Strategic"];

	_v = _v		+ ["HeliH"];
	_n = _n		+ ["HeliH"];
	_d = _d		+ [getText (configFile >> "CfgVehicles" >> (_n select (count _n - 1)) >> "displayName")];
	_c = _c		+ [16];
	_t = _t		+ [0];
	_i = _i		+ ["\CA\Warfare2\Images\con_wall1.paa"];
	_s = _s		+ ["StationaryDefense"];
	_dis = _dis	+ [0];
	_dir = _dir	+ [0];
	_h = _h		+ [0];
	_b = _b 		+ ["Strategic"];

	_v = _v		+ ["USOrdnanceBox"];
	_n = _n		+ ["USOrdnanceBox_EP1"];
	_d = _d		+ [getText (configFile >> "CfgVehicles" >> (_n select (count _n - 1)) >> "displayName")];
	_c = _c		+ [850];
	_t = _t		+ [0];
	_i = _i		+ ["\CA\Warfare2\Images\con_wall1.paa"];
	_s = _s		+ ["StationaryDefense"];
	_dis = _dis	+ [0];
	_dir = _dir	+ [0];
	_h = _h		+ [0];
	_b = _b 		+ ["Ammo"];

	_v = _v		+ ["USVehicleBox"];
	_n = _n		+ ["USVehicleBox_EP1"];
	_d = _d		+ [getText (configFile >> "CfgVehicles" >> (_n select (count _n - 1)) >> "displayName")];
	_c = _c		+ [1200];
	_t = _t		+ [0];
	_i = _i		+ ["\CA\Warfare2\Images\con_wall1.paa"];
	_s = _s		+ ["StationaryDefense"];
	_dis = _dis	+ [0];
	_dir = _dir	+ [0];
	_h = _h		+ [0];
	_b = _b 		+ ["Ammo"];

	_v = _v		+ ["USBasicAmmunitionBox"];
	_n = _n		+ ["USBasicAmmunitionBox_EP1"];
	_d = _d		+ [getText (configFile >> "CfgVehicles" >> (_n select (count _n - 1)) >> "displayName")];
	_c = _c		+ [1950];
	_t = _t		+ [0];
	_i = _i		+ ["\CA\Warfare2\Images\con_wall1.paa"];
	_s = _s		+ ["StationaryDefense"];
	_dis = _dis	+ [0];
	_dir = _dir	+ [0];
	_h = _h		+ [0];
	_b = _b 		+ ["Ammo"];

	_v = _v		+ ["USBasicWeaponsBox"];
	_n = _n		+ ["USBasicWeapons_EP1"];
	_d = _d		+ [getText (configFile >> "CfgVehicles" >> (_n select (count _n - 1)) >> "displayName")];
	_c = _c		+ [2975];
	_t = _t		+ [0];
	_i = _i		+ ["\CA\Warfare2\Images\con_wall1.paa"];
	_s = _s		+ ["StationaryDefense"];
	_dis = _dis	+ [0];
	_dir = _dir	+ [0];
	_h = _h		+ [0];
	_b = _b 		+ ["Ammo"];

	_v = _v		+ ["USLaunchersBox"];
	_n = _n		+ ["USLaunchers_EP1"];
	_d = _d		+ [getText (configFile >> "CfgVehicles" >> (_n select (count _n - 1)) >> "displayName")];
	_c = _c		+ [6250];
	_t = _t		+ [0];
	_i = _i		+ ["\CA\Warfare2\Images\con_wall1.paa"];
	_s = _s		+ ["StationaryDefense"];
	_dis = _dis	+ [0];
	_dir = _dir	+ [0];
	_h = _h		+ [0];
	_b = _b 		+ ["Ammo"];

	_v = _v		+ ["USSpecialWeaponsBox"];
	_n = _n		+ ["USSpecialWeapons_EP1"];
	_d = _d		+ [getText (configFile >> "CfgVehicles" >> (_n select (count _n - 1)) >> "displayName")];
	_c = _c		+ [7500];
	_t = _t		+ [0];
	_i = _i		+ ["\CA\Warfare2\Images\con_wall1.paa"];
	_s = _s		+ ["StationaryDefense"];
	_dis = _dis	+ [0];
	_dir = _dir	+ [0];
	_h = _h		+ [0];
	_b = _b 		+ ["Ammo"];

	['WFBE_WESTDEFENSES',_v,true] Call SetNamespace;
	['WFBE_WESTDEFENSENAMES',_n,true] Call SetNamespace;
	['WFBE_WESTDEFENSEDESCRIPTIONS',_d,true] Call SetNamespace;
	['WFBE_WESTDEFENSECOSTS',_c,true] Call SetNamespace;
	['WFBE_WESTDEFENSETIMES',_t,true] Call SetNamespace;
	['WFBE_WESTDEFENSEIMAGES',_i,true] Call SetNamespace;
	['WFBE_WESTDEFENSEDISTANCES',_dis,true] Call SetNamespace;
	['WFBE_WESTDEFENSEDIRECTIONS',_dir,true] Call SetNamespace;
	['WFBE_WESTDEFENSESCRIPTS',_s,true] Call SetNamespace;
	['WFBE_WESTDEFENSEHEIGHTS',_h,true] Call SetNamespace;
	['WFBE_WESTDEFENSECATEGORIES',_b,true] Call SetNamespace;

	//EAST STRUCTURES
	EASTHQ = "BMP2_HQ_TK_unfolded_EP1";
	EASTBAR = "TK_WarfareBBarracks_EP1";
	EASTLVF = "TK_WarfareBLightFactory_EP1";
	EASTCC = "TK_WarfareBUAVterminal_EP1";
	EASTHEAVY = "TK_WarfareBHeavyFactory_EP1";
	EASTAIR = "TK_WarfareBAircraftFactory_EP1";
	EASTSP = "TK_WarfareBVehicleServicePoint_EP1";
	EASTAAR = "TK_WarfareBAntiAirRadar_EP1";
	
	['WFBE_EASTFLAG','\Ca\Data\flag_rus_co.paa',true] Call SetNamespace;
	['WFBE_EASTFARP','CampEast',true] Call SetNamespace;
	
	_v			= ["Headquarters"];
	_n			= [EASTHQ];
	_d			= [getText (configFile >> "CfgVehicles" >> (_n select (count _n - 1)) >> "displayName")];
	_c			= [('WFBE_HQDEPLOYPRICE' Call GetNamespace)];
	_t			= [30];
	_i			= ["\CA\Warfare2\Images\con_hq.paa"];
	_s			= ["HQSite"];
	_dis		= [15];
	_dir		= [0];
	_h			= [3];

	_v = _v		+ ["Barracks"];
	_n = _n		+ [EASTBAR];
	_d = _d		+ [getText (configFile >> "CfgVehicles" >> (_n select (count _n - 1)) >> "displayName")];
	_c = _c		+ [200];
	_t = _t		+ [70];
	_i = _i		+ ["\CA\Warfare2\Images\con_barracks.paa"];
	_s = _s		+ ["SmallSite"];
	_dis = _dis	+ [18];
	_dir = _dir	+ [90];
	_h = _h		+ [3];

	_v = _v		+ ["Light"];
	_n = _n		+ [EASTLVF];
	_d = _d		+ [getText (configFile >> "CfgVehicles" >> (_n select (count _n - 1)) >> "displayName")];
	_c = _c		+ [600];
	_t = _t		+ [90];
	_i = _i		+ ["\CA\Warfare2\Images\con_light.paa"];
	_s = _s		+ ["MediumSite"];
	_dis = _dis	+ [20];
	_dir = _dir	+ [90];
	_h = _h		+ [4.5];

	_v = _v		+ ["CommandCenter"];
	_n = _n		+ [EASTCC];
	_d = _d		+ [localize "STR_WF_CommandCenter_RU"];
	_c = _c		+ [1200];
	_t = _t		+ [110];
	_i = _i		+ ["\CA\Warfare2\Images\con_hq.paa"];
	_s = _s		+ ["SmallSite"];

	_dis = _dis	+ [20];
	_dir = _dir	+ [90];
	_h = _h		+ [4.5];

	_v = _v		+ ["Heavy"];
	_n = _n		+ [EASTHEAVY];
	_d = _d		+ [getText (configFile >> "CfgVehicles" >> (_n select (count _n - 1)) >> "displayName")];
	_c = _c		+ [2800];
	_t = _t		+ [130];
	_i = _i		+ ["\CA\Warfare2\Images\con_heavy.paa"];
	_s = _s		+ ["MediumSite"];
	_dis = _dis	+ [20];
	_dir = _dir	+ [90];
	_h = _h		+ [4];

	_v = _v		+ ["Aircraft"];
	_n = _n		+ [EASTAIR];
	_d = _d		+ [getText (configFile >> "CfgVehicles" >> (_n select (count _n - 1)) >> "displayName")];
	_c = _c		+ [4400];
	_t = _t		+ [150];
	_i = _i		+ ["\CA\Warfare2\Images\con_aircraft.paa"];
	_s = _s		+ ["SmallSite"];
	_dis = _dis	+ [21];
	_dir = _dir	+ [90];
	_h = _h		+ [5.5];

	_v = _v		+ ["ServicePoint"];
	_n = _n		+ [EASTSP];
	_d = _d		+ [getText (configFile >> "CfgVehicles" >> (_n select (count _n - 1)) >> "displayName")];
	_c = _c		+ [700];
	_t = _t		+ [70];
	_i = _i		+ ["\CA\Warfare2\Images\con_light.paa"];
	_s = _s		+ ["SmallSite"];
	_dis = _dis	+ [21];
	_dir = _dir	+ [90];
	_h = _h		+ [5.5];

	if (AARadar) then {
		_v = _v		+ ["AARadar"];
		_n = _n		+ [EASTAAR];
		_d = _d		+ [getText (configFile >> "CfgVehicles" >> (_n select (count _n - 1)) >> "displayName")];
		_c = _c		+ [3200];
		_t = _t		+ [280];
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

	//Note that cost of defenses is in money instead of supplies.
	//EAST STATIONARY DEFENSES
	_v			= ["MGNest"];
	_n			= ["RU_WarfareBMGNest_PK"];
	_d			= [getText (configFile >> "CfgVehicles" >> (_n select (count _n - 1)) >> "displayName")];
	_c			= [300];
	_t			= [0];
	_i			= ["\CA\Warfare2\Images\con_mg_nest.paa"];
	_s			= ["StationaryDefense"];
	_dis		= [0];
	_dir		= [0];
	_h			= [0];
	_b			= ["Defense"];

	_v = _v		+ ["SearchLight_RUS"];
	_n = _n		+ ["SearchLight_RUS"];
	_d = _d		+ [getText (configFile >> "CfgVehicles" >> (_n select (count _n - 1)) >> "displayName")];
	_c = _c		+ [175];
	_t = _t		+ [0];
	_i = _i		+ ["\CA\Warfare2\Images\con_reflector.paa"];
	_s = _s		+ ["StationaryDefense"];
	_dis = _dis	+ [0];
	_dir = _dir	+ [0];
	_h = _h		+ [0];
	_b = _b 		+ ["Defense"];

	_v = _v		+ ["KORD"];
	_n = _n		+ ["KORD"];
	//--- Russian Localization Hotfix.
	_d = _d		+ ["KORD Minitripod"];
	_c = _c		+ [250];
	_t = _t		+ [0];
	_i = _i		+ ["\CA\Warfare2\Images\con_gl.paa"];
	_s = _s		+ ["StationaryDefense"];
	_dis = _dis	+ [0];
	_dir = _dir	+ [0];
	_h = _h		+ [0];
	_b = _b 		+ ["Defense"];

	_v = _v		+ ["KORD_high"];
	_n = _n		+ ["KORD_high"];
	//--- Russian Localization Hotfix.
	_d = _d		+ ["KORD"];
	_c = _c		+ [300];
	_t = _t		+ [0];
	_i = _i		+ ["\CA\Warfare2\Images\con_gl.paa"];
	_s = _s		+ ["StationaryDefense"];
	_dis = _dis	+ [0];
	_dir = _dir	+ [0];
	_h = _h		+ [0];
	_b = _b 		+ ["Defense"];

	_v = _v		+ ["AGS30"];
	_n = _n		+ ["AGS_RU"];
	_d = _d		+ [getText (configFile >> "CfgVehicles" >> (_n select (count _n - 1)) >> "displayName")];
	_c = _c		+ [700];
	_t = _t		+ [0];
	_i = _i		+ ["\CA\Warfare2\Images\con_gl.paa"];
	_s = _s		+ ["StationaryDefense"];
	_dis = _dis	+ [0];
	_dir = _dir	+ [0];
	_h = _h		+ [0];
	_b = _b 		+ ["Defense"];

	_v = _v		+ ["SPG9_Ins"];
	_n = _n		+ ["SPG9_Ins"];
	_d = _d		+ [getText (configFile >> "CfgVehicles" >> (_n select (count _n - 1)) >> "displayName")];
	_c = _c		+ [800];
	_t = _t		+ [0];
	_i = _i		+ ["\CA\Warfare2\Images\con_at_pod.paa"];
	_s = _s		+ ["StationaryDefense"];
	_dis = _dis	+ [0];
	_dir = _dir	+ [0];
	_h = _h		+ [0];
	_b = _b 		+ ["Defense"];

	_v = _v		+ ["ATTripod"];
	_n = _n		+ ["Metis"];
	//--- Russian Localization Hotfix.
	_d = _d		+ ["Metis-M 9K115-2"];
	_c = _c		+ [800];
	_t = _t		+ [0];
	_i = _i		+ ["\CA\Warfare2\Images\con_at_pod.paa"];
	_s = _s		+ ["StationaryDefense"];
	_dis = _dis	+ [0];
	_dir = _dir	+ [0];
	_h = _h		+ [0];
	_b = _b 		+ ["Defense"];

	_v = _v		+ ["AATripod"];
	_n = _n		+ ["Igla_AA_pod_East"];
	//--- Russian Localization Hotfix.
	_d = _d 	+ ["Igla AA POD launcher"];
	_c = _c		+ [800];
	_t = _t		+ [0];
	_i = _i		+ ["\CA\Warfare2\Images\con_aa_pod.paa"];
	_s = _s		+ ["StationaryDefense"];
	_dis = _dis	+ [0];
	_dir = _dir	+ [0];
	_h = _h		+ [0];
	_b = _b 		+ ["Defense"];

	_v = _v		+ ["ZU23"];
	_n = _n		+ ["ZU23_Ins"];
	_d = _d		+ [getText (configFile >> "CfgVehicles" >> (_n select (count _n - 1)) >> "displayName")];
	_c = _c		+ [950];
	_t = _t		+ [0];
	_i = _i		+ ["\CA\Warfare2\Images\con_aa_pod.paa"];
	_s = _s		+ ["StationaryDefense"];
	_dis = _dis	+ [0];
	_dir = _dir	+ [0];
	_h = _h		+ [0];
	_b = _b 		+ ["Defense"];

	_v = _v		+ ["2b14_82mm"];
	_n = _n		+ ["2b14_82mm"];
	_d = _d		+ ["Podnos 2B14"];
	_c = _c		+ [1100];
	_t = _t		+ [0];
	_i = _i		+ ["\CA\Warfare2\Images\con_gun.paa"];
	_s = _s		+ ["StationaryDefense"];
	_dis = _dis	+ [0];
	_dir = _dir	+ [0];
	_h = _h		+ [0];
	_b = _b 		+ ["Defense"];

	_v = _v		+ ["D30"];
	_n = _n		+ ["D30_RU"];
	_d = _d		+ [getText (configFile >> "CfgVehicles" >> (_n select (count _n - 1)) >> "displayName")];
	_c = _c		+ [2250];
	_t = _t		+ [0];
	_i = _i		+ ["\CA\Warfare2\Images\con_gun.paa"];
	_s = _s		+ ["StationaryDefense"];
	_dis = _dis	+ [0];
	_dir = _dir	+ [0];
	_h = _h		+ [0];
	_b = _b 		+ ["Defense"];

	_v = _v		+ ["SmallWall"];
	_n = _n		+ ["Land_HBarrier3"];
	_d = _d		+ [getText (configFile >> "CfgVehicles" >> (_n select (count _n - 1)) >> "displayName")];
	_c = _c		+ [20];
	_t = _t		+ [0];
	_i = _i		+ ["\CA\Warfare2\Images\con_wall1.paa"];
	_s = _s		+ ["StationaryDefense"];
	_dis = _dis	+ [0];
	_dir = _dir	+ [0];
	_h = _h		+ [0];
	_b = _b 		+ ["Fortification"];

	_v = _v		+ ["MediumWall"];
	_n = _n		+ ["Land_HBarrier5"];
	_d = _d		+ [getText (configFile >> "CfgVehicles" >> (_n select (count _n - 1)) >> "displayName")];
	_c = _c		+ [30];
	_t = _t		+ [0];
	_i = _i		+ ["\CA\Warfare2\Images\con_wall2.paa"];
	_s = _s		+ ["StationaryDefense"];
	_dis = _dis	+ [0];
	_dir = _dir	+ [0];
	_h = _h		+ [0];
	_b = _b 		+ ["Fortification"];

	_v = _v		+ ["LargeWall"];
	_n = _n		+ ["Land_HBarrier_large"];
	_d = _d		+ [getText (configFile >> "CfgVehicles" >> (_n select (count _n - 1)) >> "displayName")];
	_c = _c		+ [50];
	_t = _t		+ [0];
	_i = _i		+ ["\CA\Warfare2\Images\con_wall3.paa"];
	_s = _s		+ ["StationaryDefense"];
	_dis = _dis	+ [0];
	_dir = _dir	+ [0];
	_h = _h		+ [0];
	_b = _b 		+ ["Fortification"];

	_v = _v		+ ["Base_WarfareBBarrier5x"];
	_n = _n		+ ["TK_WarfareBBarrier5x_EP1"];
	_d = _d		+ [getText (configFile >> "CfgVehicles" >> (_n select (count _n - 1)) >> "displayName")];
	_c = _c		+ [15];
	_t = _t		+ [0];
	_i = _i		+ ["\CA\Warfare2\Images\con_wall3.paa"];
	_s = _s		+ ["StationaryDefense"];
	_dis = _dis	+ [0];
	_dir = _dir	+ [0];
	_h = _h		+ [0];
	_b = _b 		+ ["Fortification"];

	_v = _v		+ ["Base_WarfareBBarrier10x"];
	_n = _n		+ ["TK_WarfareBBarrier10x_EP1"];
	_d = _d		+ [getText (configFile >> "CfgVehicles" >> (_n select (count _n - 1)) >> "displayName")];
	_c = _c		+ [25];
	_t = _t		+ [0];
	_i = _i		+ ["\CA\Warfare2\Images\con_wall3.paa"];
	_s = _s		+ ["StationaryDefense"];
	_dis = _dis	+ [0];
	_dir = _dir	+ [0];
	_h = _h		+ [0];
	_b = _b 		+ ["Fortification"];

	_v = _v		+ ["Base_WarfareBBarrier10xTall"];
	_n = _n		+ ["TK_WarfareBBarrier10xTall_EP1"];
	_d = _d		+ [getText (configFile >> "CfgVehicles" >> (_n select (count _n - 1)) >> "displayName")];
	_c = _c		+ [50];
	_t = _t		+ [0];
	_i = _i		+ ["\CA\Warfare2\Images\con_wall3.paa"];
	_s = _s		+ ["StationaryDefense"];
	_dis = _dis	+ [0];
	_dir = _dir	+ [0];
	_h = _h		+ [0];
	_b = _b 		+ ["Fortification"];

	_v = _v		+ ["MASH"];
	_n = _n		+ ["MASH_EP1"];
	_d = _d		+ [getText (configFile >> "CfgVehicles" >> (_n select (count _n - 1)) >> "displayName")];
	_c = _c		+ [30];
	_t = _t		+ [0];
	_i = _i		+ ["\CA\Warfare2\Images\con_wall1.paa"];
	_s = _s		+ ["StationaryDefense"];
	_dis = _dis	+ [0];
	_dir = _dir	+ [0];
	_h = _h		+ [0];
	_b = _b 		+ ["Strategic"];

	_v = _v		+ ["Land_fort_bagfence_long"];
	_n = _n		+ ["Land_fort_bagfence_long"];
	_d = _d		+ [getText (configFile >> "CfgVehicles" >> (_n select (count _n - 1)) >> "displayName")];
	_c = _c		+ [10];
	_t = _t		+ [0];
	_i = _i		+ ["\CA\Warfare2\Images\con_wall1.paa"];
	_s = _s		+ ["StationaryDefense"];
	_dis = _dis	+ [0];
	_dir = _dir	+ [0];
	_h = _h		+ [0];
	_b = _b 		+ ["Fortification"];

	_v = _v		+ ["Land_fort_bagfence_corner"];
	_n = _n		+ ["Land_fort_bagfence_corner"];
	_d = _d		+ [getText (configFile >> "CfgVehicles" >> (_n select (count _n - 1)) >> "displayName")];
	_c = _c		+ [8];
	_t = _t		+ [0];
	_i = _i		+ ["\CA\Warfare2\Images\con_wall1.paa"];
	_s = _s		+ ["StationaryDefense"];
	_dis = _dis	+ [0];
	_dir = _dir	+ [0];
	_h = _h		+ [0];
	_b = _b 		+ ["Fortification"];

	_v = _v		+ ["Land_fort_bagfence_round"];
	_n = _n		+ ["Land_fort_bagfence_round"];
	_d = _d		+ [getText (configFile >> "CfgVehicles" >> (_n select (count _n - 1)) >> "displayName")];
	_c = _c		+ [12];
	_t = _t		+ [0];
	_i = _i		+ ["\CA\Warfare2\Images\con_wall1.paa"];
	_s = _s		+ ["StationaryDefense"];
	_dis = _dis	+ [0];
	_dir = _dir	+ [0];
	_h = _h		+ [0];
	_b = _b 		+ ["Fortification"];

	_v = _v		+ ["Land_fortified_nest_small"];
	_n = _n		+ ["Land_fortified_nest_small_EP1"];
	_d = _d		+ [getText (configFile >> "CfgVehicles" >> (_n select (count _n - 1)) >> "displayName")];
	_c = _c		+ [40];
	_t = _t		+ [0];
	_i = _i		+ ["\CA\Warfare2\Images\con_wall1.paa"];
	_s = _s		+ ["StationaryDefense"];
	_dis = _dis	+ [0];
	_dir = _dir	+ [0];
	_h = _h		+ [0];
	_b = _b 		+ ["Fortification"];

	_v = _v		+ ["Land_fort_rampart"];
	_n = _n		+ ["Land_fort_rampart_EP1"];
	_d = _d		+ [getText (configFile >> "CfgVehicles" >> (_n select (count _n - 1)) >> "displayName")];
	_c = _c		+ [30];
	_t = _t		+ [0];
	_i = _i		+ ["\CA\Warfare2\Images\con_wall1.paa"];
	_s = _s		+ ["StationaryDefense"];
	_dis = _dis	+ [0];
	_dir = _dir	+ [0];
	_h = _h		+ [0];
	_b = _b 		+ ["Fortification"];

	_v = _v		+ ["Land_fort_artillery_nest"];
	_n = _n		+ ["Land_fort_artillery_nest_EP1"];
	_d = _d		+ [getText (configFile >> "CfgVehicles" >> (_n select (count _n - 1)) >> "displayName")];
	_c = _c		+ [65];
	_t = _t		+ [0];
	_i = _i		+ ["\CA\Warfare2\Images\con_wall1.paa"];
	_s = _s		+ ["StationaryDefense"];
	_dis = _dis	+ [0];
	_dir = _dir	+ [0];
	_h = _h		+ [0];
	_b = _b 		+ ["Fortification"];

	_v = _v		+ ["Hhedgehog_concreteBig"];
	_n = _n		+ ["Hhedgehog_concreteBig"];
	_d = _d		+ [getText (configFile >> "CfgVehicles" >> (_n select (count _n - 1)) >> "displayName")];
	_c = _c		+ [95];
	_t = _t		+ [0];
	_i = _i		+ ["\CA\Warfare2\Images\con_wall1.paa"];
	_s = _s		+ ["StationaryDefense"];
	_dis = _dis	+ [0];
	_dir = _dir	+ [0];
	_h = _h		+ [0];
	_b = _b 		+ ["Fortification"];

	_v = _v		+ ["Hedgehog"];
	_n = _n		+ ["Hedgehog_EP1"];
	_d = _d		+ [getText (configFile >> "CfgVehicles" >> (_n select (count _n - 1)) >> "displayName")];
	_c = _c		+ [5];
	_t = _t		+ [0];
	_i = _i		+ ["\CA\Warfare2\Images\con_wall1.paa"];
	_s = _s		+ ["StationaryDefense"];
	_dis = _dis	+ [0];
	_dir = _dir	+ [0];
	_h = _h		+ [0];
	_b = _b 		+ ["Fortification"];

	_v = _v		+ ["Land_CamoNet"];
	_n = _n		+ ["Land_CamoNet_EAST_EP1"];
	_d = _d		+ [getText (configFile >> "CfgVehicles" >> (_n select (count _n - 1)) >> "displayName")];
	_c = _c		+ [35];
	_t = _t		+ [0];
	_i = _i		+ ["\CA\Warfare2\Images\con_wall1.paa"];
	_s = _s		+ ["StationaryDefense"];
	_dis = _dis	+ [0];
	_dir = _dir	+ [0];
	_h = _h		+ [0];
	_b = _b 		+ ["Strategic"];

	_v = _v		+ ["Land_CamoNetVar"];
	_n = _n		+ ["Land_CamoNetVar_EAST_EP1"];
	_d = _d		+ [getText (configFile >> "CfgVehicles" >> (_n select (count _n - 1)) >> "displayName")];
	_c = _c		+ [45];
	_t = _t		+ [0];
	_i = _i		+ ["\CA\Warfare2\Images\con_wall1.paa"];
	_s = _s		+ ["StationaryDefense"];
	_dis = _dis	+ [0];
	_dir = _dir	+ [0];
	_h = _h		+ [0];
	_b = _b 		+ ["Strategic"];

	_v = _v		+ ["Land_CamoNetB"];
	_n = _n		+ ["Land_CamoNetB_EAST_EP1"];
	_d = _d		+ [getText (configFile >> "CfgVehicles" >> (_n select (count _n - 1)) >> "displayName")];
	_c = _c		+ [55];
	_t = _t		+ [0];
	_i = _i		+ ["\CA\Warfare2\Images\con_wall1.paa"];
	_s = _s		+ ["StationaryDefense"];
	_dis = _dis	+ [0];
	_dir = _dir	+ [0];
	_h = _h		+ [0];
	_b = _b 		+ ["Strategic"];

	_v = _v		+ ["Sign_Danger"];
	_n = _n		+ ["Sign_Danger"];
	_d = _d		+ [localize 'STR_WF_Minefield'];
	_c = _c		+ [1200];
	_t = _t		+ [0];
	_i = _i		+ ["\CA\Warfare2\Images\con_wall1.paa"];
	_s = _s		+ ["StationaryDefense"];
	_dis = _dis	+ [0];
	_dir = _dir	+ [0];
	_h = _h		+ [0];
	_b = _b 		+ ["Strategic"];

	_v = _v		+ ["HeliH"];
	_n = _n		+ ["HeliH"];
	_d = _d		+ [getText (configFile >> "CfgVehicles" >> (_n select (count _n - 1)) >> "displayName")];
	_c = _c		+ [16];
	_t = _t		+ [0];
	_i = _i		+ ["\CA\Warfare2\Images\con_wall1.paa"];
	_s = _s		+ ["StationaryDefense"];
	_dis = _dis	+ [0];
	_dir = _dir	+ [0];
	_h = _h		+ [0];
	_b = _b 		+ ["Strategic"];

	_v = _v		+ ["RUOrdnanceBox"];
	_n = _n		+ ["RUOrdnanceBox"];
	_d = _d		+ [getText (configFile >> "CfgVehicles" >> (_n select (count _n - 1)) >> "displayName")];
	_c = _c		+ [850];
	_t = _t		+ [0];
	_i = _i		+ ["\CA\Warfare2\Images\con_wall1.paa"];
	_s = _s		+ ["StationaryDefense"];
	_dis = _dis	+ [0];
	_dir = _dir	+ [0];
	_h = _h		+ [0];
	_b = _b 		+ ["Ammo"];

	_v = _v		+ ["RUVehicleBox"];
	_n = _n		+ ["RUVehicleBox"];
	_d = _d		+ [getText (configFile >> "CfgVehicles" >> (_n select (count _n - 1)) >> "displayName")];
	_c = _c		+ [1200];
	_t = _t		+ [0];
	_i = _i		+ ["\CA\Warfare2\Images\con_wall1.paa"];
	_s = _s		+ ["StationaryDefense"];
	_dis = _dis	+ [0];
	_dir = _dir	+ [0];
	_h = _h		+ [0];
	_b = _b 		+ ["Ammo"];

	_v = _v		+ ["RUBasicAmmunitionBox"];
	_n = _n		+ ["RUBasicAmmunitionBox"];
	_d = _d		+ [getText (configFile >> "CfgVehicles" >> (_n select (count _n - 1)) >> "displayName")];
	_c = _c		+ [1950];
	_t = _t		+ [0];
	_i = _i		+ ["\CA\Warfare2\Images\con_wall1.paa"];
	_s = _s		+ ["StationaryDefense"];
	_dis = _dis	+ [0];
	_dir = _dir	+ [0];
	_h = _h		+ [0];
	_b = _b 		+ ["Ammo"];

	_v = _v		+ ["RUBasicWeaponsBox"];
	_n = _n		+ ["RUBasicWeaponsBox"];
	_d = _d		+ [getText (configFile >> "CfgVehicles" >> (_n select (count _n - 1)) >> "displayName")];
	_c = _c		+ [2975];
	_t = _t		+ [0];
	_i = _i		+ ["\CA\Warfare2\Images\con_wall1.paa"];
	_s = _s		+ ["StationaryDefense"];
	_dis = _dis	+ [0];
	_dir = _dir	+ [0];
	_h = _h		+ [0];
	_b = _b 		+ ["Ammo"];

	_v = _v		+ ["RULaunchersBox"];
	_n = _n		+ ["RULaunchersBox"];
	_d = _d		+ [getText (configFile >> "CfgVehicles" >> (_n select (count _n - 1)) >> "displayName")];
	_c = _c		+ [6250];
	_t = _t		+ [0];
	_i = _i		+ ["\CA\Warfare2\Images\con_wall1.paa"];
	_s = _s		+ ["StationaryDefense"];
	_dis = _dis	+ [0];
	_dir = _dir	+ [0];
	_h = _h		+ [0];
	_b = _b 		+ ["Ammo"];

	_v = _v		+ ["RUSpecialWeaponsBox"];
	_n = _n		+ ["RUSpecialWeaponsBox"];
	_d = _d		+ [getText (configFile >> "CfgVehicles" >> (_n select (count _n - 1)) >> "displayName")];
	_c = _c		+ [7500];
	_t = _t		+ [0];
	_i = _i		+ ["\CA\Warfare2\Images\con_wall1.paa"];
	_s = _s		+ ["StationaryDefense"];
	_dis = _dis	+ [0];
	_dir = _dir	+ [0];
	_h = _h		+ [0];
	_b = _b 		+ ["Ammo"];

	['WFBE_EASTDEFENSES',_v,true] Call SetNamespace;
	['WFBE_EASTDEFENSENAMES',_n,true] Call SetNamespace;
	['WFBE_EASTDEFENSEDESCRIPTIONS',_d,true] Call SetNamespace;
	['WFBE_EASTDEFENSECOSTS',_c,true] Call SetNamespace;
	['WFBE_EASTDEFENSETIMES',_t,true] Call SetNamespace;
	['WFBE_EASTDEFENSEIMAGES',_i,true] Call SetNamespace;
	['WFBE_EASTDEFENSEDISTANCES',_dis,true] Call SetNamespace;
	['WFBE_EASTDEFENSEDIRECTIONS',_dir,true] Call SetNamespace;
	['WFBE_EASTDEFENSESCRIPTS',_s,true] Call SetNamespace;
	['WFBE_EASTDEFENSEHEIGHTS',_h,true] Call SetNamespace;
	['WFBE_EASTDEFENSECATEGORIES',_b,true] Call SetNamespace;
	
	['WFBE_WESTCONSTRUCTIONSITE','US_WarfareBContructionSite_EP1',true] Call SetNamespace;
	['WFBE_EASTCONSTRUCTIONSITE','RU_WarfareBContructionSite',true] Call SetNamespace;

	//RESISTANCE STATIONARY DEFENSES
	_v			= ["MGNest"];
	_n			= ["WarfareBMGNest_PK_TK_GUE_EP1"];
	_d			= [getText (configFile >> "CfgVehicles" >> (_n select (count _n - 1)) >> "displayName")];
	_c			= [300];
	_t			= [0];
	_i			= ["\CA\Warfare2\Images\con_mg_nest.paa"];
	_s			= ["StationaryDefense"];
	_dis		= [0];
	_dir		= [0];
	_h			= [0];
	
	_v = _v		+ ["MGNestGUE"];
	_n = _n		+ ["GUE_WarfareBMGNest_PK"];
	_d = _d		+ [getText (configFile >> "CfgVehicles" >> (_n select (count _n - 1)) >> "displayName")];
	_c = _c		+ [300];
	_t = _t		+ [0];
	_i = _i		+ ["\CA\Warfare2\Images\con_mg_nest.paa"];
	_s = _s		+ ["StationaryDefense"];
	_dis = _dis	+ [0];
	_dir = _dir	+ [0];
	_h = _h		+ [0];

	['WFBE_RESISTANCEDEFENSES',_v,true] Call SetNamespace;
	['WFBE_RESISTANCEDEFENSENAMES',_n,true] Call SetNamespace;
	['WFBE_RESISTANCEDEFENSEDESCRIPTIONS',_d,true] Call SetNamespace;
	['WFBE_RESISTANCEDEFENSECOSTS',_c,true] Call SetNamespace;
	['WFBE_RESISTANCEDEFENSETIMES',_t,true] Call SetNamespace;
	['WFBE_RESISTANCEDEFENSEIMAGES',_i,true] Call SetNamespace;
	['WFBE_RESISTANCEDEFENSEDISTANCES',_dis,true] Call SetNamespace;
	['WFBE_RESISTANCEDEFENSEDIRECTIONS',_dir,true] Call SetNamespace;
	['WFBE_RESISTANCEDEFENSESCRIPTS',_s,true] Call SetNamespace;
	['WFBE_RESISTANCEDEFENSEHEIGHTS',_h,true] Call SetNamespace;
};