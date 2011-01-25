#include "profiler.h"
PROFILER_BEGIN("Common_CreateUnit");

Private ["_dT", "_get", "_built", "_position","_side","_skill","_team","_type","_unit", "_eventHandler", "_varName"];

	_type = _this select 0;
	_team = _this select 1;
	_position = _this select 2;
	_side = _this select 3;

	_get = _type Call GetNamespace;
	_skill = if !(isNil '_get') then {_get select QUERYUNITSKILL} else {'WFBE_AISKILL' Call GetNamespace};
	_unit = _team createUnit [_type,_position,[],15,"FORM"];
	[_unit] joinSilent _team;
	_unit setSkill _skill;
	
	_unit setskill ["spotDistance", 1];
	_unit setskill ["spotTime", 1];
	_unit setskill ["endurance", 0.2];
	
	if (_side != resistance) then {
		_unit setVehicleInit Format["[this,%1] ExecVM 'Common\Common_InitUnit.sqf';",_side];
		processInitCommands;
	};

	[_unit, _side] call SetKilledEventHandler;	// here sync call is required, because later it can be rewrited with aiteamkilledevent handler
	[_unit, _side] spawn ManagedUnitAdd;
	
	if (paramISIS) then {_unit addEventHandler['handleDamage',{_this Call ISIS_Wound}]};
	Format["Common_CreateUnit: A '%1' unit was created and has joined the %2 %3 Team",_type,str _side,_team] call LogHigh;

PROFILER_END();
_unit;