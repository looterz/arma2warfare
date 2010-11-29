#include "profiler.h"
PROFILER_BEGIN("Market_GetMarketProducts");

Private ['_nullMarket', '_market', '_marketStock', '_marketBuyCost', '_marketSellCost', '_marketInited', '_u', '_buyCoef', '_baseCost', '_productVolume', '_sellK','_buyCost','_sellCost', '_currentSupply', '_isCommander', '_marketPrices' ];

	_market = _this;
	_marketBuyCost =  [];
	_marketSellCost = [];
	_marketStock = [];

	if (isNil "_market") exitWith {
		PROFILER_END();
		[marketEmptyContainer, marketEmptyPriceList];		
	};

	if (isNull _market) exitWith {
		PROFILER_END();
		[marketEmptyContainer, marketEmptyPriceList];
	};

	_marketInited = _market getVariable "marketInited";
	if (isNil '_marketInited') then {
		_market call marketInitMarketStorage;
	};

	_marketStock = (_market) call marketGetContainerItems;
	_marketPrices = _market getVariable "marketProductPrice";

PROFILER_END();
[_marketStock, _marketPrices];