Private ['_market', '_u', '_marketBuyCost', '_marketSellCost', '_marketInited', '_u', '_buyCoef', '_baseCost', '_productVolume', '_sellK','_buyCost','_sellCost', '_currentSupply', '_isCommander', '_isFactory', '_buildings', '_isTown' ];

_market = _this select 0;
_stock = _this select 1;

_fnRoundPriceValue = {

	if (_this > 10) then { _this = floor(_this); };
	if (_this > 100) then { _this = floor(_this/10)*10; };
	if (_this > 1000) then { _this = floor(_this/100)*100; };
	if (_this > 10000) then { _this = floor(_this/1000)*1000; };
	
	_this;
};

_productPrices = [];
_u = 0;
while { (_u < (count marketProductCollection)) } do {
	
	_product = marketProductCollection select _u;
	_baseCost = _product select 2;
	_maxVolumeProduced = _product select 3;
	_productVolume = _stock select _u;
	
	// если мы имеем на базе менее 100тон товара нам нужно повысить цену покупки и понизить цену продажи
	_deltaPrice = ((_maxVolumeProduced - _productVolume) / _maxVolumeProduced) / 2 ; // увеличиваем цену продажи игроком
	if (_deltaPrice < -0.5) then { _deltaPrice = -0.5 + ((_deltaPrice + 0.5)*0.25); };
	if (_deltaPrice >  0.5) then { _deltaPrice = 0.5; };
	
	if (_deltaPrice < -1) then { _deltaPrice = -1; };
	
	_baseCost = _baseCost * (1 + _deltaPrice);
	
	_sellCost = floor(_baseCost * 0.95);
	_buyCost = floor(_baseCost * 1.05);	
	
	if (_buyCost < 5) then { _buyCost = 5; };
	if (_sellCost < 5) then { _sellCost = 5; };
	if (_sellCost > _buyCost) then { _buyCost = _sellCost; };
	
	_sellCost = _sellCost call _fnRoundPriceValue;
	_buyCost  = _buyCost call _fnRoundPriceValue;
	_price = [_sellCost, _buyCost];
	_productPrices = _productPrices + [ _price ];
	
	_u = _u + 1;
};

_market setVariable ["marketProductPrice", _productPrices, true];