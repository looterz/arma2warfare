Private['_c','_u'];

/* WEST - Heavy */
_u = Call Compile preprocessFile (WFBE_V_UnitsRoot + WFBE_V_UnitsRootVersion + 'Units_Heavy_' + WFBE_V_West_Faction + '.sqf');
['WFBE_WESTHEAVYUNITS',_u,true] Call SetNamespace;
if (local player) then {['HEAVY','WEST',_u] Call Compile preProcessFile 'Client\Init\Init_Faction.sqf'};

/* EAST - Heavy */
_u = Call Compile preprocessFile (WFBE_V_UnitsRoot + WFBE_V_UnitsRootVersion + 'Units_Heavy_' + WFBE_V_East_Faction + '.sqf');
['WFBE_EASTHEAVYUNITS',_u,true] Call SetNamespace;
if (local player) then {['HEAVY','EAST',_u] Call Compile preProcessFile 'Client\Init\Init_Faction.sqf'};

/* RESISTANCE - Heavy */
_u = Call Compile preprocessFile (WFBE_V_UnitsRoot + WFBE_V_UnitsRootVersion + 'Units_Heavy_' + WFBE_V_Resistance_Faction + '.sqf');
['WFBE_GUERHEAVYUNITS',_u,true] Call SetNamespace;

/* Allies */
if (paramAllies) then {
	//--- CDF Allies.
	_u = Call Compile preprocessFile (WFBE_V_UnitsRoot + 'Vanilla\Units_Heavy_CDF.sqf');
	['WFBE_WESTALLIESHEAVYUNITS',_u,true] Call SetNamespace;
	['WFBE_WESTALLIESCREW','CDF_Soldier_Crew',true] Call SetNamespace;
	
	//--- Insurgent Allies.
	_u = Call Compile preprocessFile (WFBE_V_UnitsRoot + 'Vanilla\Units_Heavy_INS.sqf');
	['WFBE_EASTALLIESHEAVYUNITS',_u,true] Call SetNamespace;
	['WFBE_EASTALLIESCREW','Ins_Soldier_Crew',true] Call SetNamespace;
} else {
	['WFBE_WESTALLIESHEAVYUNITS',[],true] Call SetNamespace;
	['WFBE_EASTALLIESHEAVYUNITS',[],true] Call SetNamespace;
};

if (WF_A2_Vanilla) then {
	['WFBE_WESTCREW','USMC_Soldier_Crew',true] Call SetNamespace;
	['WFBE_EASTCREW','RU_Soldier_Crew',true] Call SetNamespace;
	['WFBE_GUERCREW','GUE_Soldier_Crew',true] Call SetNamespace;
};

if (WF_A2_Arrowhead) then {
	['WFBE_WESTCREW','US_Soldier_Crew_EP1',true] Call SetNamespace;
	['WFBE_EASTCREW','TK_Soldier_Crew_EP1',true] Call SetNamespace;
	['WFBE_GUERCREW','TK_GUE_Soldier_EP1',true] Call SetNamespace;
};

if (WF_A2_CombinedOps) then {
	_resType = 'WFBE_RESISTANCEFACTION' Call GetNamespace;
	if (isNil '_resType') then {_resType = -1};
	['WFBE_WESTCREW','US_Soldier_Crew_EP1',true] Call SetNamespace;
	['WFBE_EASTCREW','TK_Soldier_Crew_EP1',true] Call SetNamespace;
	switch (_resType) do {
		case 0: {['WFBE_GUERCREW','GUE_Soldier_Crew',true] Call SetNamespace};
		case 1: {['WFBE_GUERCREW','TK_GUE_Soldier_EP1',true] Call SetNamespace};
	};
};

_longestHeavyBuildTime = 0;
{
	_c = _x Call GetNamespace;
	if !(isNil '_c') then {
		if ((_c select QUERYUNITTIME) > _longestHeavyBuildTime) then {
			_longestHeavyBuildTime = (_c select QUERYUNITTIME);
		};
	} else {
		Format ["Config_HeavyFactory: '%1' is not defined in the Core files.",_x] call LogError;
	};
} forEach (('WFBE_EASTHEAVYUNITS' Call GetNamespace) + ('WFBE_WESTHEAVYUNITS' Call GetNamespace) + ('WFBE_GUERHEAVYUNITS' Call GetNamespace));

['WFBE_LONGESTHEAVYBUILDTIME',_longestHeavyBuildTime,true] Call SetNamespace;
"Config_HeavyFactory: Initialization - [Done]" call LogMedium;