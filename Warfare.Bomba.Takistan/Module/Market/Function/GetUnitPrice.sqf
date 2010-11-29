#include "profiler.h"
PROFILER_BEGIN("Market_GetUnitPrice");

private['_factory', '_unit', '_unitPrice', '_products'];

	_factory = _this select 0;
	_unit = _this select 1;
	_unitPrice = _this select 2;

	_products = _factory call marketGetMarketProducts;
	_unitPrice = [_products, _unit, _unitPrice] call marketGetUnitPriceEx;

PROFILER_END();
_unitPrice;