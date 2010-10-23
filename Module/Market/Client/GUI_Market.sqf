disableSerialization;

_cargo = player;
_cargoMaxWeight = objNull;
_cargoUnitType = objNull;
_cargoItems = objNull;
_cargoSU = objNull;

_display = _this select 0;

lnbAddRow  [17004, ["Product", "Unit", "Sell", "Buy", "Cargo", "Stock"] ];
ctrlEnable [17004,false];

_uiTitle = 17001;
_uiProductList = 17005;

_uiNearMarketDropDown = 17003;
_uiBuyVolumeText   = 17010;
_uiBuyVolumeSlider = 17011;
_uiBuyVolumeButton = 17012;

_uiSellVolumeText   = 17020;
_uiSellVolumeSlider = 17021;
_uiSellVolumeButton = 17022;

_uiCashText = 17030;
_uiCostText = 17040;
_uiFreeCargo = 17050;

_selectedMarketId = -1;
_lastSV = -1;
_lastTimeStamp = -1;

_nearMarkets = [];
_market = objNull;
_marketStock = [];
_marketPrices = [];
_productId = 0;

_procGetPlayerCargo = {
private['_crew','_u', '_count', '_crewman', '_hq', '_found', '_vehType', '_type' ];

	_cargo = vehicle player;

	if (_cargo != player) then {

		_crew = crew _cargo;
		_u = 0;
		_count = 0;
		while { _u < count _crew } do {
		
			_crewman = _crew select _u;
			if (_crewman != player && (isPlayer _crewman)) then { _count = _count +1; };		
			_u = _u +1;		
		};
		
		if (_count > 0) then { _cargo = player; };	
	};

	_hq = WF_Logic getVariable Format ["%1MHQ",sideJoinedText];
	if (_cargo == _hq) then { _cargo = player; };

	_cargoMaxWeight = 0;
	_cargoUnitType = "kg";

	_u = 0;
	_found = false;
	while { _u < count marketTransportVehicleTypes && !_found } do {

		_vehType = marketTransportVehicleTypes select _u;
		
		_type = _vehType select 0;
		if (_cargo isKindOf _type) then {
		
			_cargoMaxWeight = _vehType select 1;
			_cargoUnitType   = _vehType select 2;
			_found = true;
		};	
		_u = _u+1;
	};

	_cargoSU    = [_cargoUnitType] call marketGetSU;
	_cargoItems = [_cargo] call marketGetContainerItems;
};
_procReadStockData = {

	_market = if (_selectedMarketId >= 0) then { _nearMarkets select _selectedMarketId } else { objNull };
	_products = [_market] call marketGetMarketProducts;
		
	_marketStock = _products select 0;
	_marketPrices = _products select 1;

	_isTown = if (_market in towns) then { true } else { false };
	_isMHQ = if (WF_Logic getVariable Format ["%1MHQ",sideJoinedText] == _market) then { true } else { false };
	_isFactory = if (_market in (WF_Logic getVariable Format ['%1BaseStructures',sideJoinedText])) then { true} else { false };

	
	if (_isMHQ) then {
	
		_u = 0;
		while { _u < count _marketStock } do {
			_marketStock set [_u, 0];
			_marketPrices set [_u, [-1, -1] ];
			_u = _u + 1;
		};
	};
	
	if (paramSupplyExchange) then {
	
		if (_isMHQ || _isFactory) then {
			_currentSupply = WF_Logic getVariable Format ["%1Supplies",sideJoinedText];
			_currentSupply = floor (_currentSupply / 1000);	
			
			_marketStock set [marketProductIdSupply, _currentSupply];	// -- set current supply level;

			_isCommander = false;
			if (!isNull(commanderTeam)) then {if (commanderTeam == group player) then {_isCommander = true}};
			
			if (_isCommander && _isMHQ) then {
				_newPrice = [0, 0];
				_marketPrices set [marketProductIdSupply, _newPrice ]; // -- commander can get supplies at hq
			} else {
				_newPrice = [0, -1];
				_marketPrices set [marketProductIdSupply, _newPrice ]; // -- any player call sell supplies to any factory
			};
		};
	} else {
		_marketStock set [marketProductIdSupply, 0];
		_newPrice = [-1, -1];
		_marketPrices set [marketProductIdSupply, _newPrice ];
	};
};
_procUpdateStockProduct = {
	_hq = WF_Logic getVariable Format ["%1MHQ",sideJoinedText];

	_market = _this select 0;
	_productId  = _this select 1;
	_incValue  = _this select 2;

	if (_market == _hq) then {

		if (_productId == marketProductIdSupply) then {
			_sv = WF_Logic getVariable Format ["%1Supplies",sideJoinedText];
			_sv = _sv  + (_incValue * 1000);
			
			if (_sv < 0) then { _sv = 0; };
			WF_Logic setVariable [Format ["%1Supplies",sideJoinedText], _sv, true];
		};	
	} else {
		[_market, _productId, _incValue] call marketUpdateProductValue;
		_market setVariable ["marketTimeStamp", format["%1", time], true];
	};
};

