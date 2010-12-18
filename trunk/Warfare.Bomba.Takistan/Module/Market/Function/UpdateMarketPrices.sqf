#include "profiler.h"
PROFILER_BEGIN("Market_UpdateMarketPrices");

Private ['_market', '_u', '_marketBuyCost', '_marketSellCost', '_marketInited', '_u', '_buyCoef', '_baseCost', '_productVolume', '_sellK','_buyCost','_sellCost', '_currentSupply', '_isCommander', '_isFactory', '_buildings', '_isTown' ];

	_market = _this select 0;
	_stock = _this select 1;

	_productPrices = _market call marketGetMarketPrices;
	_u = marketTotalProductCount;
	while { _u != 0 } do {
		_u = _u - 1;
		
		_baseCost = marketProductBasePriceCollection select _u;
		_maxVolumeProduced = marketProductMaxProduceVolumeCollection select _u;
		_productVolume = _stock select _u;
		
		// если мы имеем на базе менее 100тон товара нам нужно повысить цену покупки и понизить цену продажи
		_deltaPrice = 0.5*(1 - (_productVolume / _maxVolumeProduced)); // увеличиваем цену продажи игроком
		if (_deltaPrice < -0.5) then { _deltaPrice = -0.5 + ((_deltaPrice + 0.5)*0.25); };
		if (_deltaPrice >  0.5) then { _deltaPrice = 0.5; };
		
		if (_deltaPrice < -1) then { _deltaPrice = -1; };
		
		_baseCost = _baseCost * (1 + _deltaPrice);
		
		_sellCost = floor(_baseCost * 0.90);
		_buyCost = _baseCost + (_baseCost - _sellCost);	
		
		if (_buyCost < 5) then { _buyCost = 5; };
		if (_sellCost < 5) then { _sellCost = 5; };
		if (_sellCost > _buyCost) then { _buyCost = _sellCost; };
		
		_sellCost = _sellCost call marketRoundValue;
		_buyCost  = _buyCost call marketRoundValue;
		
		_price = _productPrices select _u;
		_price set [0, _sellCost];
		_price set [1, _buyCost];
		sleep 0.005;
	};

	_market setVariable ["marketProductPrice", _productPrices, true];
PROFILER_END();