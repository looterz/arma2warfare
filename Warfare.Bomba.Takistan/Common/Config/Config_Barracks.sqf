private['_c','_u','_restype','_longestbarracksbuildtime'];

/* WEST - Barracks */
_u = Call Compile preprocessFile (WFBE_V_UnitsRoot + WFBE_V_West_UnitsRootVersion + 'Units_Barracks_' + WFBE_V_West_Faction + '.sqf');
['WFBE_WESTBARRACKSUNITS',_u,true] Call SetNamespace;
if (local player) then {['BARRACKS','WEST',_u] Call Compile preProcessFile 'Client\Init\Init_Faction.sqf'};

/* EAST - Barracks */
_u = Call Compile preprocessFile (WFBE_V_UnitsRoot + WFBE_V_East_UnitsRootVersion + 'Units_Barracks_' + WFBE_V_East_Faction + '.sqf');
['WFBE_EASTBARRACKSUNITS',_u,true] Call SetNamespace;
if (local player) then {['BARRACKS','EAST',_u] Call Compile preProcessFile 'Client\Init\Init_Faction.sqf'};

/* RESISTANCE - Barracks */
_u = Call Compile preprocessFile (WFBE_V_UnitsRoot + WFBE_V_Resistance_UnitsRootVersion + 'Units_Barracks_' + WFBE_V_Resistance_Faction + '.sqf');
['WFBE_GUERBARRACKSUNITS',_u,true] Call SetNamespace;

/* Allies */
if (('WFBE_ALLIES' Call GetNamespace) > 0) then {
	//--- CDF Allies.
	_u = Call Compile preprocessFile (WFBE_V_UnitsRoot + 'Vanilla\Units_Barracks_CDF.sqf');
	['WFBE_WESTALLIESBARRACKSUNITS',_u,true] Call SetNamespace;	
	['WFBE_WESTALLIESSOLDIER','CDF_Soldier',true] Call SetNamespace;
	
	//--- Insurgent Allies.
	_u = Call Compile preprocessFile (WFBE_V_UnitsRoot + 'Vanilla\Units_Barracks_INS.sqf');
	['WFBE_EASTALLIESBARRACKSUNITS',_u,true] Call SetNamespace;	
	['WFBE_EASTALLIESSOLDIER','Ins_Soldier_1',true] Call SetNamespace;
} else {
	['WFBE_WESTALLIESBARRACKSUNITS',[],true] Call SetNamespace;
	['WFBE_EASTALLIESBARRACKSUNITS',[],true] Call SetNamespace;
};

/* Overall settings of a side */
_resType = ('WFBE_RESISTANCEFACTIONS' Call GetNamespace) select ('WFBE_RESISTANCEFACTION' Call GetNamespace);

if (WF_A2_Vanilla) then {
	['WFBE_WESTSOLDIER','USMC_Soldier',true] Call SetNamespace;
	['WFBE_EASTSOLDIER','RU_Soldier',true] Call SetNamespace;
	switch (_resType) do {
		case 'GUE': {['WFBE_GUERSOLDIER','GUE_Soldier_1',true] Call SetNamespace};
	};
};

if (WF_A2_Arrowhead) then {
	['WFBE_WESTSOLDIER','US_Soldier_EP1',true] Call SetNamespace;
	['WFBE_EASTSOLDIER','TK_Soldier_EP1',true] Call SetNamespace;
	switch (_resType) do {
		case 'TKGUE': {['WFBE_GUERSOLDIER','TK_GUE_Soldier_EP1',true] Call SetNamespace};
		case 'PMC': {['WFBE_GUERSOLDIER','Soldier_PMC',true] Call SetNamespace};
	};
};

if (WF_A2_CombinedOps) then {
	['WFBE_WESTSOLDIER','US_Soldier_EP1',true] Call SetNamespace;
	['WFBE_EASTSOLDIER','RU_Soldier',true] Call SetNamespace;
	switch (_resType) do {
		case 'GUE': {['WFBE_GUERSOLDIER','GUE_Soldier_1',true] Call SetNamespace};
		case 'TKGUE': {['WFBE_GUERSOLDIER','TK_GUE_Soldier_EP1',true] Call SetNamespace};
		case 'PMC': {['WFBE_GUERSOLDIER','Soldier_PMC',true] Call SetNamespace};
	};
};

westSoldierBaseClass = 'SoldierWB';
eastSoldierBaseClass = 'SoldierEB';
resistanceSoldierBaseClass = 'SoldierGB';

_longestBarracksBuildTime = 0;
{
	_c = _x Call GetNamespace;
	if !(isNil '_c') then {
		if ((_c select QUERYUNITTIME) > _longestBarracksBuildTime) then {
			_longestBarracksBuildTime = (_c select QUERYUNITTIME);
		};
	} else {
		Format ["Config_Barracks: '%1' is not defined in the Core files.",_x] call LogError;
	};
} forEach (('WFBE_EASTBARRACKSUNITS' Call GetNamespace) + ('WFBE_WESTBARRACKSUNITS' Call GetNamespace) + ('WFBE_GUERBARRACKSUNITS' Call GetNamespace));

['WFBE_LONGESTBARRACKSBUILDTIME',_longestBarracksBuildTime,true] Call SetNamespace;
"Config_Barracks: Initialization - [Done]" call LogMedium;