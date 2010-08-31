//*****************************************************************************************
//Description: Airport configurations.
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
	_u = _u		+ ["MV22"];
	_c = _c		+ [7000];
	_m = _m		+ [1];
	_t = _t		+ [45];
	_p = _p		+ [30];
	_z = _z		+ [1];
	
	_u = _u		+ ["C130J"];
	_c = _c		+ [9000];
	_m = _m		+ [1];
	_t = _t		+ [55];
	_p = _p		+ [50];
	_z = _z		+ [1];

	if !(advancedAir) then {
		_u = _u		+ ["F35B"];
		_c = _c		+ [25500];
		_m = _m		+ [1];
		_t = _t		+ [55];
		_p = _p		+ [50];
		_z = _z		+ [3];

		//--- MultiPurpose Harrier
		_u = _u		+ ["AV8B2"];
		_c = _c		+ [27500];
		_m = _m		+ [1];
		_t = _t		+ [55];
		_p = _p		+ [50];
		_z = _z		+ [2];

		//--- LGB Harrier
		_u = _u		+ ["AV8B"];
		_c = _c		+ [29500];
		_m = _m		+ [1];
		_t = _t		+ [55];
		_p = _p		+ [50];
		_z = _z		+ [3];

		_u = _u		+ ["A10"];
		_c = _c		+ [31450];
		_m = _m		+ [1];
		_t = _t		+ [55];
		_p = _p		+ [50];
		_z = _z		+ [3];
	};
};

//WEST
if (WF_A2_Arrowhead) then {
	_u = _u		+ ["C130J_US_EP1"];
	_c = _c		+ [9000];
	_m = _m		+ [1];
	_t = _t		+ [55];
	_p = _p		+ [50];
	_z = _z		+ [1];

	if !(advancedAir) then {
		_u = _u		+ ["A10_US_EP1"];
		_c = _c		+ [33450];
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

_westAirportDescriptions = [];
_westAirportImages = [];
_westAirportMannedCosts = [];

_total = Count _u;
_done = [];
for [{_count = 0},{_count < _total},{_count = _count + 1}] do {
	if !((_u select _count) in _done) then {
		_config = configFile >> "CfgVehicles" >> (_u Select _count);
		_westAirportMannedCosts = _westAirportMannedCosts + [(_c Select _count) + (_m Select _count) * _pilotCost];
		_westAirportDescriptions = _westAirportDescriptions + [GetText (_config >> "displayName")];
		_westAirportImages = _westAirportImages + [GetText (_config >> "picture")];
		_done = _done + [_u select _count];
	};
};

['WFBE_WESTAIRPORTUNITS',_u,true] Call SetNamespace;
['WFBE_WESTAIRPORTCOSTS',_c,true] Call SetNamespace;
['WFBE_WESTAIRPORTCREWS',_m,true] Call SetNamespace;
['WFBE_WESTAIRPORTTIMES',_t,true] Call SetNamespace;
['WFBE_WESTAIRPORTPOINTS',_p,true] Call SetNamespace;
['WFBE_WESTAIRPORTUPGRADES',_z,true] Call SetNamespace;
['WFBE_WESTAIRPORTDESCRIPTIONS',_westAirportDescriptions,true] Call SetNamespace;
['WFBE_WESTAIRPORTIMAGES',_westAirportImages,true] Call SetNamespace;
['WFBE_WESTAIRPORTMANNEDCOSTS',_westAirportMannedCosts,true] Call SetNamespace;

_u = [];
_c = [];
_m = [];
_t = [];
_p = [];
_z = [];

//EAST
if (WF_A2_Vanilla) then {
	if !(advancedAir) then {
		_u = _u		+ ["Su34"];
		_c = _c		+ [27600];
		_m = _m		+ [2];
		_t = _t		+ [55];
		_p = _p		+ [50];
		_z = _z		+ [2];
		
		_u = _u		+ ["Su25_Ins"];
		_c = _c		+ [29450];
		_m = _m		+ [1];
		_t = _t		+ [55];
		_p = _p		+ [50];
		_z = _z		+ [3];

		_u = _u		+ ["Su39"];
		_c = _c		+ [30450];
		_m = _m		+ [1];
		_t = _t		+ [55];
		_p = _p		+ [50];
		_z = _z		+ [3];
	};
};

if (WF_A2_Arrowhead) then {
	_u = _u		+ ["An2_TK_EP1"];
	_c = _c		+ [4000];
	_m = _m		+ [1];
	_t = _t		+ [55];
	_p = _p		+ [50];
	_z = _z		+ [1];

	if !(advancedAir) then {
		_u = _u		+ ["L39_TK_EP1"];
		_c = _c		+ [24500];
		_m = _m		+ [1];
		_t = _t		+ [55];
		_p = _p		+ [50];
		_z = _z		+ [2];
		
		_u = _u		+ ["Su25_TK_EP1"];
		_c = _c		+ [28950];
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

_pilotCost = 120;

_eastAirportDescriptions = [];
_eastAirportImages = [];
_eastAirportMannedCosts = [];

_total = Count _u;
_done = [];
for [{_count = 0},{_count < _total},{_count = _count + 1}] do {
	if !((_u select _count) in _done) then {
		_config = configFile >> "CfgVehicles" >> (_u Select _count);
		_eastAirportMannedCosts = _eastAirportMannedCosts + [(_c Select _count) + (_m Select _count) * _pilotCost];
		_eastAirportDescriptions = _eastAirportDescriptions + [GetText (_config >> "displayName")];
		_eastAirportImages = _eastAirportImages + [GetText (_config >> "picture")];
		_done = _done + [_u select _count];
	};
};

['WFBE_EASTAIRPORTUNITS',_u,true] Call SetNamespace;
['WFBE_EASTAIRPORTCOSTS',_c,true] Call SetNamespace;
['WFBE_EASTAIRPORTCREWS',_m,true] Call SetNamespace;
['WFBE_EASTAIRPORTTIMES',_t,true] Call SetNamespace;
['WFBE_EASTAIRPORTPOINTS',_p,true] Call SetNamespace;
['WFBE_EASTAIRPORTUPGRADES',_z,true] Call SetNamespace;
['WFBE_EASTAIRPORTDESCRIPTIONS',_eastAirportDescriptions,true] Call SetNamespace;
['WFBE_EASTAIRPORTIMAGES',_eastAirportImages,true] Call SetNamespace;
['WFBE_EASTAIRPORTMANNEDCOSTS',_eastAirportMannedCosts,true] Call SetNamespace;

_longestAirportBuildTime = 0;
_t = ('WFBE_EASTAIRPORTTIMES' Call GetNamespace) + ('WFBE_WESTAIRPORTTIMES' Call GetNamespace);
for [{_count = Count _t - 1},{_count >= 0},{_count = _count - 1}] do {
	if (_t Select _count > _longestAirportBuildTime) then	{
		_longestAirportBuildTime = _t Select _count;
	};
};

['WFBE_LONGESTAIRPORTBUILDTIME',_longestAirportBuildTime,true] Call SetNamespace;

airportDistance = 60;
airportDirection = 180;