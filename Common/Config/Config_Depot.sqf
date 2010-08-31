Private["_c","_config","_crewCost","_data","_done","_m","_p","_soldierCost","_t","_total","_u"];

_u = [];
_c = [];
_m = [];
_t = [];
_p = [];
_z = [];

//WEST
if (WF_A2_Vanilla) then {
	_u			= ["MMT_Civ"];
	_c			= [50];
	_m			= [1];
	_t			= [10];
	_p			= [5];
	_z 			= [0];

	_u = _u		+ ["TT650_Civ"];
	_c = _c		+ [100];
	_m = _m		+ [1];
	_t = _t		+ [10];
	_p = _p		+ [5];
	_z = _z		+ [0];

	_u = _u		+ ["Lada1"];
	_c = _c		+ [175];
	_m = _m		+ [1];
	_t = _t		+ [20];
	_p = _p		+ [7];
	_z = _z		+ [0];

	_u = _u		+ ["SkodaBlue"];
	_c = _c		+ [200];
	_m = _m		+ [1];
	_t = _t		+ [20];
	_p = _p		+ [7];
	_z = _z		+ [0];

	_u = _u		+ ["car_sedan"];
	_c = _c		+ [200];
	_m = _m		+ [1];
	_t = _t		+ [20];
	_p = _p		+ [7];
	_z = _z		+ [0];

	_u = _u		+ ["car_hatchback"];
	_c = _c		+ [200];
	_m = _m		+ [1];
	_t = _t		+ [20];
	_p = _p		+ [7];
	_z = _z		+ [0];

	_u = _u		+ ["datsun1_civil_1_open"];
	_c = _c		+ [250];
	_m = _m		+ [1];
	_t = _t		+ [20];
	_p = _p		+ [7];
	_z = _z		+ [0];

	_u = _u		+ ["datsun1_civil_3_open"];
	_c = _c		+ [250];
	_m = _m		+ [1];
	_t = _t		+ [20];
	_p = _p		+ [7];
	_z = _z		+ [0];

	_u = _u		+ ["hilux1_civil_1_open"];
	_c = _c		+ [300];
	_m = _m		+ [1];
	_t = _t		+ [20];
	_p = _p		+ [7];
	_z = _z		+ [0];

	_u = _u		+ ["V3S_Civ"];
	_c = _c		+ [350];
	_m = _m		+ [1];
	_t = _t		+ [20];
	_p = _p		+ [7];
	_z = _z		+ [0];

	_u = _u		+ ["Ikarus"];
	_c = _c		+ [400];
	_m = _m		+ [1];
	_t = _t		+ [20];
	_p = _p		+ [7];
	_z = _z		+ [0];

	if (buyInfDepot) then {
		_u = _u		+ ["USMC_Soldier"];
		_c = _c		+ [150];
		_m = _m		+ [1];
		_t = _t		+ [25];
		_p = _p		+ [7];
		_z = _z		+ [0];
	};
};

if (WF_A2_Arrowhead) then {
	_u = _u		+ ["Old_bike_TK_CIV_EP1"];
	_c = _c		+ [50];
	_m = _m		+ [1];
	_t = _t		+ [10];
	_p = _p		+ [5];
	_z = _z		+ [0];
	
	_u = _u		+ ["Old_moto_TK_Civ_EP1"];
	_c = _c		+ [100];
	_m = _m		+ [1];
	_t = _t		+ [10];
	_p = _p		+ [5];
	_z = _z		+ [0];

	_u = _u		+ ["Lada1_TK_CIV_EP1"];
	_c = _c		+ [175];
	_m = _m		+ [1];
	_t = _t		+ [20];
	_p = _p		+ [7];
	_z = _z		+ [0];

	_u = _u		+ ["Volha_1_TK_CIV_EP1"];
	_c = _c		+ [250];
	_m = _m		+ [1];
	_t = _t		+ [20];
	_p = _p		+ [7];
	_z = _z		+ [0];
	
	_u = _u		+ ["LandRover_TK_CIV_EP1"];
	_c = _c		+ [300];
	_m = _m		+ [1];
	_t = _t		+ [20];
	_p = _p		+ [7];
	_z = _z		+ [0];

	_u = _u		+ ["V3S_Open_TK_CIV_EP1"];
	_c = _c		+ [350];
	_m = _m		+ [1];
	_t = _t		+ [20];
	_p = _p		+ [7];
	_z = _z		+ [0];

	_u = _u		+ ["Ikarus_TK_CIV_EP1"];
	_c = _c		+ [400];
	_m = _m		+ [1];
	_t = _t		+ [20];
	_p = _p		+ [7];
	_z = _z		+ [0];

	if (buyInfDepot) then {
		_u = _u		+ ["US_Soldier_EP1"];
		_c = _c		+ [150];
		_m = _m		+ [1];
		_t = _t		+ [25];
		_p = _p		+ [7];
		_z = _z		+ [0];
	};
};

