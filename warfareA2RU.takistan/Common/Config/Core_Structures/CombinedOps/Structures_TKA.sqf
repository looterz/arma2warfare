Private ['_c','_count','_d','_dir','_dis','_n','_s','_t','_v','_h','_h2','_h3','_h4'];

/* Root Definition */
EASTHQ = if (WF_Camo) then {"BTR90_HQ_unfolded"} else {"BTR90_HQ_unfolded"};
EASTBAR = if (WF_Camo) then {"RU_WarfareBBarracks"} else {"TK_WarfareBBarracks_EP1"};
EASTLVF = if (WF_Camo) then {"RU_WarfareBLightFactory"} else {"TK_WarfareBLightFactory_EP1"};
EASTCC = if (WF_Camo) then {"RU_WarfareBUAVterminal"} else {"TK_WarfareBUAVterminal_EP1"};
EASTHEAVY = if (WF_Camo) then {"RU_WarfareBHeavyFactory"} else {"TK_WarfareBHeavyFactory_EP1"};
EASTAIR = if (WF_Camo) then {"RU_WarfareBAircraftFactory"} else {"TK_WarfareBAircraftFactory_EP1"};
EASTSP = if (WF_Camo) then {"RU_WarfareBContructionSite"} else {"TK_WarfareBContructionSite1_EP1"};
EASTAAR = if (WF_Camo) then {"RU_WarfareBAntiAirRadar"} else {"TK_WarfareBAntiAirRadar_EP1"};

/* Flag Textures */
['WFBE_EASTFLAG','\Ca\Data\flag_rus_co.paa',true] Call SetNamespace;

/* Mash used after being deployed */
['WFBE_EASTFARP','Land_A_tent',true] Call SetNamespace;

/* Construction Crates */
['WFBE_EASTCONSTRUCTIONSITE','RU_WarfareBContructionSite',true] Call SetNamespace;

/* Structures */
_v			= ["Headquarters"];
_n			= [EASTHQ];
_h			= [EASTHQ];
_d			= [getText (configFile >> "CfgVehicles" >> (_n select (count _n - 1)) >> "displayName")];
_c			= [('WFBE_HQDEPLOYPRICE' Call GetNamespace)];
_t			= [if (WF_Debug) then {1} else {30}];
_s			= ["HQSite"];
_dis		= [15];
_dir		= [0];

_v = _v		+ ["Barracks"];
_n = _n		+ [EASTBAR];
_d = _d		+ [getText (configFile >> "CfgVehicles" >> (_n select (count _n - 1)) >> "displayName")];
_c = _c		+ [600];
_t = _t		+ [if (WF_Debug) then {1} else {70}];
_s = _s		+ ["SmallSite"];
_dis = _dis	+ [18];
_dir = _dir	+ [90];
_h4 =  		 [EASTBAR];

_v = _v		+ ["Light"];
_n = _n		+ [EASTLVF];
_d = _d		+ [getText (configFile >> "CfgVehicles" >> (_n select (count _n - 1)) >> "displayName")];
_c = _c		+ [1200];
_t = _t		+ [if (WF_Debug) then {1} else {90}];
_s = _s		+ ["MediumSite"];
_dis = _dis	+ [25];
_dir = _dir	+ [90];
_h = _h		+ [EASTLVF];

_v = _v		+ ["CommandCenter"];
_n = _n		+ [EASTCC];
_d = _d		+ [localize "STR_WF_CommandCenter_RU"];
_c = _c		+ [2400];
_t = _t		+ [if (WF_Debug) then {1} else {110}];
_s = _s		+ ["SmallSite"];
_dis = _dis	+ [20];
_dir = _dir	+ [90];
_h2 =  		 [EASTCC];

_v = _v		+ ["Heavy"];
_n = _n		+ [EASTHEAVY];
_d = _d		+ [getText (configFile >> "CfgVehicles" >> (_n select (count _n - 1)) >> "displayName")];
_c = _c		+ [5600];
_t = _t		+ [if (WF_Debug) then {1} else {130}];
_s = _s		+ ["MediumSite"];
_dis = _dis	+ [25];
_dir = _dir	+ [90];
_h = _h		+ [EASTHEAVY];

