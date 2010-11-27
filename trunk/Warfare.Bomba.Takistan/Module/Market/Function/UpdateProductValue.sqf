#include "profiler.h"
PROFILER_BEGIN("Market_UpdateProductValue");

Private ['_container','_productId', '_incValue', '_items', '_storage', '_u', '_modified', '_product', '_id', '_value'  ];

_container = _this select 0;
_productId = _this select 1;
_incValue = _this select 2;

_items =  _container getVariable "marketProductStorage";
if (isNil "_items") then { _items = []; };

_storage = [];
_u = count _items;
_modified = false;
while { !(_u == 0) } do {
	_u = _u - 1;
		
	_product = _items select _u;
	_id = _product select 0;
	_value = _product select 1;		
	
	if (_productId == _id) then {
		_value = _value + _incValue;
		_modified = true;
	};
	
	if (_value > 0) then {
		_storage = [ [_id, _value] ] + _storage;
	};
};

if (!_modified && _incValue > 0) then {
	_storage = _storage + [ [_productId, _incValue] ];
};

_container setVariable ["marketProductStorage", _storage, true];
_container setVariable ["marketTimeStamp", format["%1", time], true];

PROFILER_END();