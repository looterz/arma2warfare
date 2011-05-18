#include "profiler.h"
PROFILER_BEGIN("Market_GetUnitRequirementText");

private['_factory', '_unit', '_requirementText', '_u', '_found', '_unitData', '_unitData1', '_type', '_products', '_marketStock', '_marketPrices', '_reqProduct', '_reqProductId', '_reqProductValue', '_stockValue', '_cost', '_buyValue', '_price', '_buy', '_name'];

	if (!paramVehicleComponents) exitWith { 
		PROFILER_END();
		""; 
	};

	_unit = _this select 1;
	_requirementText = "";

	_unitData = _unit call marketGetUnitRequiredProducts;
		
	format['get unit requirment text: %1', _unit] call LogHigh;	
		
	if (isNil '_unitData') exitWith { 
		format['empty requirmenttext=%1', _requirementText] call LogHigh;
		PROFILER_END();
		
		_requirementText; 
	};

	_factory = _this select 0;
	_marketStock = _factory call marketGetMarketProducts;
	_marketPrices = _factory call marketGetMarketPrices;

	format['_unitData=%1', _unitData] call LogHigh;

	_found = 0;
	_u = count _unitData;
	while { _u != 1 } do {
		_u = _u - 1;

		_reqProduct = _unitData select _u;
		_reqProductId = _reqProduct select 0;
		_reqProductValue = _reqProduct select 1;
		_stockValue = _marketStock select _reqProductId;

		
		if (_stockValue < _reqProductValue) then {
			_name = marketProductNameCollection select _reqProductId;
			_unit = marketProductUnitCollection select _reqProductId;
			
			if (_found != 0) then { _requirementText = _requirementText + ", "; };
			
			_text = format["%1: %3%2", _name, _unit, _reqProductValue, _stockValue];
			_requirementText = _requirementText + _text;	
			_found = _found + 1;
		};
	};

	if (_found != 0) then {
		_requirementText = "Factory required follow product for build this unit:<br/>" + _requirementText + "<br/><br/>";
	};

PROFILER_END();
_requirementText;