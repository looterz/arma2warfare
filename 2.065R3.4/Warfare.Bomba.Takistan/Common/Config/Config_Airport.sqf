Private['_c','_r','_u'];

_r = 'WFBE_RESTRICTIONADVAIR' Call GetNamespace;
_u = [];

//WEST
if (WF_A2_Vanilla) then {
	_u = [];
	if (_r == 0) then {
		_u = _u 	+ ['MV22'];
		_u = _u		+ ['C130J'];
		_u = _u		+ ['F35B'];
		_u = _u		+ ['AV8B'];
		_u = _u		+ ['AV8B2'];
		_u = _u		+ ['A10'];
	};
};

//WEST
if (WF_A2_Arrowhead) then {
	_u = [];
	if (_r == 0) then {
		_u = _u		+ ['C130J_US_EP1'];
		_u = _u		+ ['A10_US_EP1'];
	};
};

if (WF_A2_CombinedOps) then {
	_u = [];
	if (_r == 0) then {
		_u = _u 	+ ['MV22'];
		_u = _u		+ ['C130J_US_EP1'];
		_u = _u		+ ['F35B'];
		_u = _u		+ ['AV8B'];
		_u = _u		+ ['AV8B2'];
		_u = _u		+ ['A10_US_EP1'];
	};
};

['WFBE_WESTAIRPORTUNITS',_u,true] Call SetNamespace;
if (local player) then {['AIRPORT','WEST',_u] Call Compile preProcessFile 'Client\Init\Init_Faction.sqf'};

//EAST
if (WF_A2_Vanilla) then {
	_u = [];
	if (_r == 0) then {
		_u = _u 	+ ['Su34'];
		_u = _u		+ ['Su25_Ins'];
		_u = _u		+ ['Su39'];
	};
};

if (WF_A2_Arrowhead) then {
	_u = [];
	if (_r == 0) then {
		_u = _u		+ ['An2_TK_EP1'];
		_u = _u		+ ['L39_TK_EP1'];
		_u = _u		+ ['Su25_TK_EP1'];
	};
};

if (WF_A2_CombinedOps) then {
	_u = [];
	if (_r == 0) then {
		_u = _u		+ ['An2_TK_EP1'];
		_u = _u		+ ['L39_TK_EP1'];
		_u = _u		+ ['Su34'];
		_u = _u		+ ['Su25_TK_EP1'];
		_u = _u		+ ['Su25_Ins'];
		_u = _u		+ ['Su39'];
	};
};

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