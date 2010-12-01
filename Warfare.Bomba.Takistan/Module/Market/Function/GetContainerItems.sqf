#include "profiler.h"
PROFILER_BEGIN("Market_GetContainerItems");

Private ['_container','_items','_storage', '_u', '_product', '_id', '_value', '_u'];

	_container = _this;
	_items = _container getVariable "marketProductStorage";

	if ( isNil "_items" ) then {
		_items = [] + marketEmptyContainer;
		_container setVariable["marketProductStorage", _items, true]; 
	};

PROFILER_END();
_items;
