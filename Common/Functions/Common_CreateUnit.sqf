Private ["_position","_side","_team","_type","_unit"];
_type = _this select 0;
_team = _this select 1;
_position = _this select 2;
_side = _this select 3;

_unit = _team CreateUnit [_type,_position,[],'WFBE_AISKILL' Call GetNamespace,"FORM"];
if (_side != resistance) then {
	if (trackAI) then {_unit SetVehicleInit Format["[this,%1] ExecVM 'Common\Common_InitUnit.sqf';",_side];ProcessInitCommands};
	if (!trackAI) then {if (isPlayer leader _team) then {Call Compile Format ["[_unit,%1] ExecVM 'Common\Common_InitUnit.sqf';",_side]}};
	Call Compile Format ["_unit addEventHandler ['Killed',{[_this select 0,_this select 1,%1] Spawn UnitKilled}];",_side];
} else {
	//--- Note To be optimized, 1.03 BIS BUG, cannot add resistance side via call compile format.
	_unit addEventHandler ["Killed",{[_this select 0,_this select 1,resistance] Spawn UnitKilled}];
};

if (ISIS) then {_unit addEventHandler['handleDamage',{_this Call ISIS_Wound}]};

_unit