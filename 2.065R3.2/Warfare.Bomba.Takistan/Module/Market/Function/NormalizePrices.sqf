#include "profiler.h"
PROFILER_BEGIN("Market_NormalizePrices");

Private ['_market', '_u', '_marketBuyCost', '_marketSellCost', '_marketInited', '_u', '_buyCoef', '_baseCost', '_productVolume', '_sellK','_buyCost','_sellCost', '_currentSupply', '_isCommander', '_isFactory', '_buildings', '_isTown', '_products', '_townProducts', '_sorted','_tax' ];

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
	
_markets = [] + towns;
_markets = _markets + (("WEST") Call GetSideStructures);
_markets = _markets + (("EAST") Call GetSideStructures);
	
_sorted = [_market, _markets] Call SortByDistance;
	
_updated = false;
{
	if (_x != _market) then  {
		_dist = _market distance _x;
		
		if (_dist < 1500) then {
			if (_dist < 500) then { _dist = 0; };

			_tax = (0.05*_dist/500);		

			_townProducts = [_x] call marketGetMarketProducts;
			_townPrices = _townProducts select 1;
			
			_u = (count marketProductCollection);
			while { !(_u == 0)  } do {
				_u = _u - 1;
			
				_productInfo = marketProductCollection select _u;		
				_marketPrice = _marketPrices select _u;
				
				_townSellCost = (_townPrices select _u) select 0;
				_townBuyCost = (_townPrices select _u) select 1;
				
				_dSell = _townSellCost*_tax;
				_dBuy = _townBuyCost*_tax;
				
				if (_dist > 500) then {
					_dSell = _dSell + 5;
					_dBuy = _dBuy + 5;
				};
				
				_townSellCost = _townSellCost + _dSell;
				_townBuyCost = _townBuyCost + _dBuy;
				
				_marketSellCost = _marketPrice select 0;
				_marketBuyCost = _marketPrice select 1;
				
				_townBuyCost  = _townBuyCost call _fnRoundPriceValue;
				_townSellCost = _townSellCost call _fnRoundPriceValue;
				
				// // check if we have sell price less then we have at nearest town
				if (_townBuyCost > 0 && _townBuyCost < _marketSellCost ) then {	
				
					_marketPrice set [0, _townBuyCost ];
					_updated = true;
				};
			};
		};
	};
} forEach _sorted;
	
if (_updated) then {
	_market setVariable ["marketProductPrice", _marketPrices, true];
	_market setVariable ["marketTimeStamp", format["%1", time], true];
};

PROFILER_END();