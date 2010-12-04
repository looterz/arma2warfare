disableSerialization;

MenuAction = -1;
_tcr = 'WFBE_TOWNCAPTURERANGE' Call GetNamespace;

_exchangeRate = 5;
_deltaRate = 5;

_townDepotNear = 0;
_nearestTownDepots = nearestObjects [player, WFDEPOT,('WFBE_TOWNPURCHASERANGE' Call GetNamespace)];
_nearTown = if (count _nearestTownDepots > 0) then {_nearestTownDepots select 0} else {objNull};
if (!isNull _nearTown) then {
	_sideID = _nearTown getVariable "sideID";
	if !(isNil "_sideID") then {
	
		_supplyValue = _nearTown getVariable "supplyValue";
		_maxSV = _nearTown getVariable "maxSupplyValue";
	
		if (_sideID == sideID) then {

			if (player distance _nearTown < _tcr) then {
				_deltaRate = ((120 / _maxSV) + (1 - (_supplyValue / _maxSV)));				
				_townDepotNear = 1;
			};
		}
	};
};

exchangeNearTown = _nearTown;

_exchangeRateSell = (ceil ((_exchangeRate -_deltaRate) *10)) / 10;
_exchangeRateBuy = (ceil ((_exchangeRate + 1.5*_deltaRate) *10)) / 10;

if (_exchangeRateSell < 0) then { _exchangeRateSell = 0.1; };
if (_exchangeRateBuy > 100) then { _exchangeRateSell = 100; };


ctrlSetText [17002, Format [localize "STR_WF_SellSupplyExchangeRate",_exchangeRateSell]];
ctrlSetText [17003, Format [localize "STR_WF_BuySupplyExchangeRate",_exchangeRateBuy]];

SliderSetRange[17005,0, 150];
SliderSetPosition[17005, 75];

while {alive player && dialog} do {

	_isCommander = false;
	if (!isNull(commanderTeam)) then {if (commanderTeam == group player) then {_isCommander = true}};

	if (Side player != sideJoined && !_isCommander) exitWith {closeDialog 0};
	if (!dialog) exitWith {};

	_currentSupply = WF_Logic getVariable Format ["%1Supplies",sideJoinedText];
	_currentFunds = Call GetPlayerfunds;

	ctrlSetText [17004, Format [localize "STR_WF_BuySellSupplyStatus",_currentFunds, _currentSupply]];	
	_exchangeSupplyAmount = (ceil (SliderPosition 17005))*100;

	_buyMoney = _exchangeSupplyAmount * _exchangeRateBuy;
	_sellMoney = _exchangeSupplyAmount * _exchangeRateSell;
	
	_canBuy = (_isCommander && _townDepotNear == 1 && _buyMoney <= _currentFunds); 
	_canSell = (_isCommander && _townDepotNear == 1 && _isCommander && _exchangeSupplyAmount  <= _currentSupply);

	ctrlEnable [17006, _canBuy];
	ctrlEnable [17007, _canSell];
	ctrlEnable [17005, (_townDepotNear == 1)];
	
	_buyText = Format [localize "STR_WF_BuySupplyOperation",_exchangeSupplyAmount, _buyMoney];
	_sellText = Format [localize "STR_WF_SellSupplyOperation",_exchangeSupplyAmount, _sellMoney];

	_buyInfo = Format ["%1 | %2", _buyText, _sellText];
	
	if (!_canBuy) then { _buyInfo = _sellText; };
	if (!_canSell) then { _buyInfo = _buyText; };
	
	if (_townDepotNear == 0) then { _buyInfo = Format [localize "STR_WF_BuySellSupplyInform"]; };
	ctrlSetText [17008, _buyInfo];

		
	if (MenuAction == 1) then { // - Buy Action
		MenuAction = -1;
		_currentSupply = _currentSupply + _exchangeSupplyAmount;
		WF_Logic setVariable [Format ["%1Supplies",sideJoinedText], _currentSupply, true];
		
		-_buyMoney Call ChangePlayerFunds;
	};
	
	if (MenuAction == 2) then { // - Sell Action
		MenuAction = -1;
		_currentSupply = _currentSupply - _exchangeSupplyAmount;
		WF_Logic setVariable [Format ["%1Supplies",sideJoinedText], _currentSupply, true];
		
		_sellMoney Call ChangePlayerFunds;	
	};
	
	sleep 0.25;
};
