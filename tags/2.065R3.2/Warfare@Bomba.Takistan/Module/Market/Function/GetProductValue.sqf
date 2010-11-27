#include "profiler.h"
PROFILER_BEGIN("Market_GetProductValue");

Private ['_container','_productId', '_incValue', '_items', '_storage', '_u', '_modified', '_product', '_id', '_value','_productValue','_next'  ];

_container = _this select 0;
_productId = _this select 1;

_items =  _container getVariable "marketProductStorage";
if (isNil "_items") then { _items = []; };

_u = count _items;
_productValue = 0;
_next = true;

while { !(_u == 0) && _next} do {
	_u = _u - 1;
	
	_product = _items select _u;
	_id = _product select 0;
	_value = _product select 1;		
	
	if (_productId == _id) then { _productValue = _value; _next = false;};
};

PROFILER_END();
_productValue;