if (WF_A2_CombinedOps) then {
	_u = _u		+ ["Old_bike_TK_CIV_EP1"];
	_c = _c		+ [50];
	_m = _m		+ [1];
	_t = _t		+ [10];
	_p = _p		+ [5];
	_z = _z		+ [0];
	
	_u			= ["MMT_Civ"];
	_c			= [70];
	_m			= [1];
	_t			= [10];
	_p			= [5];
	_z 			= [0];
	
	_u = _u		+ ["Old_moto_TK_Civ_EP1"];
	_c = _c		+ [100];
	_m = _m		+ [1];
	_t = _t		+ [10];
	_p = _p		+ [5];
	_z = _z		+ [0];

	_u = _u		+ ["Lada1_TK_CIV_EP1"];
	_c = _c		+ [175];
	_m = _m		+ [1];
	_t = _t		+ [20];
	_p = _p		+ [7];
	_z = _z		+ [0];
	
	_u = _u		+ ["SkodaBlue"];
	_c = _c		+ [200];
	_m = _m		+ [1];
	_t = _t		+ [20];
	_p = _p		+ [7];
	_z = _z		+ [0];
	
	_u = _u		+ ["car_sedan"];
	_c = _c		+ [210];
	_m = _m		+ [1];
	_t = _t		+ [20];
	_p = _p		+ [7];
	_z = _z		+ [0];

	_u = _u		+ ["car_hatchback"];
	_c = _c		+ [220];
	_m = _m		+ [1];
	_t = _t		+ [20];
	_p = _p		+ [7];
	_z = _z		+ [0];

	_u = _u		+ ["Volha_1_TK_CIV_EP1"];
	_c = _c		+ [250];
	_m = _m		+ [1];
	_t = _t		+ [20];
	_p = _p		+ [7];
	_z = _z		+ [0];
	
	_u = _u		+ ["datsun1_civil_1_open"];
	_c = _c		+ [260];
	_m = _m		+ [1];
	_t = _t		+ [20];
	_p = _p		+ [7];
	_z = _z		+ [0];

	_u = _u		+ ["datsun1_civil_3_open"];
	_c = _c		+ [270];
	_m = _m		+ [1];
	_t = _t		+ [20];
	_p = _p		+ [7];
	_z = _z		+ [0];

	_u = _u		+ ["hilux1_civil_1_open"];
	_c = _c		+ [300];
	_m = _m		+ [1];
	_t = _t		+ [20];
	_p = _p		+ [7];
	_z = _z		+ [0];
	
	_u = _u		+ ["LandRover_TK_CIV_EP1"];
	_c = _c		+ [300];
	_m = _m		+ [1];
	_t = _t		+ [20];
	_p = _p		+ [7];
	_z = _z		+ [0];

	_u = _u		+ ["V3S_Open_TK_CIV_EP1"];
	_c = _c		+ [350];
	_m = _m		+ [1];
	_t = _t		+ [20];
	_p = _p		+ [7];
	_z = _z		+ [0];

	_u = _u		+ ["Ikarus_TK_CIV_EP1"];
	_c = _c		+ [400];
	_m = _m		+ [1];
	_t = _t		+ [20];
	_p = _p		+ [7];
	_z = _z		+ [0];

	if (buyInfDepot) then {
		_u = _u		+ ["US_Soldier_EP1"];
		_c = _c		+ [150];
		_m = _m		+ [1];
		_t = _t		+ [25];
		_p = _p		+ [7];
		_z = _z		+ [0];
	};
};

