Private ['_unitType','_su'];

diag_log "Market initialization... wait town inited";
waitUntil {townInit};

diag_log "Market initialization begin";

{
	diag_log format["Market town initialization: %1", _x];
	[_x] call marketInitMarketStorage;
	_x setVariable ["marketInited", 1, true];

} forEach towns;

WF_Logic setVariable ["marketInitialized", 1, true];
diag_log "Market initialization completed";


while { true } do {

	if (WF_DEBUG) then { 
		sleep 5; 
	} else { 
		sleep 300; 
	};
	
	{ [_x] call marketUpdateProducedProduct; } forEach towns;

};
