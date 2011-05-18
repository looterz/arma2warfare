#include "profiler.h"
PROFILER_BEGIN("Service_ManagedUnitAdd");

Private ["_unit", "_side", "_man"];

	if (!isServer) exitWith {
		[NETSEND_MSGID_MANAGEDUNITADD, _this] spawn NetSend_ToServer;
		PROFILER_END();
	};
	
	_unit = _this select 0;
	_side = _this select 1;
	
	if (isNil "_unit") exitWith { 
		"Try add as managed nil object" call LogUnexpected;
		PROFILER_END(); 
	};
	if (isNull _unit)  exitWith { 
		"Try add as managed null object" call LogUnexpected;
		PROFILER_END(); 
	};	
	

	_man = if (_unit isKindOf "Man") then { true } else { false };
	
	if (!_man) then {
		_unit spawn HandleEmptyVehicle;		// register track empty vehicles
	};
	[_unit, _side, 1] spawn UpdateSideStats;	
	
	waitUntil { !isNil "ManagedUnitListOperate" };
	ManagedUnitListOperate = ManagedUnitListOperate + [ [_unit, [_side, _man] ] ];
	
	format["ManagedUnitAdd: %1", _this] call LogHigh;
	
PROFILER_END();