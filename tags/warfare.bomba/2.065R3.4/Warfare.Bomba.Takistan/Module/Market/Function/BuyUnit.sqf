#include "profiler.h"
PROFILER_BEGIN("Market_BuyUnit");

private['_factory', '_unit', '_unitPrice', '_u', '_found', '_unitData', '_unitData1', '_type', '_products', '_marketStock', '_marketPrices', '_reqProduct', '_reqProductId', '_reqProductValue', '_stockValue', '_cost', '_buyValue', '_price', '_buy', '_name'];

_factory = _this select 0;
_unit = _this select 1;
_unitPrice = _this select 2;

if (!paramVehicleComponents) exitWith { 
	PROFILER_END();
	_unitPrice; 
};


_u = 0;
_found = false;
_unitData = objNull;

_u = count marketBuildUnitProductRequire;

format["Get Required Product List for %1", _unit] call LogHigh;
while { _u != 0 } do {
	_u = _u - 1;

	_unitData1 = marketBuildUnitProductRequire select _u;
	_type = _unitData1 select 0;
	format["_unitData: %1", _type] call LogHigh;
	
	if (_unit isKindOf _type) then {
		_unitData = _unitData1;
		_found = true;
		_u = 0;
	};	
};
	
if (!_found) exitWith { 
	PROFILER_END();
	format["Get Required Product List for %1: Data Not Found", _unit] call LogHigh;
	_unitPrice; 
};

_marketStock = _factory call marketGetMarketProducts;
_marketPrices = _factory call marketGetMarketPrices;

_u = count _unitData;
while { _u != 1  } do {
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
	if (WF_DEBUG) then {
		_name = marketProductNameCollection select _reqProductId;
		format["Product %1: Required=%2 StockValue=%3 Cost=%4 --> UnitPrice=%5", _name, _reqProductValue, _stockValue, _cost, _unitPrice ] call LogHigh;
	};
};

PROFILER_END();
_unitPrice;