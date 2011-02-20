#include "profiler.h"
PROFILER_BEGIN("Market_NormalizePrices");

private['_market','_u','_marketSellCost','_sorted','_tax','_townbuycost','_nearest','_dist','_markets','_townsellcost','_dsell','_dbuy','_marketprices','_townprices','_marketprice','_updated'];

	_market = _this;
	
	if (_market in towns) exitWith {
		PROFILER_END();
	};

	// - we need reread for get updated prices
	_marketPrices = _market call marketGetMarketPrices;
		
	_nearest = _market getVariable "marketNearestTown";
	if (!isNil "_nearest") then {
		_markets = [] + towns;
		_markets = _markets - [_market];
		_sorted = [_market, _markets] Call SortByDistance;
		_nearest = _sorted select 0;
		
		_market setVariable ["marketNearestTown", _nearest];
	};
	
	_dist = _market distance _nearest;	
	if (_dist < 500) then { _dist = 0; };

	_tax = (0.05*_dist/500);		

	_townPrices = _nearest call marketGetMarketPrices;
	_u = marketTotalProductCount;
	while { _u != 0  } do {
		_u = _u - 1;
	
		_marketPrice = _marketPrices select _u;
		
		_townSellCost = (_townPrices select _u) select 0;
		_townBuyCost = (_townPrices select _u) select 1;
		
		_dSell = _townSellCost*_tax;
		_dBuy = _townBuyCost*_tax;
		
		if (_dist > 500) then {
			_dSell = _dSell + 5;
			_dBuy = _dBuy + 5;
		};
		
		_townSellCost = _townSellCost + _dSell;
		_townBuyCost = _townBuyCost + _dBuy;
		
		_marketSellCost = _marketPrice select 0;		
		_townBuyCost  = _townBuyCost call marketRoundValue;
		
		if (_townBuyCost > 0 && _townBuyCost < _marketSellCost ) then {	
		
			_marketPrice set [0, _townBuyCost ];
			_updated = true;
		};
	};
	
		
	if (_updated) then {
		_market setVariable ["marketProductPrice", _marketPrices, true];
		_market setVariable ["marketTimeStamp", format["%1", time], true];
	};

PROFILER_END();