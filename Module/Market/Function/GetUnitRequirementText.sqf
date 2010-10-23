private['_factory', '_unit', '_requirementText', '_u', '_found', '_unitData', '_unitData1', '_type', '_products', '_marketStock', '_marketPrices', '_reqProduct', '_reqProductId', '_reqProductValue', '_stockValue', '_cost', '_buyValue', '_price', '_buy', '_name'];

_factory = _this select 0;
_unit = _this select 1;

_unitData = _unit call marketGetUnitRequiredProducts;
_requirementText = "";
	
format['get unit requirment text: %1', _unit] call Logger;	
	
if (isNil '_unitData') exitWith { 
	format['empty requirmenttext=%1', _requirementText] call Logger;
	_requirementText; 
};

_products = [_factory] call marketGetMarketProducts;
_marketStock = _products select 0;
_marketPrices = _products select 1;

format['_unitData=%1', _unitData] call Logger;

_found = 0;
_u = 1;
while { _u < count _unitData  } do {

	_reqProduct = _unitData select _u;
	_reqProductId = _reqProduct select 0;
	_reqProductValue = _reqProduct select 1;
	_stockValue = _marketStock select _reqProductId;

	
	if (_stockValue < _reqProductValue) then {
		_name = (marketProductCollection select _reqProductId) select 0;
		_unit = (marketProductCollection select _reqProductId) select 1;
		
		if (_found > 0) then { _requirementText = _requirementText + ", "; };
		
		_text = format["%1: %3%2", _name, _unit, _reqProductValue, _stockValue];
		_requirementText = _requirementText + _text;	
		_found = _found + 1;
	};
	_u = _u+1;
};

if (_found > 0) then {
	_requirementText = "Factory required follow product for build this unit:<br/>" + _requirementText + "<br/><br/>";
};
_requirementText;