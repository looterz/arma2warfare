Private ['_container','_productId', '_incValue', '_items', '_storage', '_u', '_modified', '_product', '_id', '_value'  ];

_container = _this select 0;
_productId = _this select 1;

_items =  _container getVariable "marketProductStorage";
if (isNil "_items") then { _items = []; };

_u = 0;
while { _u < (count _items)} do {
		
	_product = _items select _u;
	_id = _product select 0;
	_value = _product select 1;		
	
	if (_productId == _id) exitWith { _value; };
	_u = _u +1;
};

_value = 0;
_value;