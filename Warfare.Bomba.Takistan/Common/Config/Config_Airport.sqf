private['_c','_u','_longestairportbuildtime'];

/* WEST - Airport */
_u = Call Compile preprocessFile (WFBE_V_UnitsRoot + WFBE_V_West_UnitsRootVersion + 'Units_Airport_' + WFBE_V_West_Faction + '.sqf');
['WFBE_WESTAIRPORTUNITS',_u,true] Call SetNamespace;
if (local player) then {['AIRPORT','WEST',_u] Call Compile preProcessFile 'Client\Init\Init_Faction.sqf'};

/* EAST - Airport */
_u = Call Compile preprocessFile (WFBE_V_UnitsRoot + WFBE_V_East_UnitsRootVersion + 'Units_Airport_' + WFBE_V_East_Faction + '.sqf');
['WFBE_EASTAIRPORTUNITS',_u,true] Call SetNamespace;
if (local player) then {['AIRPORT','EAST',_u] Call Compile preProcessFile 'Client\Init\Init_Faction.sqf'};

_longestAirportBuildTime = 0;
{
	_c = _x Call GetNamespace;
	if !(isNil '_c') then {
		if ((_c select QUERYUNITTIME) > _longestAirportBuildTime) then {
			_longestAirportBuildTime = (_c select QUERYUNITTIME);
		};
	} else {
		Format ["Config_Airport: '%1' is not defined in the Core files.",_x]  call LogError;
	};
} forEach (('WFBE_EASTAIRPORTUNITS' Call GetNamespace) + ('WFBE_WESTAIRPORTUNITS' Call GetNamespace));

['WFBE_LONGESTAIRPORTBUILDTIME',_longestAirportBuildTime,true] Call SetNamespace;

airportDistance = 60;
airportDirection = 180;

"Config_Airport: Initialization - [Done]" call LogMedium;