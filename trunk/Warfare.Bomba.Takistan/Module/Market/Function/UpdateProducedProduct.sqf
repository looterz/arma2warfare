#include "profiler.h"
PROFILER_BEGIN("Market_UpdateProducedProduct");

Private ['_marketSideId', '_market','_products', '_productivity', '_lastProduceProduct', '_dT', '_storage', '_prices', '_incCoef', '_supplyValue', '_maxSV', '_u', '_updated', '_value', '_inc', '_product', '_maxProduced' ];

	_market = _this;

	_lastProduceProduct = _market getVariable "marketLastProduceProduct";
	if (isNil '_lastProduceProduct') then { _lastProduceProduct = time; };

	_market setVariable ["marketLastProduceProduct", time];
	_dT = time - _lastProduceProduct;

	if (!WF_DEBUG) then {
		_dT = (_dT / 60); // we has productivity in minutes
	};

	_storage = _market call marketGetMarketProducts;
	_productivity = _market getVariable "marketProductivity";
	_marketSideId = _market getVariable "sideID";

	_incCoef = 1;
	if (_market in towns) then {
		_supplyValue = _market getVariable "supplyValue";
		_maxSV = _market getVariable "maxSupplyValue";
		_incCoef = 1 + ((_supplyValue / _maxSV)*0.25);
	};

	_u = count _storage;
	_updated = false;

	while { _u != 0 } do {
		_u = _u - 1;
		
		_product = marketProductCollection select _u;
		_productSideId = _product select 6;
		
		if (_productSideId == -1 || _productSideId == 0 || _productSideId == _marketSideId) then {		
			_value = _storage select _u;
			_inc = (_productivity select _u) * _dT * _incCoef;
			
			_maxProduced = marketProductMaxProduceVolumeCollection select _u;

			if (_inc >= 0.1 && _value < _maxProduced) then {
				_value = _value + _inc;
				
				_value = (floor(_value * 10)) / 10;			
				if (_value > _maxProduced) then { _value = _maxProduced; };
				
				_storage set [_u, _value];
				_updated = true;
			};
		};
	};

	if (_updated) then {
		[_market, _storage] call marketSetContainerItems;
		
		[_market, _storage] call marketUpdateMarketPrices;	
		_market setVariable ["marketTimeStamp", format["%1", time], true];
	};

PROFILER_END();	