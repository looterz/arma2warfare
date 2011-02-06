#include "profiler.h"
PROFILER_BEGIN("Market_InitMarketStorage");

private['_marketSideId','_market','_u','_u','_isTown','_value','_productsideid','_storage','_maxproducespeed','_prodvalue','_productivity','_maxproduced','_prices','_product'];

	_market = _this;
	_isTown = (_market in towns);
	
	waitUntil { !isNil "WESTBaseStructures" && !isNil "EASTBaseStructures" };
	
	_marketSideId = -1;
	if (!_isTown && _market in WESTBaseStructures) then { _marketSideId = WESTID };
	if (!_isTown && _market in EASTBaseStructures) then { _marketSideId = EASTID };
	
	if (!_isTown) then {
		_market setVariable ["sideID", _marketSideId];
	};
	

	_storage = [] + marketEmptyContainer;
	_productivity = [] + marketEmptyContainer;
	_prices = [] + marketEmptyPriceList;

	_u = marketTotalProductCount;
	while { _u != 0 } do {
		_u = _u - 1;

		_product = marketProductCollection select _u;
		_productSideId = _product select 6;
		
		_maxProduced     = (marketProductMaxProduceVolumeCollection select _u);
		_maxProduceSpeed = marketProductMaxProduceSpeedCollection select _u;

		_value = if (_isTown) then { random (_maxProduced / 4) } else { _maxProduced / 2};
		_prodvalue = if (_isTown) then { random (_maxProduceSpeed) }
				     else { _maxProduceSpeed*0.5 + random (_maxProduceSpeed*0.5) };
				
		if (!_isTown && _productSideId != 0 && _productSideId != _marketSideId) then {	// set zero productivity for enemy products
			_value = 0;
			_prodvalue = 0;			
		};
		if (_isTown && _productSideId != -1) then { _value = 0; };
		if (!_isTown && _productSideId == -1) then { _value = 0; }; // factory can produce only side depended product
		if (!paramSupplyExchange && _u == marketProductIdSupply) then { _value = 0; _prodvalue = 0; };

		_storage set [_u, floor(_value) ];
		_productivity set [_u, _prodvalue ];
	};

	[_market, _storage] call marketSetContainerItems;
	
	_market setVariable ["marketProductivity", _productivity];
	_market setVariable ["marketProductPrice", _prices];
	_market setVariable ["marketInited", 1, true];
	
	[_market, _storage] call marketUpdateMarketPrices;


PROFILER_END();