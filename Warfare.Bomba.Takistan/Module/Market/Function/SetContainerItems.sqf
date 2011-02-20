#include "profiler.h"
PROFILER_BEGIN("Market_SetContainerItems");

private['_container','_items','_storage','_u','_volume'];

	_container = _this select 0;
	_items = _this select 1;
	
	_storage = [];
	_u = marketTotalProductCount;
	while { _u != 0 } do {
		_u = _u - 1;
		_volume = _items select _u;
		if (_volume > 0) then {
			_storage = _storage + [[_u, _items select _u]];
		};
	};
	_storage = _storage - [objNull];
	_container setVariable ["marketProductStorage", _storage, true];
	_container setVariable ["marketTimeStamp", format["%1", time], true];

PROFILER_END();

