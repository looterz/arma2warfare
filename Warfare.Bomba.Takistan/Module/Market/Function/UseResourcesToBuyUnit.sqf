#include "profiler.h"
PROFILER_BEGIN("Market_UseResourcesToBuyUnit");

private['_factory', '_unit', '_unitPrice', '_u', '_found', '_unitData', '_unitData1', '_type', '_products', '_marketStock', '_marketPrices', '_reqProduct', '_reqProductId', '_reqProductValue', '_stockValue', '_cost', '_buyValue', '_price', '_buy', '_name'];

	_unit = _this select 1;

	_unitData = _unit call marketGetUnitRequiredProducts;
		
	if (isNil '_unitData') exitWith { 
		format["Resources is not required for buy unit %1", _unit] call LogHigh;
		
		PROFILER_END(); 
	};

	_factory = _this select 0;
	_unitPrice = _this select 2;

	_marketStock = _factory call marketGetMarketProducts;
	_marketPrices = _factory call marketGetMarketPrices;

	_u = count _unitData;
	while { _u != 1  } do {
		_u = _u - 1;

		_reqProduct = _unitData select _u;
		_reqProductId = _reqProduct select 0;
		_reqProductValue = _reqProduct select 1;
		
		[_factory, _reqProductId, -_reqProductValue] call marketUpdateProductValue;
	};

PROFILER_END();