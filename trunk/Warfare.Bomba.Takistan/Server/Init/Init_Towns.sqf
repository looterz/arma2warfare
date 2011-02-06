#include "profiler.h"
PROFILER_BEGIN("Init_Towns");

private['_initied','_towns','_neartownsw','_near','_camps','_neartownse','_require','_wstart','_defenses','_town','_estart','_limit','_half','_total'];

waitUntil { !isNil "initJIP" };
waitUntil {townInit};

//--- Special Towns mode.
switch ('WFBE_TOWNSTARTINGMODE' Call GetNamespace) do {
	//--- 50-50.
	case 1: {
		_half = round(count towns)/2;
		_wStart = westStartingLocation;
		_eStart = eastStartingLocation;

		_nearTownsW = [];
		_nearTownsE = [];
		
		_near = [_wStart,towns] Call SortByDistance;
		if (count _near > 0) then {
			for [{_x = 0},{_x < _half},{_x = _x + 1}] do {_nearTownsW = _nearTownsW + [_near select _x]};
		};
		
		_nearTownsE = (towns - _nearTownsW);
		
		{
			_x setVariable ['sideID',WESTID,true];
			_camps = _x getVariable "camps";
			{_x setVariable ['sideID',WESTID,true]} forEach _camps;
		} forEach _nearTownsW;
		{
			_x setVariable ['sideID',EASTID,true];
			_camps = _x getVariable "camps";
			{_x setVariable ['sideID',EASTID,true]} forEach _camps;
		} forEach _nearTownsE;
	};
	
	//--- Nearby Towns.
	case 2: {
		_total = count towns;
		_wStart = westStartingLocation;
		_eStart = eastStartingLocation;
		_limit = floor(_total / 6);
		_nearTownsW = [];
		_nearTownsE = [];
		
		_near = [_wStart,towns] Call SortByDistance;
		if (count _near > 0) then {
			for [{_x = 0},{_x < _limit},{_x = _x + 1}] do {_nearTownsW = _nearTownsW + [_near select _x]};
		};
		
		_near = [_eStart,(towns - _nearTownsW)] Call SortByDistance;
		if (count _near > 0) then {
			for [{_x = 0},{_x < _limit},{_x = _x + 1}] do {_nearTownsE = _nearTownsE + [_near select _x]};
		};
		
		{
			_x setVariable ['sideID',WESTID,true];
			_camps = _x getVariable "camps";
			{_x setVariable ['sideID',WESTID,true]} forEach _camps;
			_defenses = _x nearEntities['WFBE_RESISTANCEDEFENSENAMES' Call GetNamespace,_x getVariable "range"];
			{deleteVehicle _x} forEach _defenses;
		} forEach _nearTownsW;
		{
			_x setVariable ['sideID',EASTID,true];
			_camps = _x getVariable "camps";
			{_x setVariable ['sideID',EASTID,true]} forEach _camps;
			_defenses = _x nearEntities['WFBE_RESISTANCEDEFENSENAMES' Call GetNamespace,_x getVariable "range"];
			{deleteVehicle _x} forEach _defenses;
		} forEach _nearTownsE;
	};
};

//--- Resistance Patrols.
if (('WFBE_TOWNSTARTINGMODE' Call GetNamespace) != 1 && ('WFBE_RESPATROL' Call GetNamespace > 0)) then {
	_require = if (('WFBE_RESPATROL' Call GetNamespace) > count towns) then {count towns} else {'WFBE_RESPATROL' Call GetNamespace};
	_initied = 0;
	_towns = towns;
	
	//--- Don't bother with the randomizer if the amount set in RESPATROLMAX is >= count towns.
	while {_initied < _require} do {
		if (_require == count towns) then {
			[_towns select _initied] ExecFSM "Server\FSM\respatrol.fsm";
			_initied = _initied + 1;
		} else {
			if (random 2 > 1) then {
				_town = [_towns select (round(random((count _towns)-1)))] ExecFSM "Server\FSM\respatrol.fsm";
				_towns = _towns - [_town];
				_initied = _initied + 1;
			};
		};
	};
};

//--- Resistance Strikers.
if (('WFBE_TOWNSTARTINGMODE' Call GetNamespace) != 1 && ('WFBE_RESSTRIKER' Call GetNamespace) > 0) then {
	_require = if (('WFBE_RESSTRIKER' Call GetNamespace) > count towns) then {count towns} else {'WFBE_RESSTRIKER' Call GetNamespace};
	_initied = 0;
	_towns = towns;

	//--- Don't bother with the randomizer if the amount set in RESSTRIKERMAX is >= count towns.
	while {_initied < _require} do {
		if (_require == count towns) then {
			[_towns select _initied] ExecFSM "Server\FSM\resstriker.fsm";
			_initied = _initied + 1;
		} else {
			if (random 2 > 1) then {
				_town = [_towns select (round(random((count _towns)-1)))] ExecFSM "Server\FSM\resstriker.fsm";
				_towns = _towns - [_town];
				_initied = _initied + 1;
			};
		};
	};
};

"Init_Towns (S): Towns starting mode initialization - [Done]"  call LogMedium;
PROFILER_END();