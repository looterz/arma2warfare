private['_market','_productid','_uiproductlist','_txt','_u','_buyvalue','_uibuyvolumeslider','_uisellvolumeslider','_graycolor','_sellvalue','_marketstock','_marketprices','_selectedrowid','_cargofreespacesu','_nearmarkets','_currentcost','_maxbuyvalue','_productlistids','_newprice','_force','_cargofreeactualsu','_uinearmarketdropdown','_selectedmarketid','_lasttimestamp','_fnlocalizeunit','_cargoitems','_cargosu','_uibuyvolumebutton','_uisellvolumebutton','_ismhq','_isfactory','_currentsupply','_iscommander','_incvalue','_procupdatemarketdata','_timestamp','_showitem','_currentfunds','_cargovalue','_costsell','_costbuy','_cargounittype','_uibuyvolumetext','_uisellvolumetext','_uicashtext','_lastsv','_fnupdateplayercargoinfo','_procupdatestockproduct','_countnearmarkets','_id','_d','_unitformat','_freecargoactual','_product','_cargomaxweightsu','_display','_uicosttext','_uifreecargo','_procreadstockdata','_ishq','_procupdatemarketslist','_procupdateproductlist','_greencolor','_txtstockvolume','_txtcargovolume','_lastselectedproductid','_color','_uicashtextlabel','_uititle','_istown','_hq','_mycargo','_whitecolor','_productweightperunit'];

disableSerialization;

_cargo = player;
_cargoMaxWeightSU = objNull;
_cargoFreeSpaceSU = objNull;
_cargoUnitType = objNull;
_cargoItems = objNull;
_cargoSU = objNull;

_display = _this select 0;

lnbAddRow  [17004, [localize "STR_WF_TradeProduct", localize "STR_WF_TradeUnit", localize "STR_WF_TradeSell", localize "STR_WF_TradeBuy", localize "STR_WF_TradeCargo", localize "STR_WF_TradeStock"] ];
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

_productListIds = [];

_nearMarkets = [];
_market = objNull;
_marketStock = [];
_marketPrices = [];
_productId = 0;
_selectedRowId = 0;

_fnLocalizeUnit = {
private["_localized"];
	_localized = "";
	switch (_this) do
	{
		case "t": { _localized = localize "STR_WF_TradeUnitTonn"; };
		case "kg": { _localized = localize "STR_WF_TradeUnitKilogramm"; };
		case "g": { _localized = localize "STR_WF_TradeUnitGramm"; };
		case "piece": { _localized = localize "STR_WF_TradeUnitPiece"; };
	};
	_localized;
};

