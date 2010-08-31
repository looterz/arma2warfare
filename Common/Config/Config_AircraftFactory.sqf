//*****************************************************************************************
//Description: Aircraft factory configurations.
//*****************************************************************************************
Private["_c","_config","_d","_data","_done","_m","_p","_pilotCost","_t","_total","_u"];

_u = [];
_c = [];
_m = [];
_t = [];
_p = [];
_z = [];

//WEST
if (WF_A2_Vanilla) then {
	_u = _u		+ ["MH60S"];
	_c = _c		+ [5000];
	_m = _m		+ [2];
	_t = _t		+ [35];
	_p = _p		+ [20];
	_z = _z		+ [0];

	if !(advancedAir) then {
		_u = _u		+ ["UH1Y"];
		_c = _c		+ [8000];
		_m = _m		+ [2];
		_t = _t		+ [40];
		_p = _p		+ [30];
		_z = _z		+ [1];

		_u = _u		+ ["MV22"];
		_c = _c		+ [9000];
		_m = _m		+ [1];
		_t = _t		+ [40];
		_p = _p		+ [30];
		_z = _z		+ [0];

		_u = _u		+ ["C130J"];
		_c = _c		+ [10000];
		_m = _m		+ [1];
		_t = _t		+ [55];
		_p = _p		+ [50];
		_z = _z		+ [1];

		_u = _u		+ ["AH1Z"];
		_c = _c		+ [24850];
		_m = _m		+ [2];
		_t = _t		+ [55];
		_p = _p		+ [50];
		_z = _z		+ [2];
		
		_u = _u		+ ["AH64D"];
		_c = _c		+ [27000];
		_m = _m		+ [2];
		_t = _t		+ [60];
		_p = _p		+ [50];
		_z = _z		+ [2];

		_u = _u		+ ["F35B"];
		_c = _c		+ [27500];
		_m = _m		+ [1];
		_t = _t		+ [55];
		_p = _p		+ [50];
		_z = _z		+ [3];

		//--- MultiPurpose Harrier
		_u = _u		+ ["AV8B2"];
		_c = _c		+ [29500];
		_m = _m		+ [1];
		_t = _t		+ [55];
		_p = _p		+ [50];
		_z = _z		+ [2];

		//--- LGB Harrier
		_u = _u		+ ["AV8B"];
		_c = _c		+ [31500];
		_m = _m		+ [1];
		_t = _t		+ [55];
		_p = _p		+ [50];
		_z = _z		+ [3];

		_u = _u		+ ["A10"];
		_c = _c		+ [33450];
		_m = _m		+ [1];
		_t = _t		+ [55];
		_p = _p		+ [50];
		_z = _z		+ [3];
		
		_u = _u		+ ["AH64D_Sidewinders"];
		_c = _c		+ [36250];
		_m = _m		+ [2];
		_t = _t		+ [50];
		_p = _p		+ [50];
		_z = _z		+ [3];
	};
};

if (WF_A2_Arrowhead) then {
	_u = _u		+ ["MH6J_EP1"];
	_c = _c		+ [4500];
	_m = _m		+ [1];
	_t = _t		+ [35];
	_p = _p		+ [20];
	_z = _z		+ [0];
	
	_u = _u		+ ["UH60M_EP1"];
	_c = _c		+ [5000];
	_m = _m		+ [2];
	_t = _t		+ [35];
	_p = _p		+ [20];
	_z = _z		+ [0];
		
	_u = _u		+ ["UH60M_MEV_EP1"];
	_c = _c		+ [5500];
	_m = _m		+ [2];
	_t = _t		+ [35];
	_p = _p		+ [20];
	_z = _z		+ [0];
	
	_u = _u		+ ["CH_47F_EP1"];
	_c = _c		+ [7000];
	_m = _m		+ [2];
	_t = _t		+ [40];
	_p = _p		+ [20];
	_z = _z		+ [0];

	if !(advancedAir) then {
		_u = _u		+ ["C130J_US_EP1"];
		_c = _c		+ [10000];
		_m = _m		+ [1];
		_t = _t		+ [55];
		_p = _p		+ [50];
		_z = _z		+ [1];
		
		_u = _u		+ ["AH6J_EP1"];
		_c = _c		+ [13500];
		_m = _m		+ [1];
		_t = _t		+ [50];
		_p = _p		+ [50];
		_z = _z		+ [1];

		_u = _u		+ ["AH64D_EP1"];
		_c = _c		+ [29000];
		_m = _m		+ [2];
		_t = _t		+ [60];
		_p = _p		+ [50];
		_z = _z		+ [2];

		_u = _u		+ ["A10_US_EP1"];
		_c = _c		+ [36450];
		_m = _m		+ [1];
		_t = _t		+ [55];
		_p = _p		+ [50];
		_z = _z		+ [3];
	};
};

