Private["_side","_sideValue","_stats"];

_sideValue = _this select 0;
_blist = _this select 1;
_stats = _this select 2;

gameOver = true;
_side = east;
if (_sideValue == WESTID) then {_side = west};

[_side, _blist, _stats] ExecVM "Client\Client_EndGame.sqf";