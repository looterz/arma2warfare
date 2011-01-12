Private['_c','_u'];

/* WEST - Aircraft */
_u = Call Compile preprocessFile (WFBE_V_UnitsRoot + WFBE_V_UnitsRootVersion + 'Units_Aircraft_' + WFBE_V_West_Faction + '.sqf');
['WFBE_WESTAIRCRAFTUNITS',_u,true] Call SetNamespace;
if (local player) then {['AIRCRAFT','WEST',_u] Call Compile preProcessFile 'Client\Init\Init_Faction.sqf'};

/* EAST - Aircraft */
_u = Call Compile preprocessFile (WFBE_V_UnitsRoot + WFBE_V_UnitsRootVersion + 'Units_Aircraft_' + WFBE_V_East_Faction + '.sqf');
['WFBE_EASTAIRCRAFTUNITS',_u,true] Call SetNamespace;
if (local player) then {['AIRCRAFT','EAST',_u] Call Compile preProcessFile 'Client\Init\Init_Faction.sqf'};

/* RESISTANCE - Aircraft */
_u = [];
//_u = Call Compile preprocessFile (WFBE_V_UnitsRoot + WFBE_V_UnitsRootVersion + 'Units_Aircraft_' + WFBE_V_Resistance_Faction + '.sqf');
['WFBE_GUERAIRCRAFTUNITS',_u,true] Call SetNamespace;

/* Allies */
if (paramAllies) then {
	//--- CDF Allies.
	_u = Call Compile preprocessFile (WFBE_V_UnitsRoot + 'Vanilla\Units_Aircraft_CDF.sqf');
	['WFBE_WESTALLIESAIRCRAFTUNITS',_u,true] Call SetNamespace;
	['WFBE_WESTALLIESPILOT','CDF_Soldier_Pilot',true] Call SetNamespace;
	
	//--- Insurgent Allies.
	_u = Call Compile preprocessFile (WFBE_V_UnitsRoot + 'Vanilla\Units_Aircraft_INS.sqf');
	['WFBE_EASTALLIESAIRCRAFTUNITS',_u,true] Call SetNamespace;
	['WFBE_EASTALLIESPILOT','Ins_Soldier_Pilot',true] Call SetNamespace;
} else {
	['WFBE_WESTALLIESAIRCRAFTUNITS',[],true] Call SetNamespace;
	['WFBE_EASTALLIESAIRCRAFTUNITS',[],true] Call SetNamespace;
};

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
	} else {
		Format [" Config_AircraftFactory: '%1' is not defined in the Core files.",_x] call LogError;
	};
} forEach (('WFBE_EASTAIRCRAFTUNITS' Call GetNamespace) + ('WFBE_WESTAIRCRAFTUNITS' Call GetNamespace) + ('WFBE_GUERAIRCRAFTUNITS' Call GetNamespace));

['WFBE_LONGESTAIRCRAFTBUILDTIME',_longestAircraftBuildTime,true] Call SetNamespace;
"Config_AircraftFactory: Initialization - [Done]" call LogMedium;