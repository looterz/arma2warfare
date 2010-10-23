private['_factory', '_unit', '_unitPrice', '_u', '_found', '_unitData', '_unitData1', '_type', '_products', '_marketStock', '_marketPrices', '_reqProduct', '_reqProductId', '_reqProductValue', '_stockValue', '_cost', '_buyValue', '_price', '_buy', '_name'];

_unit = _this;

_u = 0;
_found = false;
_unitData = nil;

while { _u < count marketBuildUnitProductRequire && !_found } do {

	_unitData1 = marketBuildUnitProductRequire select _u;
	_type = _unitData1 select 0;

	if (_unit isKindOf _type) then {
		_unitData = _unitData1;
		_found = true;
	};	
	_u = _u+1;
};
	
_unitData;