_westDepotDescriptions = [];
_westDepotImages = [];
_westDepotMannedCosts = [];

_crewCost = 'WFBE_CREWCOST' Call GetNamespace;

_total = Count _u;
_done = [];
for [{_count = 0},{_count < _total},{_count = _count + 1}] do {
	if !((_u select _count) in _done) then {
		_config = configFile >> "CfgVehicles" >> (_u Select _count);
		_westDepotMannedCosts = _westDepotMannedCosts + [(_c Select _count) + (_m Select _count) * _crewCost];
		_westDepotDescriptions = _westDepotDescriptions + [GetText (_config >> "displayName")];
		_westDepotImages = _westDepotImages + [GetText (_config >> "picture")];
		_done = _done + [_u select _count];
	};
};

['WFBE_WESTDEPOTUNITS',_u,true] Call SetNamespace;
['WFBE_WESTDEPOTCOSTS',_c,true] Call SetNamespace;
['WFBE_WESTDEPOTCREWS',_m,true] Call SetNamespace;
['WFBE_WESTDEPOTTIMES',_t,true] Call SetNamespace;
['WFBE_WESTDEPOTPOINTS',_p,true] Call SetNamespace;
['WFBE_WESTDEPOTUPGRADES',_z,true] Call SetNamespace;
['WFBE_WESTDEPOTDESCRIPTIONS',_westDepotDescriptions,true] Call SetNamespace;
['WFBE_WESTDEPOTIMAGES',_westDepotImages,true] Call SetNamespace;
['WFBE_WESTDEPOTMANNEDCOSTS',_westDepotMannedCosts,true] Call SetNamespace;

_u = [];
_c = [];
_m = [];
_t = [];
_p = [];
_z = [];

//EAST
if (WF_A2_Vanilla) then {
	_u			= ["MMT_Civ"];
	_c			= [50];
	_m			= [1];
	_t			= [10];
	_p			= [5];
	_z 			= [0];

	_u = _u		+ ["TT650_Civ"];
	_c = _c		+ [100];
	_m = _m		+ [1];
	_t = _t		+ [10];
	_p = _p		+ [5];
	_z = _z		+ [0];

	_u = _u		+ ["Tractor"];
	_c = _c		+ [150];
	_m = _m		+ [1];
	_t = _t		+ [20];
	_p = _p		+ [7];
	_z = _z		+ [0];

	_u = _u		+ ["Lada2"];
	_c = _c		+ [175];
	_m = _m		+ [1];
	_t = _t		+ [20];
	_p = _p		+ [7];
	_z = _z		+ [0];

	_u = _u		+ ["LadaLM"];
	_c = _c		+ [175];
	_m = _m		+ [1];
	_t = _t		+ [20];
	_p = _p		+ [7];
	_z = _z		+ [0];

	_u = _u		+ ["SkodaRed"];
	_c = _c		+ [200];
	_m = _m		+ [1];
	_t = _t		+ [20];
	_p = _p		+ [7];
	_z = _z		+ [0];

	_u = _u		+ ["VWGolf"];
	_c = _c		+ [250];
	_m = _m		+ [1];
	_t = _t		+ [20];
	_p = _p		+ [7];
	_z = _z		+ [0];

	_u = _u		+ ["datsun1_civil_2_covered"];
	_c = _c		+ [250];
	_m = _m		+ [1];
	_t = _t		+ [20];
	_p = _p		+ [7];
	_z = _z		+ [0];

	_u = _u		+ ["hilux1_civil_2_covered"];
	_c = _c		+ [300];
	_m = _m		+ [1];
	_t = _t		+ [20];
	_p = _p		+ [7];
	_z = _z		+ [0];

	_u = _u		+ ["UralCivil"];
	_c = _c		+ [350];
	_m = _m		+ [1];
	_t = _t		+ [20];
	_p = _p		+ [7];
	_z = _z		+ [0];

	if (buyInfDepot) then {
		_u = _u		+ ["RU_Soldier"];
		_c = _c		+ [150];
		_m = _m		+ [1];
		_t = _t		+ [25];
		_p = _p		+ [7];
		_z = _z		+ [0];
	};
};

