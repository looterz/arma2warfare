Private['_c','_u'];

/* WEST - Depot */
_u = Call Compile preprocessFile (WFBE_V_UnitsRoot + WFBE_V_UnitsRootVersion + 'Units_Depot_' + WFBE_V_West_Faction + '.sqf');
['WFBE_WESTDEPOTUNITS',_u,true] Call SetNamespace;
if (local player) then {['DEPOT','WEST',_u] Call Compile preProcessFile 'Client\Init\Init_Faction.sqf'};

/* EAST - Depot */
_u = Call Compile preprocessFile (WFBE_V_UnitsRoot + WFBE_V_UnitsRootVersion + 'Units_Depot_' + WFBE_V_East_Faction + '.sqf');
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
		diag_log Format ["[WFBE (ERROR)] Config_Depot: '%1' is not defined in the Core files.",_x];
	};
} forEach (('WFBE_EASTDEPOTUNITS' Call GetNamespace) + ('WFBE_WESTDEPOTUNITS' Call GetNamespace));

['WFBE_LONGESTDEPOTBUILDTIME',_longestDepotBuildTime,true] Call SetNamespace;

depotDistance = 21;
depotDirection = 90;

diag_log "[WFBE (INIT)] Config_Depot: Initialization - [Done]";