if (WF_A2_CombinedOps) then {
	_u = _u		+ ["MH6J_EP1"];
	_c = _c		+ [5000];
	_m = _m		+ [2];
	_t = _t		+ [35];
	_p = _p		+ [20];
	_z = _z		+ [0];

	_u = _u		+ ["MV22"];
	_c = _c		+ [5500];
	_m = _m		+ [1];
	_t = _t		+ [40];
	_p = _p		+ [30];
	_z = _z		+ [0];
	
	_u = _u		+ ["UH60M_EP1"];
	_c = _c		+ [6500];
	_m = _m		+ [2];
	_t = _t		+ [35];
	_p = _p		+ [20];
	_z = _z		+ [0];
		
	//--- Medevac Blackhawk with respawn function
	_u = _u		+ ["UH60M_MEV_EP1"];
	_c = _c		+ [7500];
	_m = _m		+ [2];
	_t = _t		+ [35];
	_p = _p		+ [20];
	_z = _z		+ [0];

	_u = _u		+ ["C130J_US_EP1"];
	_c = _c		+ [10000];
	_m = _m		+ [1];
	_t = _t		+ [55];
	_p = _p		+ [50];
	_z = _z		+ [0];

	if !(advancedAir) then {
	
		_u = _u		+ ["CH_47F_EP1"];
		_c = _c		+ [10000];
		_m = _m		+ [2];
		_t = _t		+ [40];
		_p = _p		+ [20];
		_z = _z		+ [1];
		
		_u = _u		+ ["AH6J_EP1"];
		_c = _c		+ [12500];
		_m = _m		+ [1];
		_t = _t		+ [50];
		_p = _p		+ [50];
		_z = _z		+ [1];

		_u = _u		+ ["UH1Y"];
		_c = _c		+ [17500];
		_m = _m		+ [2];
		_t = _t		+ [40];
		_p = _p		+ [30];
		_z = _z		+ [1];

		//--- Harrier with Mk82 Iron Bombs
		_u = _u		+ ["AV8B2"];
		_c = _c		+ [22500];
		_m = _m		+ [1];
		_t = _t		+ [55];
		_p = _p		+ [50];
		_z = _z		+ [2];

		//--- Harrier with GBU 12 LGB
		_u = _u		+ ["AV8B"];
		_c = _c		+ [25000];
		_m = _m		+ [1];
		_t = _t		+ [55];
		_p = _p		+ [50];
		_z = _z		+ [2];	

		//--- Apache with FLIR/Hellfire + unguided rockets
		_u = _u		+ ["AH64D_EP1"];
		_c = _c		+ [27500];
		_m = _m		+ [2];
		_t = _t		+ [60];
		_p = _p		+ [50];
		_z = _z		+ [2];

		//--- Cobra with Hellfire/Sidewinder/unguided rockets
		_u = _u		+ ["AH1Z"];
		_c = _c		+ [30000];
		_m = _m		+ [2];
		_t = _t		+ [55];
		_p = _p		+ [50];
		_z = _z		+ [3];
			
		//--- A10 with FLIR/Maverick/GBU12 LGB/Sidewinder/unguided rockets
		_u = _u		+ ["A10_US_EP1"];
		_c = _c		+ [35000];
		_m = _m		+ [1];
		_t = _t		+ [55];
		_p = _p		+ [50];
		_z = _z		+ [3];
			
		//--- F35 with GBU12 LGB/Sidewinder/Maverick
		_u = _u		+ ["F35B"];
		_c =  if (balancing) then {_c + [40000]} else {_c + [30000]};
		_m = _m		+ [1];
		_t = _t		+ [55];
		_p = _p		+ [50];
		_z = _z		+ [3];
		
	};
};

