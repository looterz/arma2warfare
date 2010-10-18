Private ['_unitType','_su'];

	_market = _this select 0;
	_products = [_market] call marketGetMarketProducts;
	_productivity = _market getVariable "marketProductivity";
	
	_lastProduceProduct = _market getVariable "marketLastProduceProduct";
	if (isNil '_lastProduceProduct') then { _lastProduceProduct = time; };
	
	_market setVariable ["marketLastProduceProduct", time];
	_dT = time - _lastProduceProduct;
	
	if (!WF_DEBUG) then {
		_dT = (_dT / 60); // we has productivity in minutes
	};

	//diag_log format['update produced products: _dT=%1', _dT];
	
	_stock = _products select 0;
	_prices = _products select 1;
	
	_incCoef = 1;
	if (_market in towns) then {
		_supplyValue = _market getVariable "supplyValue";
		_maxSV = _market getVariable "maxSupplyValue";
		_incCoef = 1 + ((_supplyValue / _maxSV)*0.25);
	};
	
	_u = 0;
	_updated = false;
	_storage = [];
	while { _u < (count _stock) } do {
		
		_value = _stock select _u;
		_inc = (_productivity select _u) * _dT * _incCoef;

		_product = marketProductCollection select _u;
		_maxProduced = _product select 3;

		if (_inc >= 0.1 && _value < _maxProduced) then {
			_value = _value + _inc;
			
			_value = (floor(_value * 10)) / 10;			
			if (_value > _maxProduced) then { _value = _maxProduced; };
			
			_stock set [_u, _value];
			_updated = true;
		};
		
		if (_value > 0) then {
			_storage = _storage + [ [_u, _value] ];
		};			
		_u = _u + 1;
	};

	if (_updated) then {
		_market setVariable ["marketProductStorage", _storage, true];
	};

	[_market, _stock] call marketUpdateMarketPrices;	
	_market setVariable ["marketTimeStamp", format["%1", time], true];
