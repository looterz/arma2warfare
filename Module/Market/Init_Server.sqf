Private ['_unitType','_su'];

_isInited = WF_Logic getVariable "marketInitialized";
if (_isInited == 1) exitWith {};

"Market initialization... wait town inited"  call Logger;
waitUntil {townInit};

"Market initialization begin" call Logger;

{
	format["Market town initialization: %1", _x]  call Logger;
	[_x] call marketInitMarketStorage;
	_x setVariable ["marketInited", 1, true];

} forEach towns;

WF_Logic setVariable ["marketInitialized", 1, true];
"Market initialization completed" call Logger;

_periodTownUpdate = if (WF_DEBUG) then { 5; } else { 300; };
_periodFactoryUpdate = if (WF_DEBUG) then { 5; } else { 60; };

_nextTownUpdate = time + _periodTownUpdate;
_nextFactoryUpdate = time + _periodFactoryUpdate;
while { true } do {

	if (WF_DEBUG) then { sleep 5; } else { sleep 60; };

	format["Market time=%1", time]  call Logger;
	format["Market nextTownUpdate=%1", _nextTownUpdate] call Logger;
	format["Market _nextFactoryUpdate=%1", _nextFactoryUpdate]  call Logger;
	
	if (_nextTownUpdate < time) then {
		"Market updating town markets" call Logger;

		{ [_x] call marketUpdateProducedProduct; } forEach towns;
		{ [_x] call marketNormalizePrices; } forEach towns;
		
		_nextTownUpdate = time + _periodTownUpdate;
	};
	
	if (_nextFactoryUpdate < time) then  {
	
		"Market updating factory markets" call Logger;
	
		_buildings = [] + (WF_Logic getVariable 'WESTBaseStructures');
		_buildings = _buildings + (WF_Logic getVariable 'EASTBaseStructures');
		if (paramHangars) then { _buildings = _buildings + Airfields; };
		
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