_pilotCost = 120;

_westAircraftDescriptions = [];
_westAircraftImages = [];
_westAircraftMannedCosts = [];

_total = Count _u;
_done = [];
for [{_count = 0},{_count < _total},{_count = _count + 1}] do {
	if !((_u select _count) in _done) then {
		_config = configFile >> "CfgVehicles" >> (_u Select _count);
		_westAircraftMannedCosts = _westAircraftMannedCosts + [(_c Select _count) + (_m Select _count) * _pilotCost];
		_westAircraftDescriptions = _westAircraftDescriptions + [GetText (_config >> "displayName")];
		_westAircraftImages = _westAircraftImages + [GetText (_config >> "picture")];
		_done = _done + [_u select _count];
	};
};

['WFBE_WESTAIRCRAFTUNITS',_u,true] Call SetNamespace;
['WFBE_WESTAIRCRAFTCOSTS',_c,true] Call SetNamespace;
['WFBE_WESTAIRCRAFTCREWS',_m,true] Call SetNamespace;
['WFBE_WESTAIRCRAFTTIMES',_t,true] Call SetNamespace;
['WFBE_WESTAIRCRAFTPOINTS',_p,true] Call SetNamespace;
['WFBE_WESTAIRCRAFTUPGRADES',_z,true] Call SetNamespace;
['WFBE_WESTAIRCRAFTDESCRIPTIONS',_westAircraftDescriptions,true] Call SetNamespace;
['WFBE_WESTAIRCRAFTIMAGES',_westAircraftImages,true] Call SetNamespace;
['WFBE_WESTAIRCRAFTMANNEDCOSTS',_westAircraftMannedCosts,true] Call SetNamespace;

if (allies) then {
	_westAlliesAircraftDescriptions = [];
	_eastAlliesAircraftDescriptions = [];
	
	//--- CDF Allies.
	_u			= ["Mi17_CDF"];
	_c			= [5000];
	_t			= [35];
	_m			= [1];

	_u = _u		+ ["Mi24_D"];
	_c = _c		+ [14000];
	_t = _t		+ [40];
	_m = _m		+ [2];

	_total = count _u;
	for [{_count = 0},{_count < _total},{_count = _count + 1}] do {
		_config = configFile >> "CfgVehicles" >> (_u select _count);
		_westAlliesAircraftDescriptions = _westAlliesAircraftDescriptions + [getText (_config >> "displayName")];
	};

	['WFBE_WESTALLIESAIRCRAFTUNITS',_u,true] Call SetNamespace;
	['WFBE_WESTALLIESAIRCRAFTCOSTS',_c,true] Call SetNamespace;
	['WFBE_WESTALLIESAIRCRAFTCREWS',_m,true] Call SetNamespace;
	['WFBE_WESTALLIESAIRCRAFTTIMES',_t,true] Call SetNamespace;
	['WFBE_WESTALLIESAIRCRAFTDESCRIPTIONS',_westAlliesAircraftDescriptions,true] Call SetNamespace;
	
	['WFBE_WESTALLIESPILOT','CDF_Soldier_Pilot',true] Call SetNamespace;
	
	//--- Insurgent Allies.
	_u			= ["Mi17_Ins"];
	_c			= [5000];
	_t			= [35];
	_m			= [1];

	_u = _u		+ ["Su25_Ins"];
	_c = _c		+ [25000];
	_t = _t		+ [40];
	_m = _m		+ [2];

	_total = count _u;
	for [{_count = 0},{_count < _total},{_count = _count + 1}] do {
		_config = configFile >> "CfgVehicles" >> (_u select _count);
		_eastAlliesAircraftDescriptions = _eastAlliesAircraftDescriptions + [getText (_config >> "displayName")];
	};

	['WFBE_EASTALLIESAIRCRAFTUNITS',_u,true] Call SetNamespace;
	['WFBE_EASTALLIESAIRCRAFTCOSTS',_c,true] Call SetNamespace;
	['WFBE_EASTALLIESAIRCRAFTCREWS',_m,true] Call SetNamespace;
	['WFBE_EASTALLIESAIRCRAFTTIMES',_t,true] Call SetNamespace;
	['WFBE_EASTALLIESAIRCRAFTDESCRIPTIONS',_eastAlliesAircraftDescriptions,true] Call SetNamespace;
	
	['WFBE_EASTALLIESPILOT','Ins_Soldier_Pilot',true] Call SetNamespace;
} else {
	['WFBE_WESTALLIESAIRCRAFTUNITS',[],true] Call SetNamespace;
	['WFBE_WESTALLIESAIRCRAFTCOSTS',[],true] Call SetNamespace;
	['WFBE_WESTALLIESAIRCRAFTDESCRIPTIONS',[],true] Call SetNamespace;
	['WFBE_EASTALLIESAIRCRAFTUNITS',[],true] Call SetNamespace;
	['WFBE_EASTALLIESAIRCRAFTCOSTS',[],true] Call SetNamespace;
	['WFBE_EASTALLIESAIRCRAFTDESCRIPTIONS',[],true] Call SetNamespace;
};

