#include "profiler.h"
PROFILER_BEGIN("Common_CreateUnit");

Private ["_dT", "_get", "_built", "_position","_side","_skill","_team","_type","_unit", "_eventHandler", "_varName"];

	_type = _this select 0;
	_team = _this select 1;
	_position = _this select 2;
	_side = _this select 3;

	_get = _type Call GetNamespace;
	_skill = if !(isNil '_get') then {_get select QUERYUNITSKILL} else {'WFBE_AISKILL' Call GetNamespace};
	_unit = _team createUnit [_type,_position,[],_skill,"FORM"];
	
	[NETSEND_MSGID_UPDATESTATS, [_unit, _side, 1]] spawn NetSend_ToServer;
	
	if (_side != resistance) then {

		_unit setSkill _skill;
		if (paramTrackAI) then {
			_unit setVehicleInit Format["[this,%1] ExecVM 'Common\Common_InitUnit.sqf';",_side];
			processInitCommands;
		} else {
			if (isPlayer leader _team) then {[_unit,_side] ExecVM 'Common\Common_InitUnit.sqf'};
		};
	};

	[_unit, _side] spawn SetKilledEventHandler;
	
	if (paramISIS) then {_unit addEventHandler['handleDamage',{_this Call ISIS_Wound}]};
	Format["Common_CreateUnit: A '%1' unit was created and has joined the %2 %3 Team",_type,str _side,_team] call LogHigh;

PROFILER_END();
_unit;