#include "profiler.h"
PROFILER_BEGIN("Market_UpdateMarketPrices");

Private ['_market', '_u', '_marketBuyCost', '_marketSellCost', '_marketInited', '_u', '_buyCoef', '_baseCost', '_productVolume', '_sellK','_buyCost','_sellCost', '_currentSupply', '_isCommander', '_isFactory', '_buildings', '_isTown' ];

	_market = _this select 0;
	_stock = _this select 1;

	_productPrices = [] + marketEmptyPriceList;
	_u = marketTotalProductCount;
	while { _u != 0 } do {
		_u = _u - 1;
		
		_baseCost = marketProductBasePriceCollection select _u;
		_maxVolumeProduced = marketProductMaxProduceVolumeCollection select _u;
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
		
		_sellCost = _sellCost call marketRoundValue;
		_buyCost  = _buyCost call marketRoundValue;
		_price = [_sellCost, _buyCost];
		_productPrices set [_u, _price];
	};

	_market setVariable ["marketProductPrice", _productPrices, true];
PROFILER_END();