_procUpdateMarketsList = {

	_countNearMarkets = count _nearMarkets;
	_nearMarkets = [] call marketGetNearMarketList;
	if (_countNearMarkets != (count _nearMarkets)) then {
		lbClear _uiNearMarketDropDown;
		{
			_txt = '';
			if (_x in towns) then {
				_txt = _x getVariable 'name';
			} else {
				_txt = [typeof _x, 'displayName'] Call GetConfigInfo;
			};
			
			_txt = format["%1 Market", _txt];
			
			lbAdd[_uiNearMarketDropDown,_txt];
			
		} forEach _nearMarkets;
		lbSetCurSel [_uiNearMarketDropDown, 0];
		_countNearMarkets = (count _nearMarkets);
	};
};
_procUpdateMarketData  = {
	
	_force = _this select 0;
	if (isNil '_force') then { _force = false; };
	
	_sv = WF_Logic getVariable Format ["%1Supplies",sideJoinedText];
	if (_lastSV != _sv) then { _force = true; };
	
	_timeStamp = _market getVariable "marketTimeStamp";
	if (isNil '_timeStamp') then { _timeStamp = 0; };
	if (_timeStamp != _lastTimeStamp) then { _force = true; };

	_id = lbCurSel _uiNearMarketDropDown;
	if (_force || _id != _selectedMarketId) then {

		//hint format["LastUpd=%1 _force=%2", time, _force];
		_selectedMarketId = _id;
		_lastSV = _sv;
		
		[] call _procGetPlayerCargo;
		[] call _procReadStockData;
		
		_myCargo = _cargo;
		
		_lastTimeStamp = _market getVariable "marketTimeStamp";
		if (isNil '_lastTimeStamp') then { _lastTimeStamp = 0; };
		
		[] call _procUpdateProductList;
	};
};
_procUpdateProductList = {
private['_cargo', '_stockValue', '_price', '_sell', '_buy', '_txtSell', '_txtBuy', '_productSU', '_i', '_productName', '_productUnit', '_productCost' ];
	_grayColor = [0.5,0.5,0.5,1];
	_greenColor = [0, 0.5, 0,1];
	_whiteColor = [0, 0.5, 0,1];

	lnbClear _uiProductList;
	_i = 0;
	{
		_productName = _x select 0;
		_productUnit = _x select 1;
		_productCost = _x select 2;
		
		_productSU = [_productUnit] call marketGetSU;
		
		_cargo = _cargoItems select _i;
		_stockValue = floor(_marketStock select _i);
		_price = _marketPrices select _i;
		
		_sell = _price select 0;
		_buy = _price select 1;	
		
		_txtSell = '--';
		_txtBuy  = '--';
		
		if (_sell != -1) then { _txtSell = format["$%1", _sell] };
		if (_buy  != -1 && _stockValue > 0) then { _txtBuy  = format["$%1", _buy]  };		
		                               
		lnbAddRow  [_uiProductList, [_productName, _productUnit, _txtSell, _txtBuy, format["%1%2", _cargo, _productUnit] , format["%1%2", _stockValue, _productUnit]   ] ];
		
		if (_productSU > _cargoSU || (_stockValue == 0 && _cargo==0) ) then {
			lnbSetColor [_uiProductList, [_i, 0], _grayColor];
			lnbSetColor [_uiProductList, [_i, 2], _grayColor];
			lnbSetColor [_uiProductList, [_i, 3], _grayColor];
			lnbSetColor [_uiProductList, [_i, 5], _grayColor];
		};
		
		lnbSetColor [_uiProductList, [_i, 1], _grayColor];

		
		if (_cargo > 0) then { [0.0, 1.0, 0.0, 1] } else { };
		
		if (_sell == -1 && _buy == -1) then { 
			lnbSetColor [_uiProductList, [_i, 4], _grayColor];
			lnbSetColor [_uiProductList, [_i, 5], _grayColor];
		};
		
		lnbSetColor [_uiProductList, [_i, 4], (if (_cargo > 0) then { _greenColor } else {_grayColor}) ];
		_i = _i+1;
	} forEach marketProductCollection;
	
	lnbSetCurSelRow [_uiProductList, _productId];
};

MenuAction = -1;

SliderSetPosition[_uiBuyVolumeSlider, 0];
SliderSetPosition[_uiSellVolumeSlider, 0];
		
