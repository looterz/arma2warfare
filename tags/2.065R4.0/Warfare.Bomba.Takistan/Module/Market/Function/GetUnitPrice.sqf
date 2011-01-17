#include "profiler.h"
PROFILER_BEGIN("Market_GetUnitPrice");

private['_factory', '_unit', '_unitPrice', '_products', '_prices'];

	_unitPrice = _this select 2;

	if (!paramVehicleComponents) exitWith { 
		PROFILER_END();
		_unitPrice; 
	};

	_factory = _this select 0;
	_unit = _this select 1;
	
	_products = _factory call marketGetMarketProducts;
	_prices = _factory call marketGetMarketPrices;
	_unitPrice = [_products, _prices, _unit, _unitPrice] call marketGetUnitPriceEx;

PROFILER_END();
_unitPrice;