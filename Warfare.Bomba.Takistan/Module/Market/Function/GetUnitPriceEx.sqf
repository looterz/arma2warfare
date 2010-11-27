#include "profiler.h"
PROFILER_BEGIN("Market_GetUnitPriceEx");

private['_factory', '_unit', '_unitPrice', '_u', '_found', '_unitData', '_unitData1', '_type', '_products', '_marketStock', '_marketPrices', '_reqProduct', '_reqProductId', '_reqProductValue', '_stockValue', '_cost', '_buyValue', '_price', '_buy', '_name'];

_products = _this select 0;
_unit = _this select 1;
_unitPrice = _this select 2;

if (!paramVehicleComponents) exitWith { 
	PROFILER_END();
	_unitPrice; 
};

_unitData = _unit call marketGetUnitRequiredProducts;
	
if (isNil "_unitData") exitWith { 
	format["Resources is not found for buy unit %1", _unit] call LogHigh;
	
	PROFILER_END();
	_unitPrice; 
};

_marketStock = _products select 0;
_marketPrices = _products select 1;

_u = count _unitData;
while { !(_u == 1)  } do {
	_u = _u - 1;

	_reqProduct = _unitData select _u;
	_reqProductId = _reqProduct select 0;
	_reqProductValue = _reqProduct select 1;
	
	_stockValue = _marketStock select _reqProductId;
	
	_marketStock set [_reqProductId, (_stockValue - _reqProductValue)];
	_cost = 0;
	
	if (_stockValue < _reqProductValue) then {
	
		_marketStock set [_reqProductId, 0];
		_buyValue = _reqProductValue - _stockValue;
		
		_price = _marketPrices select _reqProductId;
		_buy = _price select 1;			
		if (_buy > 0) then {
			_cost = _buy * _buyValue;		
		};
	};
	_unitPrice = _unitPrice + _cost;
};

PROFILER_END();
_unitPrice;