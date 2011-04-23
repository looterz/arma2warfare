Private['_balancePrice','_c','_longestHeavyBuildTime','_u'];

_balancePrice = 'WFBE_BALANCEPRICE' Call GetNamespace;

/* WEST - Heavy */
_u = Call Compile preprocessFile Format["Common\Config\Core_Units\%1\Units_Heavy_%2.sqf",WFBE_V_West_UnitsRootVersion,WFBE_V_West_Faction];
['WFBE_WESTHEAVYUNITS',_u,true] Call SetNamespace;
if (local player) then {['HEAVY','WEST',_u] Call Compile preProcessFile 'Client\Init\Init_Faction.sqf'};

/* EAST - Heavy */
_u = Call Compile preprocessFile Format["Common\Config\Core_Units\%1\Units_Heavy_%2.sqf",WFBE_V_East_UnitsRootVersion,WFBE_V_East_Faction];
['WFBE_EASTHEAVYUNITS',_u,true] Call SetNamespace;
if (local player) then {['HEAVY','EAST',_u] Call Compile preProcessFile 'Client\Init\Init_Faction.sqf'};

/* RESISTANCE - Heavy */
_u = Call Compile preprocessFile Format["Common\Config\Core_Units\%1\Units_Heavy_%2.sqf",WFBE_V_Resistance_UnitsRootVersion,WFBE_V_Resistance_Faction];
['WFBE_GUERHEAVYUNITS',_u,true] Call SetNamespace;

/* Allies */
if (('WFBE_ALLIES' Call GetNamespace) > 0) then {
	//--- CDF Allies.
	_u = Call Compile preprocessFile "Common\Config\Core_Units\Vanilla\Units_Heavy_CDF.sqf";
	['WFBE_WESTALLIESHEAVYUNITS',_u,true] Call SetNamespace;
	['WFBE_WESTALLIESCREW','CDF_Soldier_Crew',true] Call SetNamespace;
	
	//--- Insurgent Allies.
	_u = Call Compile preprocessFile "Common\Config\Core_Units\Vanilla\Units_Heavy_INS.sqf";
	['WFBE_EASTALLIESHEAVYUNITS',_u,true] Call SetNamespace;
	['WFBE_EASTALLIESCREW','Ins_Soldier_Crew',true] Call SetNamespace;
} else {
	['WFBE_WESTALLIESHEAVYUNITS',[],true] Call SetNamespace;
	['WFBE_EASTALLIESHEAVYUNITS',[],true] Call SetNamespace;
};

_resType = ('WFBE_RESISTANCEFACTIONS' Call GetNamespace) select ('WFBE_RESISTANCEFACTION' Call GetNamespace);
switch (_resType) do {
	case 'GUE': {['WFBE_GUERCREW','GUE_Soldier_Crew',true] Call SetNamespace};
	case 'TKGUE': {['WFBE_GUERCREW','TK_GUE_Soldier_EP1',true] Call SetNamespace};
	case 'PMC': {['WFBE_GUERCREW','Soldier_Crew_PMC',true] Call SetNamespace};
};

_longestHeavyBuildTime = 0;
{
	_c = _x Call GetNamespace;
	if !(isNil '_c') then {
		if ((_c select QUERYUNITTIME) > _longestHeavyBuildTime) then {
			_longestHeavyBuildTime = (_c select QUERYUNITTIME);
		};
		
		if (_balancePrice in [1,3]) then {
			_c set [QUERYUNITPRICE, (_c select QUERYUNITPRICE)*2];
		};
	} else {
		diag_log Format ["[WFBE (ERROR)][frameno:%2 | ticktime:%3] Config_HeavyFactory: '%1' is not defined in the Core files.",_x,diag_frameno,diag_tickTime];
	};
} forEach (('WFBE_EASTHEAVYUNITS' Call GetNamespace) + ('WFBE_WESTHEAVYUNITS' Call GetNamespace) + ('WFBE_GUERHEAVYUNITS' Call GetNamespace));

['WFBE_LONGESTHEAVYBUILDTIME',_longestHeavyBuildTime,true] Call SetNamespace;
diag_log Format ["[WFBE (INIT)][frameno:%1 | ticktime:%2] Config_HeavyFactory: Initialization - [Done]",diag_frameno,diag_tickTime];