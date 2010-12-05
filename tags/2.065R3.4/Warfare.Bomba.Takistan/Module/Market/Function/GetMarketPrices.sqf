#include "profiler.h"
PROFILER_BEGIN("Market_GetMarketProducts");

Private ["_market", "_marketStock", "_marketInited", "_prices"];

	_market = _this;
	_marketStock = [];

	if (isNil "_market") exitWith {
		PROFILER_END();
		marketEmptyPriceList;		
	};

	if (isNull _market) exitWith {
		PROFILER_END();
		marketEmptyPriceList;
	};

	_marketInited = _market getVariable "marketInited";
	if (isNil '_marketInited') then {
		_market call marketInitMarketStorage;
	};

	_prices = _market getVariable "marketProductPrice";

PROFILER_END();
_prices;