_u = [];
_c = [];
_m = [];
_t = [];
_p = [];
_z = [];

if (WF_A2_Vanilla) then {
	_u = _u		+ ["Mi17_Ins"];
	_c = _c		+ [5000];
	_m = _m		+ [2];
	_t = _t		+ [35];
	_p = _p		+ [20];
	_z = _z		+ [0];

	if !(advancedAir) then {
		_u = _u		+ ["Mi17_medevac_RU"];
		_c = _c		+ [5500];
		_m = _m		+ [1];
		_t = _t		+ [35];
		_p = _p		+ [10];
		_z = _z		+ [0];

		_u = _u		+ ["Mi17_rockets_RU"];
		_c = _c		+ [16500];
		_m = _m		+ [2];
		_t = _t		+ [45];
		_p = _p		+ [40];
		_z = _z		+ [1];

		_u = _u		+ ["Mi24_V"];
		_c = _c		+ [19850];
		_m = _m		+ [2];
		_t = _t		+ [55];
		_p = _p		+ [50];
		_z = _z		+ [2];

		_u = _u		+ ["Mi24_P"];
		_c = _c		+ [20150];
		_m = _m		+ [2];
		_t = _t		+ [55];
		_p = _p		+ [50];
		_z = _z		+ [2];

		_u = _u		+ ["Su34"];
		_c = _c		+ [29600];
		_m = _m		+ [2];
		_t = _t		+ [55];
		_p = _p		+ [50];
		_z = _z		+ [2];

		_u = _u		+ ["Su25_Ins"];
		_c = _c		+ [31450];
		_m = _m		+ [1];
		_t = _t		+ [55];
		_p = _p		+ [50];
		_z = _z		+ [3];

		_u = _u		+ ["Su39"];
		_c = _c		+ [32450];
		_m = _m		+ [1];
		_t = _t		+ [55];
		_p = _p		+ [50];
		_z = _z		+ [3];

		if (!kamov) then {
			_u = _u		+ ["Ka52"];
			_c = if (balancing) then {_c + [26250]} else {_c + [45250]};
			_m = _m		+ [2];
			_t = _t		+ [55];
			_p = _p		+ [50];
			_z = _z		+ [3];

			_u = _u		+ ["Ka52Black"];
			_c =  if (balancing) then {_c + [26250]} else {_c + [45250]};
			_m = _m		+ [2];
			_t = _t		+ [55];
			_p = _p		+ [50];
			_z = _z		+ [3];	
		};
	};
};

