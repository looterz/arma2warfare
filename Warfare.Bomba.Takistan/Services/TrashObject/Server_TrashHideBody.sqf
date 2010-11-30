#include "profiler.h"

private["_object", '_group', '_get', '_alive', '_units', '_unit', '_liveUnits', '_u'];
PROFILER_BEGIN("Server_TrashHideBody");

	_object = _this;
	_group = group _object;
	_get = _group getVariable 'funds';
	if (isNil '_get') then {
	
		_liveUnits = false;
		_units = units _group;
		_u = count _units;
		while { _u != 0} do {
			_u = _u - 1;
			
			_unit = _units select _u;
			if ( !isNull _unit && alive(_unit) ) then {
				_liveUnits = true;
				_u = 0;
			};
		};

		if ( !_liveUnits ) then {
			deleteGroup _group;
		};
	};
	hideBody _object;
	
PROFILER_END();	