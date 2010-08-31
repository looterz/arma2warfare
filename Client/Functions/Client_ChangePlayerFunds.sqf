Private["_funds"];

_funds = Call GetPlayerFunds;
_funds = _funds + _this;
if (_funds < 0) then {_funds = 0};
clientTeam setVariable ["funds",_funds,true];