if (WF_A2_Arrowhead) then {
	_u = _u		+ ["Old_bike_TK_CIV_EP1"];
	_c = _c		+ [40];
	_m = _m		+ [1];
	_t = _t		+ [10];
	_p = _p		+ [5];
	_z = _z		+ [0];
	
	_u = _u		+ ["TT650_TK_CIV_EP1"];
	_c = _c		+ [90];
	_m = _m		+ [1];
	_t = _t		+ [10];
	_p = _p		+ [5];
	_z = _z		+ [0];

	_u = _u		+ ["Lada2_TK_CIV_EP1"];
	_c = _c		+ [155];
	_m = _m		+ [1];
	_t = _t		+ [20];
	_p = _p		+ [7];
	_z = _z		+ [0];

	_u = _u		+ ["VolhaLimo_TK_CIV_EP1"];
	_c = _c		+ [220];
	_m = _m		+ [1];
	_t = _t		+ [20];
	_p = _p		+ [7];
	_z = _z		+ [0];
	
	_u = _u		+ ["Volha_2_TK_CIV_EP1"];
	_c = _c		+ [220];
	_m = _m		+ [1];
	_t = _t		+ [20];
	_p = _p		+ [7];
	_z = _z		+ [0];

	_u = _u		+ ["Ural_TK_CIV_EP1"];
	_c = _c		+ [320];
	_m = _m		+ [1];
	_t = _t		+ [20];
	_p = _p		+ [7];
	_z = _z		+ [0];

	_u = _u		+ ["S1203_TK_CIV_EP1"];
	_c = _c		+ [340];
	_m = _m		+ [1];
	_t = _t		+ [20];
	_p = _p		+ [7];
	_z = _z		+ [0];

	if (buyInfDepot) then {
		_u = _u		+ ["TK_Soldier_EP1"];
		_c = _c		+ [150];
		_m = _m		+ [1];
		_t = _t		+ [25];
		_p = _p		+ [7];
		_z = _z		+ [0];
	};
};

