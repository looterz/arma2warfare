#include "profiler.h"
PROFILER_BEGIN("Market_GetUnitRequiredProducts");

private['_factory', '_unit', '_unitPrice', '_u', '_found', '_unitData', '_unitData1', '_type', '_products', '_marketStock', '_marketPrices', '_reqProduct', '_reqProductId', '_reqProductValue', '_stockValue', '_cost', '_buyValue', '_price', '_buy', '_name'];

	_unit = _this;
	_unitData = nil;
	_u = count marketBuildUnitProductRequire;

	while { _u != 0 } do {
		_u = _u - 1;

		_unitData1 = marketBuildUnitProductRequire select _u;
		_type = _unitData1 select 0;

		if (_unit isKindOf _type) then {
			_unitData = _unitData1;
			_u = 0;
		};	
	};

PROFILER_END();	
_unitData;