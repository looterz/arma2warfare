Private["_amount","_funds","_slotIndex","_team"];

_team = _this select 0;
_amount = _this select 1;

_funds = _team Call GetTeamFunds;
_funds = _funds + _amount;
if (_funds < 0) then {_funds = 0};
_team setVariable ["funds",_funds,true];