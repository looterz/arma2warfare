Private ['_unitType','_su'];

//-- return standart unit;
_unitType = _this select 0;
_su = 0;

if (_unitType == "t") then  { _su = 1000; };
if (_unitType == "kg") then { _su = 1; };
if (_unitType == "g") then  { _su = 0.001; };

_su;