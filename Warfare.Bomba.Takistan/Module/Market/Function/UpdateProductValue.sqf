#include "profiler.h"
PROFILER_BEGIN("Market_UpdateProductValue");

private['_container','_productId','_dV','_storage','_u','_id','_updated','_volume','_item'];
	_dV = _this select 2;
	
	format["UpdateProductValue: %1", _this] call LogHigh;

	if (_dV != 0) then {

		_container = _this select 0;
		_productId = _this select 1;
	
		_storage = _container getVariable "marketProductStorage";
		if (isNil "_storage") then { _storage = [] };
		_storage = _storage - [objNull];
		
		_u = count _storage;
		_updated = false;
		
		while { _u != 0} do {
			_u = _u - 1;
			_item = _storage select _u;			
			
			_id = (_item select 0);
			if (_id == _productId) then { 
				_volume = (_item select 1) + _dV;
				if (_volume < 0) then { _volume = 0 };
				_item set [1, _volume];
				
				if (_volume <= 0) then { _storage set [_u, objNull]; };
				_u = 0;
				_updated = true;
			};
		};
		
		if (!_updated && _dV > 0) then {
			_storage = _storage + [[_productId, _dV]];
			_updated = true;
		};
		
		if (_updated) then {
			_storage = _storage - [objNull];
			_container setVariable ["marketProductStorage", _storage, true];
			_container setVariable ["marketTimeStamp", format["%1", time], true];
		};
	};

PROFILER_END();