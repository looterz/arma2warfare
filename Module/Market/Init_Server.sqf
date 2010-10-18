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

_periodTownUpdate = if (WF_DEBUG) then { 5; } else { 300; };
_periodFactoryUpdate = if (WF_DEBUG) then { 5; } else { 60; };

_nextTownUpdate = time + _periodTownUpdate;
_nextFactoryUpdate = time + _periodFactoryUpdate;
while { true } do {

	if (WF_DEBUG) then { sleep 5; } else { sleep 60; };

	diag_log format["Market time=%1", time];
	diag_log format["Market nextTownUpdate=%1", _nextTownUpdate];
	diag_log format["Market _nextFactoryUpdate=%1", _nextFactoryUpdate];
	
	if (_nextTownUpdate < time) then {
		diag_log format["Market updating town markets"];

		{ [_x] call marketUpdateProducedProduct; } forEach towns;
		{ [_x] call marketNormalizePrices; } forEach towns;
		
		_nextTownUpdate = time + _periodTownUpdate;
	};
	
	if (_nextFactoryUpdate < time) then  {
	
		diag_log format["Market updating factory markets"];
	
		_buildings = [] + (WF_Logic getVariable 'WESTBaseStructures');
		_buildings = _buildings + (WF_Logic getVariable 'EASTBaseStructures');
		
		{
			_market = _x;
			_products = [_market] call marketGetMarketProducts;
			_stock = _products select 0;		
			[_market, _stock] call marketUpdateMarketPrices;
			[_market] call marketNormalizePrices;
		
		} forEach _buildings;
		_nextFactoryUpdate = time + _periodFactoryUpdate;
	};
};
