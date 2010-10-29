Private["_amount","_funds","_id","_side","_team"];

_amount = _this Select 0;
_side = _this Select 1;
_id = _this Select 2;

Call Compile Format ["%1Funds%2 = %1Funds%2 + _amount; publicVariable '%1Funds%2';",str _side,_id];