#include "profiler.h"

private["_object", '_group', '_get', '_alive'];
PROFILER_BEGIN("Server_TrashHideBody");

	_object = _this;
	_group = group _object;
	_get = _group getVariable 'funds';
	if (isNil '_get') then {
		_alive = units _group Call GetLiveUnits;
		if ( (count _alive) == 0) then {
			deleteGroup _group;
		};
	};
	hideBody _object;
	
PROFILER_END();	