while {alive player && dialog} do {


	if (Side player != sideJoined && !_isCommander) exitWith {closeDialog 0};
	if (!dialog) exitWith {};

	[] call _procUpdateMarketsList;
	[] call _procUpdateMarketData;

	_productId = lnbCurSelRow _uiProductList;
	if (_productId == -1) then {
		_productId = 0;
		lnbSetCurSelRow [_uiProductList, _productId];
	};
	
	
	_product = marketProductCollection select _productId;
	_price = _marketPrices select _productId;
	
	_productUnit = _product select 1;
	_productSU = [_productUnit] call marketGetSU;
	
	_cargoValue = _cargoItems select _productId;
	_stockValue = _marketStock select _productId;
	
	_currentFunds = Call GetPlayerfunds;
	_sellValue = floor (SliderPosition _uiSellVolumeSlider);
	_buyValue = floor (SliderPosition _uiBuyVolumeSlider);
	
	if (_sellValue < 0) then { _sellValue = 0; };
	if (_buyValue < 0)  then { _buyValue = 0; };
	
	_costSell = _price select 0;
	_costBuy  = _price select 1;
	
	_cargoFreeSU = _cargoMaxWeight * _cargoSU;
	_u = 0;
	{ 
		_pid = (marketProductCollection select _u) select 1;
		_su =  [_pid] call marketGetSU;
		_cargoFreeSU = _cargoFreeSU - (_x * _su); 
		_u = _u+1;
	} forEach _cargoItems;
	if (_cargoFreeSU < 0) then { _cargoFreeSU = 0; };
	
	_freeCargo = (floor(10*_cargoFreeSU / _cargoSU)) / 10;
	
	_maxBuyValue = _stockValue;
	if ( (_stockValue * _productSU) > _cargoFreeSU) then { _maxBuyValue = floor(_cargoFreeSU / _productSU); };

	if (_buyValue > _maxBuyValue) then { _buyValue = _maxBuyValue; };
	_currentCost =  -(_buyValue*_costBuy) + (_sellValue*_costSell);
	
	ctrlSetText [_uiFreeCargo, format ["Free Cargo: %1%2", _freeCargo, _cargoUnitType]];	
	ctrlSetText [_uiBuyVolumeText, format ["Buy: %1%2", _buyValue, _productUnit]];	
	ctrlSetText [_uiSellVolumeText, format ["Sell: %1%2", _sellValue, _productUnit]];	

	SliderSetRange[_uiBuyVolumeSlider, 0,  _maxBuyValue];
	SliderSetRange[_uiSellVolumeSlider, 0, _cargoValue];

	if (_lastSelectedProductId != _productId) then {
		SliderSetPosition[_uiBuyVolumeSlider, 0];
		SliderSetPosition[_uiSellVolumeSlider, 0];	
		
		_lastSelectedProductId = _productId;
	};
	
	ctrlEnable [_uiBuyVolumeButton, (_stockValue > 0 && (_currentFunds + _currentCost) >= 0 && _maxBuyValue > 0 && _costBuy != -1)];
	ctrlEnable [_uiBuyVolumeSlider, (_stockValue > 0 && _maxBuyValue > 0 && _costBuy != -1)];
	ctrlEnable [_uiSellVolumeButton, (_cargoValue > 0 && _costSell != -1)];
	ctrlEnable [_uiSellVolumeSlider, (_cargoValue > 0 && _costSell != -1)];	
	
	ctrlSetText [_uiCostText, format ["Cost: $%1", _currentCost]];	
	ctrlSetText [_uiCashText, format ["Cash: $%1", _currentFunds]];	

	_color = if (_currentFunds + _currentCost < 0) then { [1, 0, 0, 1]; } else { [0, 1, 0, 1]; };
	_uiCashTextLabel = _display DisplayCtrl _uiCashText;
	_uiCashTextLabel ctrlSetTextColor _color;		
	
	if (MenuAction == 10) then { // - Buy Action
		MenuAction = -1;
		
		SliderSetPosition[_uiBuyVolumeSlider, 0];

		_currentCost Call ChangePlayerFunds;
		[_cargo, _productId, _buyValue] call marketUpdateProductValue;
		[_market, _productId, -_buyValue] call _procUpdateStockProduct;

		[true] call _procUpdateMarketData;
	};
	
	if (MenuAction == 20) then { // - Sell Action
		MenuAction = -1;

		SliderSetPosition[_uiSellVolumeSlider, 0];

		_currentCost Call ChangePlayerFunds;
		[_cargo, _productId, -_sellValue] call marketUpdateProductValue;
		[_market, _productId, _sellValue] call _procUpdateStockProduct;
		
		[true] call _procUpdateMarketData;
	};
	
	sleep 0.25;
};
