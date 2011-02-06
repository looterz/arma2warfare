#include "profiler.h"
PROFILER_BEGIN("Market_GetContainerItems");

Private ['_container','_items','_storage', '_u', '_product', '_id', '_value', '_u'];

	_container = _this;
	_storage = _container getVariable "marketProductStorage";
	//format["GetContainerItems: %1", _storage] call LogHigh;
	_storage = _storage - [objNull];
	//format["GetContainerItems: %1", _storage] call LogHigh;
	
	_items = [] + marketEmptyContainer;
	
	if !(isNil "_storage" ) then {
		{
			//format["GetContainerItems: %1", _x] call LogHigh;
			_items set [_x select 0, _x select 1]; 
		} forEach _storage; // _items set [_item select 0, _item select 1];
		
	};

PROFILER_END();
_items;
