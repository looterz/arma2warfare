disableSerialization;

_u = 1;
{lbAdd [17003,Format["[%1] %2",_u,name (leader _x)]];_u = _u + 1} forEach clientTeams;

lbAdd [17004, "Can use RPG/SMAW"];
lbAdd [17004, "Can use Sniper rifle"];
lbAdd [17004, "Can Heal"];
lbAdd [17004, "Can buy Heavy vehicles"];
lbAdd [17004, "Can buy Aircrafts"];
lbAdd [17004, "Can buy Helicopters"];


MenuAction = -1;

while {alive player && dialog} do {

	_isCommander = false;
	if (!isNull(commanderTeam)) then {if (commanderTeam == group player) then {_isCommander = true}};

	if (Side player != sideJoined && !_isCommander) exitWith {closeDialog 0};
	if (!dialog) exitWith {};

		
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