_fnUpdatePlayerCargoInfo = {
private['_cargoInfo'];

	_cargoInfo = (vehicle player) call marketGetCargoInfo;
	_cargo = _cargoInfo select 0;
	_cargoItems = _cargoInfo select 1;
	_cargoMaxWeightSU = _cargoInfo select 2;
	_cargoFreeSpaceSU = _cargoInfo select 3;
	_cargoSU = _cargoInfo select 4;
	_cargoUnitType = _cargoInfo select 5;	
};
_procReadStockData = {

	_market = if (_selectedMarketId >= 0) then { _nearMarkets select _selectedMarketId } else { objNull };
		
	_marketStock = _market call marketGetMarketProducts;
	_marketPrices = _market call marketGetMarketPrices;

	_isTown = if (_market in towns) then { true } else { false };
	_isMHQ = if (((sideJoinedText) Call GetSideHQ) == _market) then { true } else { false };
	_isFactory = if (_market in ((sideJoinedText) Call GetSideStructures)) then { true} else { false };
	
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
	_hq = (sideJoinedText) Call GetSideHQ;

	_market = _this select 0;
	_productId  = _this select 1;
	_incValue  = _this select 2;
	
	if (!alive _market || isNull _market) exitWith {};
	
	_isFactory = if (_market in ((sideJoinedText) Call GetSideStructures)) then { true} else { false };
	_isHq = if (_market == (sideJoinedText) Call GetSideHQ) then { true } else { false };

	if (_productId == marketProductIdSupply && (_isHq  || (_isFactory && _incValue > 0))  ) then {

		_sv = WF_Logic getVariable Format ["%1Supplies",sideJoinedText];
		_sv = _sv  + (_incValue * 1000);
		
		if (_sv < 0) then { _sv = 0; };
		WF_Logic setVariable [Format ["%1Supplies",sideJoinedText], _sv, true];

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
		
		[] call _fnUpdatePlayerCargoInfo;
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
	_productListIds = [];
	
	lnbClear _uiProductList;
	_i = 0;
	{
		_productName = _x select 0;
		_productUnit = _x select 1;
		_productCost = _x select 2;
		_productWeightPerUnit = _x select 3;
		
		_d = _productName Call GetNamespace;
		if !(isNil '_d') then {
			_productName = _d select QUERYUNITLABEL;
			_txt = toArray(_productName);
			_u = 26;
			while { _u < (count _txt)} do {  _txt set [_u, objNull]; _u = _u + 1; }; // trim name to 20 chars
			_txt = _txt - [objNull];			
			_productName = toString(_txt);
		};
		
		_productSU = _x call marketGetSU;
		
		_cargo = _cargoItems select _i;
		_stockValue = floor(_marketStock select _i);
		_price = _marketPrices select _i;
		
		_sell = _price select 0;
		_buy = _price select 1;	
		
		_txtSell = "";
		_txtBuy  = "";
		
		_showItem = false;
		if (_sell != -1 && _cargo > 0) then { _showItem = true; _txtSell = format["$%1", _sell] };
		if (_buy != -1 && _stockValue > 0) then { _showItem = true; _txtBuy  = format["$%1", _buy]  };

		                               
		if (_showItem) then {
			_unitFormat = if (_productUnit == "piece") then { "%1" } else { "%1%2" };
			_productListIds = _productListIds + [_i];
			
			_productUnit = (_productUnit call _fnLocalizeUnit);
			_txtStockVolume = if (_stockValue > 0) then { format[_unitFormat, _stockValue, _productUnit] } else { "" };
			_txtCargoVolume = if (_cargo > 0) then { format[_unitFormat, _cargo, _productUnit] } else { "" };

			lnbAddRow [_uiProductList, [_productName, _productUnit, _txtSell, _txtBuy, _txtCargoVolume, _txtStockVolume] ];
		};
		
		if ((_productSU > _cargoFreeSpaceSU && _cargo == 0) || (_stockValue == 0 && _cargo==0) ) then {
			lnbSetColor [_uiProductList, [_i, 0], _grayColor];
			lnbSetColor [_uiProductList, [_i, 2], _grayColor];
			lnbSetColor [_uiProductList, [_i, 3], _grayColor];
			lnbSetColor [_uiProductList, [_i, 5], _grayColor];
		};
		
		lnbSetColor [_uiProductList, [_i, 1], _grayColor];
		
		if (_sell == -1 && _buy == -1) then { 
			lnbSetColor [_uiProductList, [_i, 4], _grayColor];
			lnbSetColor [_uiProductList, [_i, 5], _grayColor];
		};
		
		lnbSetColor [_uiProductList, [_i, 4], (if (_cargo != 0) then { _greenColor } else {_grayColor}) ];
		_i = _i+1;
	} forEach marketProductCollection;
	
	lnbSetCurSelRow [_uiProductList, _selectedRowId];
};

MenuAction = -1;

SliderSetPosition[_uiBuyVolumeSlider, 0];
SliderSetPosition[_uiSellVolumeSlider, 0];

ctrlEnable [_uiBuyVolumeButton, false];
ctrlEnable [_uiBuyVolumeSlider, false];
ctrlEnable [_uiSellVolumeButton, false];
ctrlEnable [_uiSellVolumeSlider, false];
		
while {alive (vehicle player) && dialog} do {
	sleep 0.100;

	if (Side player != sideJoined && !_isCommander) exitWith {closeDialog 0};
	if (!dialog) exitWith {};

	[] call _fnUpdatePlayerCargoInfo;
	[] call _procUpdateMarketsList;
	[] call _procUpdateMarketData;
	

	_selectedRowId = lnbCurSelRow _uiProductList;
	if (_selectedRowId == -1) then {
		_selectedRowId = 0;
		lnbSetCurSelRow [_uiProductList, _selectedRowId];
	};
	_currentFunds = Call GetPlayerfunds;
	
	_cargoFreeActualSU = _cargoFreeSpaceSU;	
	_freeCargoActual = (floor(10*_cargoFreeSpaceSU / _cargoSU)) / 10;
	
	_buyValue = 0;
	_sellValue = 0;
	_currentCost = 0;
	if (_selectedRowId < count _productListIds) then {
	
		_productId = _productListIds select _selectedRowId;
		_product = marketProductCollection select _productId;
		_price = _marketPrices select _productId;
		_productSU = _product call marketGetSU;
		
		_productUnit = _product select 1;
		
		_cargoValue = _cargoItems select _productId;
		_stockValue = _marketStock select _productId;

		_sellValue = floor (SliderPosition _uiSellVolumeSlider);
		_buyValue = floor (SliderPosition _uiBuyVolumeSlider);
		
		if (_sellValue < 0) then { _sellValue = 0; };
		if (_buyValue < 0)  then { _buyValue = 0; };
		
		_costSell = _price select 0;
		_costBuy  = _price select 1;
		
		_cargoFreeActualSU = _cargoFreeActualSU + _sellValue *  _productSU;
		_cargoFreeActualSU = _cargoFreeActualSU - _buyValue *  _productSU;
		_freeCargoActual = (floor(10*_cargoFreeActualSU / _cargoSU)) / 10;
		
		_maxBuyValue = _stockValue;
		if ( (_stockValue * _productSU) > _cargoFreeSpaceSU) then { _maxBuyValue = floor(_cargoFreeSpaceSU / _productSU); };

		if (_buyValue > _maxBuyValue) then { _buyValue = _maxBuyValue; };
		_currentCost =  -(_buyValue*_costBuy) + (_sellValue*_costSell);
	
		ctrlSetText [_uiBuyVolumeText, format [localize "STR_WF_TradeBuyValue", _buyValue, (_productUnit call _fnLocalizeUnit)]];	
		ctrlSetText [_uiSellVolumeText, format [localize "STR_WF_TradeSellValue", _sellValue, (_productUnit call _fnLocalizeUnit)]];	

		SliderSetRange[_uiBuyVolumeSlider, 0,  _maxBuyValue];
		SliderSetRange[_uiSellVolumeSlider, 0, _cargoValue];

		if (_lastSelectedProductId != _productId) then {
			SliderSetPosition[_uiBuyVolumeSlider, 0];
			SliderSetPosition[_uiSellVolumeSlider, 0];	
			
			_lastSelectedProductId = _productId;
		};
		ctrlEnable [_uiBuyVolumeButton, ((!isNull _market) && _stockValue != 0 && (_currentFunds + _currentCost) >= 0 && _maxBuyValue != 0 && _costBuy != -1)];
		ctrlEnable [_uiBuyVolumeSlider, ((!isNull _market) && _stockValue != 0 && _maxBuyValue != 0 && _costBuy != -1)];
		ctrlEnable [_uiSellVolumeButton, ((!isNull _market) && _cargoValue != 0 && _costSell != -1)];
		ctrlEnable [_uiSellVolumeSlider, ((!isNull _market) && _cargoValue != 0 && _costSell != -1)];	
		
		ctrlSetText [_uiCostText, format [localize "STR_WF_TradeCost", abs(_currentCost)]];	
	} else {
	
		ctrlSetText [_uiBuyVolumeText, format [localize "STR_WF_TradeBuyValue", "", ""]];	
		ctrlSetText [_uiSellVolumeText, format [localize "STR_WF_TradeSellValue", "", ""]];	

		SliderSetPosition[_uiBuyVolumeSlider, 0];
		SliderSetPosition[_uiSellVolumeSlider, 0];

		ctrlEnable [_uiBuyVolumeButton, false];
		ctrlEnable [_uiBuyVolumeSlider, false];
		ctrlEnable [_uiSellVolumeButton, false];
		ctrlEnable [_uiSellVolumeSlider, false];		
	};
	
	
	ctrlSetText [_uiFreeCargo, format [localize "STR_WF_TradeFreeCargo", _freeCargoActual, (_cargoUnitType call _fnLocalizeUnit)]];	
	ctrlSetText [_uiCashText, format [localize "STR_WF_TradeCash", _currentFunds]];	

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
};
