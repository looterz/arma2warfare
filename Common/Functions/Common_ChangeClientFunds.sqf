Private["_amount","_funds","_id","_side","_team"];

_amount = _this Select 0;
_side = _this Select 1;
_id = _this Select 2;

_team = [_side,_id] Call GetClientTeam;
_funds = _team Call GetTeamFunds;
_funds = _funds + _amount;
if (_funds < 0) then {_funds = 0};
_team setVariable ["funds",_funds,true];