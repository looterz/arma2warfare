Private["_commanderTeam","_income","_incomeCoef","_incomeSystem","_side","_sideID"];

_side = _this;
_sideID = _side Call GetSideID;
_income = 0;

_incomeSystem = 'WFBE_INCOMESYSTEM' Call GetNamespace;
_incomeCoef = 0;
if (_incomeSystem == 3) then {_incomeCoef = 'WFBE_INC_COEFFICIENT' Call GetNamespace};

{
	if ((_x getVariable "sideID") == _sideID) then	{
		_income = _income + (_x getVariable "supplyValue");
	};
} forEach towns;

switch (_incomeSystem) do {
	case 2: {_income = round(_income /2)};
	case 3: {
		_divisor = 'WFBE_INC_DIVIDE_COM' Call GetNamespace;
		_commPerc = Call Compile Format ["%1CommanderPercent",_side];
		_sidePerc = (100 - (_commPerc / _divisor)) / 100;
		_ply_income = round(_income * _sidePerc);
	
		_commanderTeam = (_side) Call GetCommanderTeam;
		if (isNull _commanderTeam) then {_commanderTeam = grpNull};
		if (_commanderTeam != group player) then {
			_income = _ply_income;
		} else {
			_income = _ply_income + round(maxplayers * _ply_income * (1 - _sidePerc ));
		};
	};
};

_income