_v = _v		+ ["Aircraft"];
_n = _n		+ [EASTAIR];
_d = _d		+ [localize "STR_WF_AircraftFactory"];
_c = _c		+ [8800];
_t = _t		+ [if (WF_Debug) then {1} else {150}];
_s = _s		+ ["SmallSite"];
_dis = _dis	+ [21];
_dir = _dir	+ [90];
_h3 =  		 [EASTAIR];

_v = _v		+ ["ServicePoint"];
_n = _n		+ [EASTSP];
_d = _d		+ [localize "STR_WF_MAIN_ServicePoint"];
_c = _c		+ [1400];
_t = _t		+ [if (WF_Debug) then {1} else {70}];
_s = _s		+ ["SmallSite"];
_dis = _dis	+ [21];
_dir = _dir	+ [90];
_h4 = _h4  	+ [EASTSP];

if (paramAARadar) then {
	_v = _v		+ ["AARadar"];
	_n = _n		+ [EASTAAR];
	_d = _d		+ [getText (configFile >> "CfgVehicles" >> (_n select (count _n - 1)) >> "displayName")];
	_c = _c		+ [6400];
	_t = _t		+ [if (WF_Debug) then {1} else {280}];
	_s = _s		+ ["MediumSite"];
	_dis = _dis	+ [21];
	_dir = _dir	+ [90];
	_h4 = _h4	+ [EASTAAR];
};

for [{_count = count _v - 1},{_count >= 0},{_count = _count - 1}] do {
	[Format["WFBE_EAST%1TYPE",_v select _count],_count,true] Call SetNamespace;
};

['WFBE_EASTMHQNAME','BTR90_HQ',true] Call SetNamespace;

['WFBE_EASTSTRUCTURES',_v,true] Call SetNamespace;
['WFBE_EASTSTRUCTURENAMES',_n,true] Call SetNamespace;
['WFBE_EASTSTRUCTURENAMES2',_h,true] Call SetNamespace;
['WFBE_EASTSTRUCTURENAMES3',_h2,true] Call SetNamespace;
['WFBE_EASTSTRUCTURENAMES4',_h3,true] Call SetNamespace;
['WFBE_EASTSTRUCTURENAMES5',_h4,true] Call SetNamespace;
['WFBE_EASTSTRUCTUREDESCRIPTIONS',_d,true] Call SetNamespace;
['WFBE_EASTSTRUCTURECOSTS',_c,true] Call SetNamespace;
['WFBE_EASTSTRUCTURETIMES',_t,true] Call SetNamespace;
['WFBE_EASTSTRUCTUREDISTANCES',_dis,true] Call SetNamespace;
['WFBE_EASTSTRUCTUREDIRECTIONS',_dir,true] Call SetNamespace;
['WFBE_EASTSTRUCTURESCRIPTS',_s,true] Call SetNamespace;

/* Defenses */
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
_n = _n		+ ["Fort_RazorWire"];
_n = _n		+ ["Land_Ind_IlluminantTower"];
_n = _n		+ ["Concrete_Wall_EP1"];
_n = _n		+ ["Land_Campfire"];
_n = _n		+ ["RUOrdnanceBox"];
//_n = _n		+ ["RUVehicleBox"];
_n = _n		+ ["RUBasicAmmunitionBox"];
_n = _n		+ ["RUBasicWeaponsBox"];
_n = _n		+ ["RULaunchersBox"];
_n = _n		+ ["RUSpecialWeaponsBox"];

/* Class used for AI, AI will attempt to build those */
['WFBE_EASTDEFENSES_MG',['KORD_high_TK_EP1'],true] Call SetNamespace;
['WFBE_EASTDEFENSES_GL',['AGS_TK_EP1'],true] Call SetNamespace;
['WFBE_EASTDEFENSES_AAPOD',['Igla_AA_pod_TK_EP1','ZU23_TK_EP1'],true] Call SetNamespace;
['WFBE_EASTDEFENSES_ATPOD',['Metis_TK_EP1','SPG9_TK_INS_EP1'],true] Call SetNamespace;
['WFBE_EASTDEFENSES_CANNON',['D30_TK_EP1'],true] Call SetNamespace;
['WFBE_EASTDEFENSES_MASH',['MASH_EP1'],true] Call SetNamespace;

['WFBE_EASTDEFENSENAMES',_n,true] Call SetNamespace;