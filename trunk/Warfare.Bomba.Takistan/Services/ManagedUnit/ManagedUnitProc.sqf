#include "profiler.h"
PROFILER_BEGIN("Service_ManagedUnitProc");

Private ["_tmp", "_dirt", "_u", "_unit", "_item", "_data"];

	if (count ManagedUnitListOperate > 0) then {
		_tmp = ManagedUnitListOperate;
		ManagedUnitListOperate = [];
		
		_u = count _tmp;
		while { _u != 0 } do {
			_u = _u - 1;
			
			_item = _tmp select _u;
			_unit = _item select 0;
			_data = _item select 1;
		
			ManagedUnitList = ManagedUnitList + [ _unit ];
			ManagedUnitDataList = ManagedUnitDataList + [ _data ];
		};
	};
	
	_dirt = false;
	_u = count ManagedUnitList;
	
	format["ManagedUnitProc: ManagedUnit Count %1", _u] call LogHigh;
	
	while { _u != 0 } do {
		_u = _u - 1;
		
		_unit = ManagedUnitList select _u;
		
		if (isNull _unit) then {
			_data = ManagedUnitDataList select _u;
			_side = _data select 0;
			_man  = _data select 1;
			
			[objNull, _side, -1, _man] spawn UpdateSideStats;
			ManagedUnitDataList set [_u, objNull];
			_dirt = true;
			
			format["ManagedUnitProc: Detected deleted managed unit", _unit] call LogHigh;
		};
		
		if (!alive _unit) then {
		
			_data = ManagedUnitDataList select _u;
			_side = _data select 0;
			_man  = _data select 1;
			[_unit, _side, -1, _man] spawn UpdateSideStats;
		
			_unit spawn TrashObject;
			ManagedUnitList set [_u, objNull];
			ManagedUnitDataList set [_u, objNull];
			_dirt = true;

			format["ManagedUnitProc: %1 is dead", _unit] call LogHigh;
		};
		sleep 0.005;
	};
	
	if (_dirt) then {
		ManagedUnitList = ManagedUnitList - [objNull];
		ManagedUnitDataList = ManagedUnitDataList - [objNull];
	};
	
PROFILER_END();
