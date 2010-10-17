Private ['_market', '_marketStock', '_marketBuyCost', '_marketSellCost', '_marketInited', '_u', '_buyCoef', '_baseCost', '_productVolume', '_sellK','_buyCost','_sellCost', '_currentSupply', '_isCommander' ];

_market = _this select 0;
_marketBuyCost =  [];
_marketSellCost = [];
_marketStock = [];

if (isNil '_market' || isNull _market) exitWith { 
	_u = 0;
	
	_prices = [];
	while { _u < (count marketProductCollection) } do {
		_marketStock =  _marketStock + [0];
		_prices = _prices + [[-1, -1]];
		_u = _u + 1;
	};

	[_marketStock, _prices] 
};	

_marketInited = _market getVariable "marketInited";
if (isNil '_marketInited') then {
	[_market] call marketInitMarketStorage;
	_market setVariable ["marketInited", 1, true];
};

_marketStock = [_market] call marketGetContainerItems;
_marketPrices = _market getVariable "marketProductPrice";

[_marketStock, _marketPrices];