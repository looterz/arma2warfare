#include "profiler.h"
PROFILER_BEGIN("Market_InitMarketStorage");

Private ['_market', '_u', '_marketBuyCost', '_marketSellCost', '_marketInited', '_u', '_isTown', '_buyCoef', '_baseCost', '_productVolume', '_sellK','_buyCost','_sellCost', '_currentSupply', '_isCommander', '_isFactory', '_buildings' ];

	_market = _this;
	_isTown = (_market in towns);

	_storage = [] + marketEmptyContainer;
	_productivity = [] + marketEmptyPriceList;

	_u = marketTotalProductCount;
	while { _u != 0 } do {
		_u = _u - 1;

		_maxProduced     = (marketProductMaxProduceVolumeCollection select _u)*0.25;
		_maxProduceSpeed = marketProductMaxProduceSpeedCollection select _u;

		_value = if (_isTown) then { floor(random _maxProduced) } else { 0 };
		_prodvalue = if (_isTown) then { random _maxProduceSpeed } else { 0 };
		
		if (!paramSupplyExchange && _u == marketProductIdSupply) then { _value = 0; _prodvalue = 0; };

		_storage set [_u, _value];
		_productivity set [_u, _prodvalue ];
	};

	
	[_market, _storage] call marketUpdateMarketPrices;

	_market setVariable ["marketProductivity", _productivity];
	_market setVariable ["marketProductStorage", _storage, true];
	_market setVariable ["marketTimeStamp", format["%1", time], true];
	_market setVariable ["marketInited", 1, true];

PROFILER_END();