Private['_balancePrice','_c','_longestAircraftBuildTime','_resType','_u'];

_balancePrice = 'WFBE_BALANCEPRICE' Call GetNamespace;

/* WEST - Aircraft */
_u = Call Compile preprocessFile Format["Common\Config\Core_Units\%1\Units_Aircraft_%2.sqf",WFBE_V_West_UnitsRootVersion,WFBE_V_West_Faction];
['WFBE_WESTAIRCRAFTUNITS',_u,true] Call SetNamespace;
if (local player) then {['AIRCRAFT','WEST',_u] Call Compile preProcessFile 'Client\Init\Init_Faction.sqf'};

/* EAST - Aircraft */
_u = Call Compile preprocessFile Format["Common\Config\Core_Units\%1\Units_Aircraft_%2.sqf",WFBE_V_East_UnitsRootVersion,WFBE_V_East_Faction];
['WFBE_EASTAIRCRAFTUNITS',_u,true] Call SetNamespace;
if (local player) then {['AIRCRAFT','EAST',_u] Call Compile preProcessFile 'Client\Init\Init_Faction.sqf'};

/* RESISTANCE - Aircraft */
_u = [];
//_u = Call Compile preprocessFile Format["Common\Config\Core_Units\%1\Units_Aircraft_%2.sqf",WFBE_V_Resistance_UnitsRootVersion,WFBE_V_Resistance_Faction];
['WFBE_GUERAIRCRAFTUNITS',_u,true] Call SetNamespace;

/* Allies */
if (('WFBE_ALLIES' Call GetNamespace) > 0) then {
	//--- CDF Allies.
	_u = Call Compile preprocessFile "Common\Config\Core_Units\Vanilla\Units_Aircraft_CDF.sqf";
	['WFBE_WESTALLIESAIRCRAFTUNITS',_u,true] Call SetNamespace;
	['WFBE_WESTALLIESPILOT','CDF_Soldier_Pilot',true] Call SetNamespace;
	
	//--- Insurgent Allies.
	_u = Call Compile preprocessFile "Common\Config\Core_Units\Vanilla\Units_Aircraft_INS.sqf";
	['WFBE_EASTALLIESAIRCRAFTUNITS',_u,true] Call SetNamespace;
	['WFBE_EASTALLIESPILOT','Ins_Soldier_Pilot',true] Call SetNamespace;
} else {
	['WFBE_WESTALLIESAIRCRAFTUNITS',[],true] Call SetNamespace;
	['WFBE_EASTALLIESAIRCRAFTUNITS',[],true] Call SetNamespace;
};

_resType = ('WFBE_RESISTANCEFACTIONS' Call GetNamespace) select ('WFBE_RESISTANCEFACTION' Call GetNamespace);
switch (_resType) do {
	case 'GUE': {['WFBE_GUERPILOT','GUE_Soldier_1',true] Call SetNamespace};
	case 'TKGUE': {['WFBE_GUERPILOT','TK_GUE_Soldier_EP1',true] Call SetNamespace};
	case 'PMC': {['WFBE_GUERPILOT','Soldier_Pilot_PMC',true] Call SetNamespace};
};

//--- UAV
if (WF_A2_Vanilla) then {
	['WFBE_WESTUAV','MQ9PredatorB',true] Call SetNamespace;
	['WFBE_EASTUAV','Pchela1T',true] Call SetNamespace;
};

if (WF_A2_Arrowhead) then {
	['WFBE_WESTUAV','MQ9PredatorB_US_EP1',true] Call SetNamespace;
	['WFBE_EASTUAV','',true] Call SetNamespace;
};

if (WF_A2_CombinedOps) then {
	['WFBE_WESTUAV','MQ9PredatorB_US_EP1',true] Call SetNamespace;
	['WFBE_EASTUAV','Pchela1T',true] Call SetNamespace;
};

_longestAircraftBuildTime = 0;
{
	_c = _x Call GetNamespace;
	if !(isNil '_c') then {
		if ((_c select QUERYUNITTIME) > _longestAircraftBuildTime) then {
			_longestAircraftBuildTime = (_c select QUERYUNITTIME);
		};
		
		if (_balancePrice in [1,2]) then {
			_c set [QUERYUNITPRICE, (_c select QUERYUNITPRICE)*2];
		};
	} else {
		diag_log Format ["[WFBE (ERROR)][frameno:%2 | ticktime:%3] Config_AircraftFactory: '%1' is not defined in the Core files.",_x,diag_frameno,diag_tickTime];
	};
} forEach (('WFBE_EASTAIRCRAFTUNITS' Call GetNamespace) + ('WFBE_WESTAIRCRAFTUNITS' Call GetNamespace) + ('WFBE_GUERAIRCRAFTUNITS' Call GetNamespace));

['WFBE_LONGESTAIRCRAFTBUILDTIME',_longestAircraftBuildTime,true] Call SetNamespace;
diag_log Format ["[WFBE (INIT)][frameno:%1 | ticktime:%2] Config_AircraftFactory: Initialization - [Done]",diag_frameno,diag_tickTime];