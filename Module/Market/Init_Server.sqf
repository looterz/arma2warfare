Private ['_unitType','_su'];

_isInited = WF_Logic getVariable "marketInitialized";
if (isNil "_isInited") then { _isInited = 0; };

if  (_isInited == 1) exitWith {};

if (!paramTrade) exitWith {
	"Initialization Market :: Marketing are disabled by game settings"  call LogMedium;
};

"Initialization Market :: Wait town inited"  call LogHigh;
waitUntil {townInit};

{
	format["Market town initialization: %1", _x]  call LogHigh;
	[_x] call marketInitMarketStorage;
	_x setVariable ["marketInited", 1, true];

} forEach towns;

WF_Logic setVariable ["marketInitialized", 1, true];
"Initialization Market - Done" call LogMedium;

_periodTownUpdate = if (WF_DEBUG) then { 5; } else { 300; };
_periodFactoryUpdate = if (WF_DEBUG) then { 5; } else { 60; };

_nextTownUpdate = time + _periodTownUpdate;
_nextFactoryUpdate = time + _periodFactoryUpdate;
while { true } do {

	if (WF_DEBUG) then { sleep 5; } else { sleep 60; };

	format["Market time=%1", time]  call LogHigh;
	format["Market nextTownUpdate=%1", _nextTownUpdate] call LogHigh;
	format["Market _nextFactoryUpdate=%1", _nextFactoryUpdate]  call LogHigh;
	
	if (_nextTownUpdate < time) then {
		"Market updating town markets" call LogHigh;

		{ [_x] call marketUpdateProducedProduct; } forEach towns;
		{ [_x] call marketNormalizePrices; } forEach towns;
		
		_nextTownUpdate = time + _periodTownUpdate;
	};
	
	if (_nextFactoryUpdate < time) then  {
	
		"Market: Updating factory markets" call LogHigh;
	
		_buildings = [] + (("WEST") Call GetSideStructures);
		_buildings = _buildings + (("EAST") Call GetSideStructures);		
		
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
