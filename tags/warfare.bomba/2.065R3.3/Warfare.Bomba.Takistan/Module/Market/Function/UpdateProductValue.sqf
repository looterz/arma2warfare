#include "profiler.h"
PROFILER_BEGIN("Market_UpdateProductValue");

Private ['_container','_productId', '_incValue', '_items', '_storage', '_u', '_modified', '_product', '_id', '_value'  ];

	_incValue = _this select 2;

	if (_incValue != 0) then {

		_container = _this select 0;
		_productId = _this select 1;
	
		_storage = _container call marketGetContainerItems;
		_value = (_storage select _productId) + _incValue;
		
		_storage set [_productId, _value];
		
		_container setVariable ["marketProductStorage", _storage, true];
		_container setVariable ["marketTimeStamp", format["%1", time], true];
	};

PROFILER_END();