if (WF_A2_Arrowhead) then {
	_u = _u		+ ["Mi17_TK_EP1"];
	_c = _c		+ [5000];
	_m = _m		+ [2];
	_t = _t		+ [35];
	_p = _p		+ [20];
	_z = _z		+ [0];
	
	_u = _u		+ ["UH1H_TK_EP1"];
	_c = _c		+ [6000];
	_m = _m		+ [2];
	_t = _t		+ [35];
	_p = _p		+ [20];
	_z = _z		+ [0];

	if !(advancedAir) then {
		_u = _u		+ ["An2_TK_EP1"];
		_c = _c		+ [6000];
		_m = _m		+ [1];
		_t = _t		+ [35];
		_p = _p		+ [10];
		_z = _z		+ [0];

		_u = _u		+ ["Mi24_D_TK_EP1"];
		_c = _c		+ [16500];
		_m = _m		+ [2];
		_t = _t		+ [45];
		_p = _p		+ [40];
		_z = _z		+ [1];
		
		_u = _u		+ ["L39_TK_EP1"];
		_c = _c		+ [26500];
		_m = _m		+ [1];
		_t = _t		+ [55];
		_p = _p		+ [50];
		_z = _z		+ [2];
		
		_u = _u		+ ["Su25_TK_EP1"];
		_c = _c		+ [30950];
		_m = _m		+ [1];
		_t = _t		+ [55];
		_p = _p		+ [50];
		_z = _z		+ [3];
	};
};

if (WF_A2_CombinedOps) then {
	_u = _u		+ ["Mi17_TK_EP1"];
	_c = _c		+ [5000];
	_m = _m		+ [2];
	_t = _t		+ [35];
	_p = _p		+ [20];
	_z = _z		+ [0];

	//--- Medevac Hip with respawn function
	_u = _u		+ ["Mi17_medevac_RU"];
	_c = _c		+ [6000];
	_m = _m		+ [1];
	_t = _t		+ [35];
	_p = _p		+ [10];
	_z = _z		+ [1];
	
	_u = _u		+ ["UH1H_TK_EP1"];
	_c = _c		+ [7500];
	_m = _m		+ [2];
	_t = _t		+ [35];
	_p = _p		+ [20];
	_z = _z		+ [1];

	//--- Antonov with FAB 250 iron bombs 
	_u = _u		+ ["An2_TK_EP1"];
	_c =  if (balancing) then {_c + [12500]} else {_c + [7500]};
	_m = _m		+ [1];
	_t = _t		+ [35];
	_p = _p		+ [10];
	_z = _z		+ [0];
		
	_u = _u		+ ["Mi17_rockets_RU"];
	_c = _c		+ [15000];
	_m = _m		+ [2];
	_t = _t		+ [45];
	_p = _p		+ [40];
	_z = _z		+ [1];

	if !(advancedAir) then {

		//--- AeroL39 with Sidewinder/unguided HE rockets 
		_u = _u		+ ["L39_TK_EP1"];
		_c = _c		+ [15000];
		_m = _m		+ [1];
		_t = _t		+ [55];
		_p = _p		+ [50];
		_z = _z		+ [1];

		//--- Hind with R 73 AA missile/unguided HE rockets 
		_u = _u		+ ["Mi24_D_TK_EP1"];
		_c = _c		+ [17500];
		_m = _m		+ [2];
		_t = _t		+ [45];
		_p = _p		+ [40];
		_z = _z		+ [1];

		//--- Hind with 4 AT2/FAB 250 iron bombs/fixed machine cannon/unguided AP rockets 
		_u = _u		+ ["Mi24_P"];
		_c = _c		+ [20000];
		_m = _m		+ [2];
		_t = _t		+ [55];
		_p = _p		+ [50];
		_z = _z		+ [1];
	
		//--- Hind with 12 AT2/unguided AP rockets 
		_u = _u		+ ["Mi24_V"];
		_c =  if (balancing) then {_c + [25000]} else {_c + [20000]};
		_m = _m		+ [2];
		_t = _t		+ [55];
		_p = _p		+ [50];
		_z = _z		+ [1];
	
		//--- Frogfoot with FAB 250 iron bombs/S73 AA missiles/unguided HE rockets 
		_u = _u		+ ["Su25_TK_EP1"];
		_c =  if (balancing) then {_c + [27500]} else {_c + [27500]};
		_m = _m		+ [1];
		_t = _t		+ [55];
		_p = _p		+ [50];
		_z = _z		+ [2];
	
		//--- Kamov with Hellfire/unguided AP rockets 
		_u = _u		+ ["Ka52"];
		_c =  if (balancing) then {_c + [27500]} else {_c + [45000]};
		_m = _m		+ [2];
		_t = _t		+ [55];
		_p = _p		+ [50];
		_z = _z		+ [2];

		//--- Kamov with Hellfire/unguided AP rockets/S73 AA missiles 
		_u = _u		+ ["Ka52Black"];
		_c =  if (balancing) then {_c + [30000]} else {_c + [45000]};
		_m = _m		+ [2];
		_t = _t		+ [55];
		_p = _p		+ [50];
		_z = _z		+ [3];

		//--- Frogfoot with Ch29 missiles/s73 AA missiles/unguided HE rockets 
		_u = _u		+ ["Su39"];
		_c = _c		+ [35000];
		_m = _m		+ [1];
		_t = _t		+ [55];
		_p = _p		+ [50];
		_z = _z		+ [3];

		//--- SU34 with Ch29 missiles/S73 AA missiles/unguided AP rockets 
		_u = _u		+ ["Su34"];
		_c = _c		+ [40000];
		_m = _m		+ [2];
		_t = _t		+ [55];
		_p = _p		+ [50];
		_z = _z		+ [3];
	
	};
};

