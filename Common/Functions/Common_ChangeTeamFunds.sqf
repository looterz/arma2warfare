Private["_amount","_index","_team"];

_team = _this select 0;
_amount = _this select 1;

_index = _team Call GetClientIDFromTeam;
if (_index == 0) exitWith {};

Call Compile Format ["%1Funds%2 = %1Funds%2 + _amount; publicVariable '%1Funds%2';",str (side _team),_index];