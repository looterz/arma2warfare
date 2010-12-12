#include "profiler.h"
PROFILER_BEGIN("Service_ManagedUnitProc");

Private ["_tmp", "_dirt", "_u", "_unit"];

	if (count ManagedUnitListOperate > 0) then {
		_tmp = ManagedUnitListOperate;
		ManagedUnitListOperate = [];
		ManagedUnitList = ManagedUnitList + _tmp;
	};
	
	_dirt = false;
	_u = count ManagedUnitList;
	
	format["ManagedUnitProc: ManagedUnit Count %1", _u] call LogHigh;
	
	while { _u != 0 } do {
		_u = _u - 1;
		
		_unit = ManagedUnitList select _u;
		if (!alive _unit) then {
		
			format["ManagedUnitProc: %1 is dead", _unit] call LogHigh;
			_unit spawn TrashObject;
			ManagedUnitList set [_u, objNull];
			_dirt = true;
		};
		sleep 0.005;
	};
	
	if (_dirt) then {
		ManagedUnitList = ManagedUnitList - [objNull];
	};
	
PROFILER_END();
