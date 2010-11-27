#include "profiler.h"
PROFILER_BEGIN("Market_GetContainerItems");

Private ['_container','_containerItems','_storage', '_u', '_product', '_id', '_value', '_u'];

_container = _this select 0;
_storage = _container getVariable "marketProductStorage";

_containerItems = [];
_u = count marketProductCollection;
while { !(_u == 0) } do {
	_u = _u - 1;
	_containerItems = _containerItems + [0];
};

if (!(isNil "_storage")) then {

	_u = count _storage;
	while { !(_u == 0) } do {
		_u = _u - 1;
			
		_product = _storage select _u;
		_id = _product select 0;
		_value = _product select 1;
		_containerItems set [_id, _value];
	};
};

PROFILER_END();
_containerItems;
