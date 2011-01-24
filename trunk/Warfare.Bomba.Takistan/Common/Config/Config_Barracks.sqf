Private['_c','_u', '_unitType'];

/* WEST - Barracks */
_u = Call Compile preprocessFile (WFBE_V_UnitsRoot + WFBE_V_UnitsRootVersion + 'Units_Barracks_' + WFBE_V_West_Faction + '.sqf');
['WFBE_WESTBARRACKSUNITS',_u,true] Call SetNamespace;
if (local player) then {['BARRACKS','WEST',_u] Call Compile preProcessFile 'Client\Init\Init_Faction.sqf'};

/* EAST - Barracks */
_u = Call Compile preprocessFile (WFBE_V_UnitsRoot + WFBE_V_UnitsRootVersion + 'Units_Barracks_' + WFBE_V_East_Faction + '.sqf');
['WFBE_EASTBARRACKSUNITS',_u,true] Call SetNamespace;
if (local player) then {['BARRACKS','EAST',_u] Call Compile preProcessFile 'Client\Init\Init_Faction.sqf'};

/* RESISTANCE - Barracks */
_u = Call Compile preprocessFile (WFBE_V_UnitsRoot + WFBE_V_UnitsRootVersion + 'Units_Barracks_' + WFBE_V_Resistance_Faction + '.sqf');
['WFBE_GUERBARRACKSUNITS',_u,true] Call SetNamespace;

/* Allies */
if (paramAllies) then {
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

_unitType = ([['USMC_Soldier', 'US_Soldier_EP1']] call SelectCamo) select 0;	
['WFBE_WESTSOLDIER',_unit,true] Call SetNamespace;

_unitType = ([['RU_Soldier', 'TK_Soldier_EP1']] call SelectCamo) select 0;	
['WFBE_EASTSOLDIER',_unitType, true] Call SetNamespace;

_unitType = ([['GUE_Soldier_1', 'TK_GUE_Soldier_EP1']] call SelectCamo) select 0;	
['WFBE_GUERSOLDIER',_unitType, true] Call SetNamespace;

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