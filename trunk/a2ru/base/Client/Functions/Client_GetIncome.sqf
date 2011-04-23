Private["_commanderTeam","_income","_incomeCoef","_incomeSystem","_side","_sideID"];

_side = _this;
_sideID = _side Call GetSideID;
_income = 0;

_incomeSystem = 'WFBE_INCOMESYSTEM' Call GetNamespace;
_incomeCoef = 0;
if (_incomeSystem == 3) then {_incomeCoef = 'WFBE_INC_COEFFICIENT' Call GetNamespace};

{
	if ((_x getVariable "sideID") == _sideID) then	{
		switch (_incomeSystem) do {
			case 1: {_income = _income + (_x getVariable "supplyValue")};
			case 3: {_income = _income + ((_x getVariable "supplyValue")*_incomeCoef)};
		};
	};
} forEach towns;

switch (_incomeSystem) do {
	case 2: {_income = round(_income /2)};
	case 3: {
		_commanderTeam = (_side) Call GetCommanderTeam;
		if (isNull _commanderTeam) then {_commanderTeam = grpNull};
		if (_commanderTeam != group player) then {
			_income = round(_income * (((100 - (Call Compile Format ["%1CommanderPercent",_side]))/100)/maxPlayers));
		} else {
			_income = round((_income * ((Call Compile Format ["%1CommanderPercent",_side])/100)) / ('WFBE_INC_DIVIDE_COM' Call GetNamespace));
		};
	};
};

_income