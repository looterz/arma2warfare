Private ["_paramArray","_side","_structure"];
_side = _this select 0;
_defenseType = _this select 2;
_paramArray = _this select 3;
_pos = _paramArray select 0;
_dir = _paramArray select 1;
_manned = _this select 4;

_index = (Format["WFBE_%1DEFENSENAMES",str _side] Call GetNamespace) find _defenseType;
if (_index != -1) then {
	_script = (Format["WFBE_%1DEFENSESCRIPTS",str _side] Call GetNamespace) select _index;
	[_defenseType,_side,_pos,_dir,_index,_manned] ExecVM (Format["Server\Construction\Construction_%1.sqf",_script]);
};