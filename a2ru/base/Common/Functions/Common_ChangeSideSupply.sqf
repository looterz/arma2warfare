Private ['_amount','_change','_currentSupply','_side'];

_side = _this select 0;
_amount = _this select 1;

_currentSupply = (_side) Call GetSideSupply;
_change = _currentSupply + _amount;
if (_change < 0) then {_change = _currentSupply - _amount};

WF_Logic setVariable [Format["%1Supplies",_side],_change,true];