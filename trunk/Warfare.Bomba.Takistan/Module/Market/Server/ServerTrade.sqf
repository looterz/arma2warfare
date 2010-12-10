private['_nearTime', '_dT', '_periodTownUpdate', '_periodFactoryUpdate', '_nextTownUpdate', '_nextFactoryUpdate', '_buildings', '_market', '_products', '_stock'  ];

waitUntil { serverInitComplete };


_periodTownUpdate = if (WF_DEBUG) then { 60; } else { 300; };
_periodFactoryUpdate = if (WF_DEBUG) then { 60; } else { 120; };

_nextTownUpdate = time + _periodTownUpdate;
_nextFactoryUpdate = time + _periodFactoryUpdate;
while { true } do {

	_nearTime = _nextTownUpdate;
	if (_nearTime > _nextFactoryUpdate) then { _nearTime = _nextFactoryUpdate; };

	_dT = _nearTime - time;
	if (_dT < 1) then { _dT = 1; };
        sleep _dT;

	format["Market time=%1", time]  call LogHigh;
	
	if (_nextTownUpdate < time) then {
		"Market updating town markets" call LogHigh;

		{ _x call marketUpdateProducedProduct; } forEach towns;
		{ _x call marketNormalizePrices; } forEach towns;
		
		_nextTownUpdate = time + _periodTownUpdate;
	};
	
	if (_nextFactoryUpdate < time) then  {
	
		"Market: Updating factory markets" call LogHigh;
	
		_buildings = [] + (("WEST") Call GetSideStructures);
		_buildings = _buildings + (("EAST") Call GetSideStructures);		
		
		if (paramHangars) then { _buildings = _buildings + Airfields; };
		
		{
			_market = _x;
			_products = _market call marketGetMarketProducts;
			[_market, _products] call marketUpdateMarketPrices;
			_market spawn marketNormalizePrices;
		
		} forEach _buildings;
		_nextFactoryUpdate = time + _periodFactoryUpdate;
	};
};
