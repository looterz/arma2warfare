Private ['_market', '_u', '_marketBuyCost', '_marketSellCost', '_marketInited', '_u', '_isTown', '_buyCoef', '_baseCost', '_productVolume', '_sellK','_buyCost','_sellCost', '_currentSupply', '_isCommander', '_isFactory', '_buildings' ];

_market = _this select 0;
_stock = [];
_storage = [];
_productivity = [];

_isTown = (_market in towns);
_fnRoundPriceValue = {

	if (_this > 10) then { _this = floor(_this); };
	if (_this > 100) then { _this = floor(_this/10)*10; };
	if (_this > 1000) then { _this = floor(_this/100)*100; };
	if (_this > 10000) then { _this = floor(_this/1000)*1000; };
	
	_this;
};

_u = 0;
while { (_u < (count marketProductCollection)) } do {

	_product = marketProductCollection select _u;
	_maxProduced = (_product select 3)*0.25;
	_maxProduceSpeed = _product select 4;

	_value = if (_isTown) then { floor(random _maxProduced); } else { 0; };
	_prodvalue = if (_isTown) then { random _maxProduceSpeed; } else { 0; };

	_stock = _stock + [ _value ];
	
	if (_value > 0) then {
		_storage = _storage + [ [_u, _value ] ];
	};
	
	_productivity = _productivity + [ _prodvalue ];
	_u = _u + 1;
};

[_market, _stock] call marketUpdateMarketPrices;

_market setVariable ["marketProductivity", _productivity];
_market setVariable ["marketProductStorage", _storage, true];
_market setVariable ["marketTimeStamp", format["%1", time], true];