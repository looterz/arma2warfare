Private["_config","_crewCost","_data","_done","_soldierCost","_total","_u"];

_u = [];
_c = [];
_m = [];
_t = [];
_p = [];
_z = [];

//WEST
if (WF_A2_Vanilla) then {
	_u			= ["MMT_Civ"];
	_u = _u		+ ["TT650_Civ"];
	_u = _u		+ ["Lada1"];
	_u = _u		+ ["SkodaBlue"];
	_u = _u		+ ["car_sedan"];
	_u = _u		+ ["car_hatchback"];
	_u = _u		+ ["datsun1_civil_1_open"];
	_u = _u		+ ["datsun1_civil_3_open"];
	_u = _u		+ ["hilux1_civil_1_open"];
	_u = _u		+ ["V3S_Civ"];
	_u = _u		+ ["Ikarus"];
	if (paramPurchaseInfDepot) then {
		_u = _u		+ ["USMC_Soldier"];
	};
};

if (WF_A2_Arrowhead) then {
	_u 			= ["Old_bike_TK_CIV_EP1"];
	_u = _u		+ ["Old_moto_TK_Civ_EP1"];
	_u = _u		+ ["Lada1_TK_CIV_EP1"];
	_u = _u		+ ["Volha_1_TK_CIV_EP1"];
	_u = _u		+ ["LandRover_TK_CIV_EP1"];
	_u = _u		+ ["V3S_Open_TK_CIV_EP1"];
	_u = _u		+ ["Ikarus_TK_CIV_EP1"];
	if (paramPurchaseInfDepot) then {
		_u = _u		+ ["US_Soldier_EP1"];
	};
};

if (WF_A2_CombinedOps) then {
	_u 			= ["Old_bike_TK_CIV_EP1"];
	_u = _u		+ ["MMT_Civ"];
	_u = _u		+ ["Old_moto_TK_Civ_EP1"];
	_u = _u		+ ["Lada1_TK_CIV_EP1"];
	_u = _u		+ ["SkodaBlue"];
	_u = _u		+ ["car_sedan"];
	_u = _u		+ ["car_hatchback"];
	_u = _u		+ ["Volha_1_TK_CIV_EP1"];
	_u = _u		+ ["datsun1_civil_1_open"];
	_u = _u		+ ["datsun1_civil_3_open"];
	_u = _u		+ ["hilux1_civil_1_open"];
	_u = _u		+ ["LandRover_TK_CIV_EP1"];
	_u = _u		+ ["V3S_Open_TK_CIV_EP1"];
	_u = _u		+ ["Ikarus_TK_CIV_EP1"];
	if (paramPurchaseInfDepot) then {
		_u = _u		+ ["US_Soldier_EP1"];
	};
};

['WFBE_WESTDEPOTUNITS',_u,true] Call SetNamespace;
if (local player) then {['DEPOT','WEST',_u] Call Compile preProcessFile 'Client\Init\Init_Faction.sqf'};

//EAST
if (WF_A2_Vanilla) then {
	_u			= ["MMT_Civ"];
	_u = _u		+ ["TT650_Civ"];
	_u = _u		+ ["Tractor"];
	_u = _u		+ ["Lada2"];
	_u = _u		+ ["LadaLM"];
	_u = _u		+ ["SkodaRed"];
	_u = _u		+ ["VWGolf"];
	_u = _u		+ ["datsun1_civil_2_covered"];
	_u = _u		+ ["hilux1_civil_2_covered"];
	_u = _u		+ ["UralCivil"];
	if (paramPurchaseInfDepot) then {
		_u = _u		+ ["RU_Soldier"];
	};
};

if (WF_A2_Arrowhead) then {
	_u 			= ["Old_bike_TK_CIV_EP1"];
	_u = _u		+ ["TT650_TK_CIV_EP1"];
	_u = _u		+ ["Lada2_TK_CIV_EP1"];
	_u = _u		+ ["VolhaLimo_TK_CIV_EP1"];
	_u = _u		+ ["Volha_2_TK_CIV_EP1"];
	_u = _u		+ ["Ural_TK_CIV_EP1"];
	_u = _u		+ ["S1203_TK_CIV_EP1"];
	if (paramPurchaseInfDepot) then {
		_u = _u		+ ["TK_Soldier_EP1"];
	};
};

if (WF_A2_CombinedOps) then {
	_u 			= ["MMT_Civ"];
	_u = _u		+ ["Old_bike_TK_CIV_EP1"];
	_u = _u		+ ["TT650_Civ"];
	_u = _u		+ ["Tractor"];
	_u = _u		+ ["Lada2_TK_CIV_EP1"];
	_u = _u		+ ["SkodaRed"];
	_u = _u		+ ["VolhaLimo_TK_CIV_EP1"];
	_u = _u		+ ["Volha_2_TK_CIV_EP1"];
	_u = _u		+ ["VWGolf"];
	_u = _u		+ ["datsun1_civil_2_covered"];
	_u = _u		+ ["hilux1_civil_2_covered"];
	_u = _u		+ ["S1203_TK_CIV_EP1"];
	_u = _u		+ ["Ural_TK_CIV_EP1"];
	if (paramPurchaseInfDepot) then {
		_u = _u		+ ["RU_Soldier"];
	};
};

['WFBE_EASTDEPOTUNITS',_u,true] Call SetNamespace;
if (local player) then {['DEPOT','EAST',_u] Call Compile preProcessFile 'Client\Init\Init_Faction.sqf'};

_longestDepotBuildTime = 0;
{
	_c = _x Call GetNamespace;
	if !(isNil '_c') then {
		if ((_c select QUERYUNITTIME) > _longestDepotBuildTime) then {
			_longestDepotBuildTime = (_c select QUERYUNITTIME);
		};
	} else {
		Format ["Config_Depot: '%1' is not defined in the Core files.",_x] call LogError;
	};
} forEach (('WFBE_EASTDEPOTUNITS' Call GetNamespace) + ('WFBE_WESTDEPOTUNITS' Call GetNamespace));

['WFBE_LONGESTDEPOTBUILDTIME',_longestDepotBuildTime,true] Call SetNamespace;

depotDistance = 21;
depotDirection = 90;

"Config_Depot: Initialization - [Done]" call LogMedium;