Private["_camps","_side","_sideID","_total","_town"];

_town = _this Select 0;
_side = _this Select 1;

_sideID = _side Call GetSideID;

_camps = _town getVariable "camps";
_total = 0;

{if ((_x getVariable "sideID") == _sideID) then {_total = _total + 1}} ForEach _camps;

_total