//EAST
_pilotCost = 120;

_eastAircraftDescriptions = [];
_eastAircraftImages = [];
_eastAircraftMannedCosts = [];

_total = Count _u;
_done = [];
for [{_count = 0},{_count < _total},{_count = _count + 1}] do {
	if !((_u select _count) in _done) then {
		_config = configFile >> "CfgVehicles" >> (_u Select _count);
		_eastAircraftMannedCosts = _eastAircraftMannedCosts + [(_c Select _count) + (_m Select _count) * _pilotCost];
		_eastAircraftDescriptions = _eastAircraftDescriptions + [GetText (_config >> "displayName")];
		_eastAircraftImages = _eastAircraftImages + [GetText (_config >> "picture")];
		_done = _done + [_u select _count];
	};
};

['WFBE_EASTAIRCRAFTUNITS',_u,true] Call SetNamespace;
['WFBE_EASTAIRCRAFTCOSTS',_c,true] Call SetNamespace;
['WFBE_EASTAIRCRAFTCREWS',_m,true] Call SetNamespace;
['WFBE_EASTAIRCRAFTTIMES',_t,true] Call SetNamespace;
['WFBE_EASTAIRCRAFTPOINTS',_p,true] Call SetNamespace;
['WFBE_EASTAIRCRAFTUPGRADES',_z,true] Call SetNamespace;
['WFBE_EASTAIRCRAFTDESCRIPTIONS',_eastAircraftDescriptions,true] Call SetNamespace;
['WFBE_EASTAIRCRAFTIMAGES',_eastAircraftImages,true] Call SetNamespace;
['WFBE_EASTAIRCRAFTMANNEDCOSTS',_eastAircraftMannedCosts,true] Call SetNamespace;

//RESISTANCE
_u			= [];
_c			= [];
_m			= [];
_t			= [];
_p			= [];

_pilotCost = 120;

_resistanceAircraftDescriptions = [];
_resistanceAircraftImages = [];
_resistanceAircraftMannedCosts = [];

_total = Count _u;
for [{_count = 0},{_count < _total},{_count = _count + 1}] do {
	_config = configFile >> "CfgVehicles" >> (_u Select _count);
	_resistanceAircraftMannedCosts = _resistanceAircraftMannedCosts + [(_c Select _count) + (_m Select _count) * _pilotCost];
	_resistanceAircraftDescriptions = _resistanceAircraftDescriptions + [GetText (_config >> "displayName")];
	_resistanceAircraftImages = _resistanceAircraftImages + [GetText (_config >> "picture")];
};

['WFBE_GUERAIRCRAFTUNITS',_u,true] Call SetNamespace;
['WFBE_GUERAIRCRAFTCOSTS',_c,true] Call SetNamespace;
['WFBE_GUERAIRCRAFTCREWS',_m,true] Call SetNamespace;
['WFBE_GUERAIRCRAFTTIMES',_t,true] Call SetNamespace;
['WFBE_GUERAIRCRAFTPOINTS',_p,true] Call SetNamespace;
['WFBE_GUERAIRCRAFTDESCRIPTIONS',_resistanceAircraftDescriptions,true] Call SetNamespace;
['WFBE_GUERAIRCRAFTIMAGES',_resistanceAircraftImages,true] Call SetNamespace;
['WFBE_GUERAIRCRAFTMANNEDCOSTS',_resistanceAircraftMannedCosts,true] Call SetNamespace;

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

