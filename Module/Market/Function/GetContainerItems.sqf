Private ['_container','_containerItems','_storage', '_u', '_product', '_id', '_value'];

_container = _this select 0;
_storage = _container getVariable "marketProductStorage";

_containerItems = [];
while { (count _containerItems) < (count marketProductCollection) } do {
	_containerItems = _containerItems + [0];
};


if (!(isNil "_storage")) then {

	_u = 0;
	while { _u < (count _storage) } do {
			
		_product = _storage select _u;
		_id = _product select 0;
		_value = _product select 1;
		_containerItems set [_id, _value];
		_u = _u +1;
	};
};

_containerItems;