if (WF_A2_CombinedOps) then {
	_u = _u		+ ["Old_bike_TK_CIV_EP1"];
	_c = _c		+ [40];
	_m = _m		+ [1];
	_t = _t		+ [10];
	_p = _p		+ [5];
	_z = _z		+ [0];

	_u			= ["MMT_Civ"];
	_c			= [50];
	_m			= [1];
	_t			= [10];
	_p			= [5];
	_z 			= [0];

	_u = _u		+ ["TT650_Civ"];
	_c = _c		+ [100];
	_m = _m		+ [1];
	_t = _t		+ [10];
	_p = _p		+ [5];
	_z = _z		+ [0];

	_u = _u		+ ["Tractor"];
	_c = _c		+ [150];
	_m = _m		+ [1];
	_t = _t		+ [20];
	_p = _p		+ [7];
	_z = _z		+ [0];

	_u = _u		+ ["Lada2_TK_CIV_EP1"];
	_c = _c		+ [175];
	_m = _m		+ [1];
	_t = _t		+ [20];
	_p = _p		+ [7];
	_z = _z		+ [0];
	
	_u = _u		+ ["SkodaRed"];
	_c = _c		+ [200];
	_m = _m		+ [1];
	_t = _t		+ [20];
	_p = _p		+ [7];
	_z = _z		+ [0];

	_u = _u		+ ["VolhaLimo_TK_CIV_EP1"];
	_c = _c		+ [200];
	_m = _m		+ [1];
	_t = _t		+ [20];
	_p = _p		+ [7];
	_z = _z		+ [0];
	
	_u = _u		+ ["Volha_2_TK_CIV_EP1"];
	_c = _c		+ [210];
	_m = _m		+ [1];
	_t = _t		+ [20];
	_p = _p		+ [7];
	_z = _z		+ [0];

	_u = _u		+ ["VWGolf"];
	_c = _c		+ [250];
	_m = _m		+ [1];
	_t = _t		+ [20];
	_p = _p		+ [7];
	_z = _z		+ [0];

	_u = _u		+ ["datsun1_civil_2_covered"];
	_c = _c		+ [250];
	_m = _m		+ [1];
	_t = _t		+ [20];
	_p = _p		+ [7];
	_z = _z		+ [0];

	_u = _u		+ ["hilux1_civil_2_covered"];
	_c = _c		+ [300];
	_m = _m		+ [1];
	_t = _t		+ [20];
	_p = _p		+ [7];
	_z = _z		+ [0];
	
	_u = _u		+ ["S1203_TK_CIV_EP1"];
	_c = _c		+ [325];
	_m = _m		+ [1];
	_t = _t		+ [20];
	_p = _p		+ [7];
	_z = _z		+ [0];

	_u = _u		+ ["Ural_TK_CIV_EP1"];
	_c = _c		+ [350];
	_m = _m		+ [1];
	_t = _t		+ [20];
	_p = _p		+ [7];
	_z = _z		+ [0];

	if (buyInfDepot) then {
		_u = _u		+ ["RU_Soldier"];
		_c = _c		+ [150];
		_m = _m		+ [1];
		_t = _t		+ [25];
		_p = _p		+ [7];
		_z = _z		+ [0];
	};
};

_eastDepotDescriptions = [];
_eastDepotImages = [];
_eastDepotMannedCosts = [];

_total = Count _u;
_done = [];
for [{_count = 0},{_count < _total},{_count = _count + 1}] do {
	if !((_u select _count) in _done) then {
		_config = configFile >> "CfgVehicles" >> (_u Select _count);
		_eastDepotMannedCosts = _eastDepotMannedCosts + [(_c Select _count) + (_m Select _count) * _crewCost];
		_eastDepotDescriptions = _eastDepotDescriptions + [GetText (_config >> "displayName")];
		_eastDepotImages = _eastDepotImages + [GetText (_config >> "picture")];
		_done = _done + [_u select _count];
	};
};

['WFBE_EASTDEPOTUNITS',_u,true] Call SetNamespace;
['WFBE_EASTDEPOTCOSTS',_c,true] Call SetNamespace;
['WFBE_EASTDEPOTCREWS',_m,true] Call SetNamespace;
['WFBE_EASTDEPOTTIMES',_t,true] Call SetNamespace;
['WFBE_EASTDEPOTPOINTS',_p,true] Call SetNamespace;
['WFBE_EASTDEPOTUPGRADES',_z,true] Call SetNamespace;
['WFBE_EASTDEPOTDESCRIPTIONS',_eastDepotDescriptions,true] Call SetNamespace;
['WFBE_EASTDEPOTIMAGES',_eastDepotImages,true] Call SetNamespace;
['WFBE_EASTDEPOTMANNEDCOSTS',_eastDepotMannedCosts,true] Call SetNamespace;

_longestDepotBuildTime = 0;
_t = ('WFBE_EASTAIRCRAFTTIMES' Call GetNamespace) + ('WFBE_WESTAIRCRAFTTIMES' Call GetNamespace);
for [{_count = Count _t - 1},{_count >= 0},{_count = _count - 1}] do {
	if (_t Select _count > _longestDepotBuildTime) then {
		_longestDepotBuildTime = _t Select _count;
	};
};

['WFBE_LONGESTDEPOTBUILDTIME',_longestDepotBuildTime,true] Call SetNamespace;

depotDistance = 21;
depotDirection = 90;