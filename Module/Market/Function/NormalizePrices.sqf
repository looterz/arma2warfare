Private ['_market', '_u', '_marketBuyCost', '_marketSellCost', '_marketInited', '_u', '_buyCoef', '_baseCost', '_productVolume', '_sellK','_buyCost','_sellCost', '_currentSupply', '_isCommander', '_isFactory', '_buildings', '_isTown', '_products', '_townProducts' ];

_market = _this select 0;

_fnRoundPriceValue = {

	if (_this > 10) then { _this = floor(_this); };
	if (_this > 100) then { _this = floor(_this/10)*10; };
	if (_this > 1000) then { _this = floor(_this/100)*100; };
	if (_this > 10000) then { _this = floor(_this/1000)*1000; };
	
	_this;
};

// - we need reread for get updated prices
_products = [_market] call marketGetMarketProducts;
_marketStock = _products select 0;
_marketPrices = _products select 1;
	
_updated = false;
{
	if (_x != _market) then  {
		_dist = _market distance _x;
		if (_dist < 500) then { _dist = 500; };

		_distTax = 1 + (0.01*(_dist-500)/500);		

		_townProducts = [_x] call marketGetMarketProducts;
		_townPrices = _townProducts select 1;
		
		_u = 0;
		while { (_u < (count marketProductCollection)) } do {
		
			_marketPrice = _marketPrices select _u;
			_townBuyCost = ((_townPrices select _u) select 1)*_distTax;
			_townSellCost = ((_townPrices select _u) select 0)*_distTax;
			_marketSellCost = _marketPrice select 0;
			
			_townBuyCost  = _townByCost call _fnRoundPriceValue;
			_townSellCost = _townSellCost call _fnRoundPriceValue;
			
			if (_marketSellCost < _townBuyCost) then {	// мы продаем на текущем заводе по цене меньше чем мы покупаем в ближ городе
				_marketPrice set [0, _townBuyCost  ];
				_marketPrice set [1, _townSellCost ];
				_updated = true;
			};
		};
	};
} forEach towns;
	
if (_updated) then {
	_market setVariable ["marketProductPrice", _marketPrices, true];
	_market setVariable ["marketTimeStamp", format["%1", time], true];
};