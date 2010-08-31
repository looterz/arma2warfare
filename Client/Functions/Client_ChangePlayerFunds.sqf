Private["_funds"];

_funds = Call GetPlayerFunds;

if (_this < 0) then { _this = _this / 10; };
if (_this > 0) then { _this = _this * 10; };

_funds = _funds + _this;
if (_funds < 0) then {_funds = 0};
clientTeam setVariable ["funds",_funds,true];