_u = [];
_c = [];

if (WF_A2_Vanilla) then {
	_u = _u		+ ["Pchela1T"];
	_c = _c		+ [9000];
	
	_u = _u		+ ["MQ9PredatorB"];
	_c = _c		+ [16500];
	
	['WFBE_WESTUAV','MQ9PredatorB',true] Call SetNamespace;
	['WFBE_EASTUAV','Pchela1T',true] Call SetNamespace;
};

if (WF_A2_Arrowhead) then {
	_u = _u		+ ["MQ9PredatorB_US_EP1"];
	_c = _c		+ [16500];
	
	['WFBE_WESTUAV','MQ9PredatorB_US_EP1',true] Call SetNamespace;
	_eastuav = 'WFBE_EASTUAV' Call GetNamespace;
	if (isNil '_eastuav') then {['WFBE_EASTUAV','',true] Call SetNamespace};
};

if (WF_A2_CombinedOps) then {
	_u = _u		+ ["Pchela1T"];
	_c = _c		+ [9000];
	
	_u = _u		+ ["MQ9PredatorB_US_EP1"];
	_c = _c		+ [16500];
	
	['WFBE_WESTUAV','MQ9PredatorB_US_EP1',true] Call SetNamespace;
	['WFBE_EASTUAV','Pchela1T',true] Call SetNamespace;
};

_uavAircraftDescriptions = [];

_total = Count _u;
for [{_count = 0},{_count < _total},{_count = _count + 1}] do {
	_config = configFile >> "CfgVehicles" >> (_u Select _count);
	_uavAircraftDescriptions = _uavAircraftDescriptions + [GetText (_config >> "displayName")];
};

_uavAircraftUnits = _u;
_uavAircraftCosts = _c;

['WFBE_AIRCRAFTUNITS',('WFBE_WESTAIRCRAFTUNITS' Call GetNamespace) + ('WFBE_EASTAIRCRAFTUNITS' Call GetNamespace) + ('WFBE_GUERAIRCRAFTUNITS' Call GetNamespace) + _uavAircraftUnits + ('WFBE_WESTALLIESAIRCRAFTUNITS' Call GetNamespace) + ('WFBE_EASTALLIESAIRCRAFTUNITS' Call GetNamespace),true] Call SetNamespace;
['WFBE_AIRCRAFTUNITCOSTS',('WFBE_WESTAIRCRAFTCOSTS' Call GetNamespace) + ('WFBE_EASTAIRCRAFTCOSTS' Call GetNamespace) + ('WFBE_GUERAIRCRAFTCOSTS' Call GetNamespace) + _uavAircraftCosts + ('WFBE_WESTALLIESAIRCRAFTCOSTS' Call GetNamespace) + ('WFBE_EASTALLIESAIRCRAFTCOSTS' Call GetNamespace),true] Call SetNamespace;
['WFBE_AIRCRAFTUNITDESCRIPTIONS',('WFBE_WESTAIRCRAFTDESCRIPTIONS' Call GetNamespace) + ('WFBE_EASTAIRCRAFTDESCRIPTIONS' Call GetNamespace) + ('WFBE_GUERAIRCRAFTDESCRIPTIONS' Call GetNamespace) + _uavAircraftDescriptions + ('WFBE_WESTALLIESAIRCRAFTDESCRIPTIONS' Call GetNamespace) + ('WFBE_EASTALLIESAIRCRAFTDESCRIPTIONS' Call GetNamespace),true] Call SetNamespace;

_longestAircraftBuildTime = 0;
_t = ('WFBE_EASTAIRCRAFTTIMES' Call GetNamespace) + ('WFBE_WESTAIRCRAFTTIMES' Call GetNamespace) + ('WFBE_GUERAIRCRAFTTIMES' Call GetNamespace);
for [{_count = Count _t - 1},{_count >= 0},{_count = _count - 1}] do {
	if (_t Select _count > _longestAircraftBuildTime) then {
		_longestAircraftBuildTime = _t Select _count;
	};
};

['WFBE_LONGESTAIRCRAFTBUILDTIME',_longestAircraftBuildTime,true] Call SetNamespace;