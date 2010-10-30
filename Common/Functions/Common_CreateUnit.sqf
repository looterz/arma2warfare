Private ["_get","_position","_side","_skill","_team","_type","_unit"];
_type = _this select 0;
_team = _this select 1;
_position = _this select 2;
_side = _this select 3;

_get = _type Call GetNamespace;
_skill = if !(isNil '_get') then {_get select QUERYUNITSKILL} else {'WFBE_AISKILL' Call GetNamespace};
_unit = _team createUnit [_type,_position,[],_skill,"FORM"];
if (_side != resistance) then {
	if (paramTrackAI) then {
		_unit setVehicleInit Format["[this,%1] ExecVM 'Common\Common_InitUnit.sqf';",_side];
		processInitCommands;
	} else {
		if (isPlayer leader _team) then {[_unit,_side] ExecVM 'Common\Common_InitUnit.sqf'};
	};
	Call Compile Format ["_unit addEventHandler ['Killed',{[_this select 0,_this select 1,%1] Spawn UnitKilled}];",_side];
} else {
	//--- Note To be optimized, 1.03 BIS BUG, cannot add resistance side via call compile format.
	_unit addEventHandler ['Killed',{[_this select 0,_this select 1,resistance] Spawn UnitKilled}];
};

if (paramISIS) then {_unit addEventHandler['handleDamage',{_this Call ISIS_Wound}]};

Format["Common_CreateUnit: A '%1' unit was created and has joined the %2 %3 Team",_type,str _side,_team] call LogInform;

_unit