#include "profiler.h"
PROFILER_BEGIN("Market_GetContainerItems");

Private ['_container','_containerItems','_storage', '_u', '_product', '_id', '_value', '_u'];

	_container = _this;
	_containerItems = _container getVariable "marketProductStorage";

	if ( isNil "_storage" ) then {
		_containerItems = [] + marketEmptyContainer;
		_container setVariable["marketProductStorage", _containerItems, true]; 
	};

PROFILER_END();
_containerItems;
