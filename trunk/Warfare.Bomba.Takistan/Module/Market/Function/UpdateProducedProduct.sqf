#include "profiler.h"
PROFILER_BEGIN("Market_UpdateProducedProduct");

Private ['_market','_products', '_productivity', '_lastProduceProduct', '_dT', '_stock', '_prices', '_incCoef', '_supplyValue', '_maxSV', '_u', '_updated', '_value', '_inc', '_product', '_maxProduced' ];

	_market = _this;

	_lastProduceProduct = _market getVariable "marketLastProduceProduct";
	if (isNil '_lastProduceProduct') then { _lastProduceProduct = time; };

	_market setVariable ["marketLastProduceProduct", time];
	_dT = time - _lastProduceProduct;

	if (!WF_DEBUG) then {
		_dT = (_dT / 60); // we has productivity in minutes
	};

	_stock = _market call marketGetMarketProducts;
	_prices = _market call marketGetMarketPrices;
	_productivity = _market getVariable "marketProductivity";

	_incCoef = 1;
	if (_market in towns) then {
		_supplyValue = _market getVariable "supplyValue";
		_maxSV = _market getVariable "maxSupplyValue";
		_incCoef = 1 + ((_supplyValue / _maxSV)*0.25);
	};

	_u = count _stock;
	_updated = false;

	while { _u != 0 } do {
		_u = _u - 1;
		
		_value = _stock select _u;
		_inc = (_productivity select _u) * _dT * _incCoef;

		_maxProduced = marketProductMaxProduceVolumeCollection select _u;

		if (_inc >= 0.1 && _value < _maxProduced) then {
			_value = _value + _inc;
			
			_value = (floor(_value * 10)) / 10;			
			if (_value > _maxProduced) then { _value = _maxProduced; };
			
			_stock set [_u, _value];
			_updated = true;
		};
	};

	if (_updated) then {
		_market setVariable ["marketProductStorage", _stock, true];
	};

	[_market, _stock] call marketUpdateMarketPrices;	
	_market setVariable ["marketTimeStamp", format["%1", time], true];

PROFILER_END();	