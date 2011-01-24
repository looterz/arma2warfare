Private['_c','_u', '_unitType'];

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

_unitType = ([['RU_Soldier_Crew', 'TK_Soldier_Crew_EP1']] call SelectCamo) select 0;
['WFBE_EASTCREW',_unitType,true] Call SetNamespace;

_unitType = ([['USMC_Soldier_Crew', 'US_Soldier_Crew_EP1']] call SelectCamo) select 0;
['WFBE_WESTCREW',_unitType,true] Call SetNamespace;

_unitType = ([['GUE_Soldier_Crew', 'TK_GUE_Soldier_EP1']] call SelectCamo) select 0;
['WFBE_GUERCREW',_unitType,true] Call SetNamespace;

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