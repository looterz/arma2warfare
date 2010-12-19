#include "profiler.h"
PROFILER_BEGIN("Common_GetIsFlatPosition");

Private["_position","_radius","_list","_flat","_u","_object", "_meters", "_allowedType", "_ignoreVehicle"];

	_position 	= _this select 0;
	_radius 	= _this select 1;
	_ignoreVehicle = _this select 2;
	_vehicle	= if (count _this > 3) then { _this select 3 } else { objNull };
	
	_list = _position nearObjects _radius;
	_flat = true;
	
	_maxGrad = 'WFBE_COINMAXGRADIENT' Call GetNamespace;
	_minDist = 'WFBE_COINMINDISTANCE' Call GetNamespace;	
	
	_isFlat = _position isFlatEmpty [
				0.00001,	//--- Minimal distance from another object
				0,			//--- If 0, just check position. If >0, select new one
				0.7, 		//_maxGrad,				//--- Max gradient
				0.7,		//--- Gradient area
				0,			//--- 0 for restricted water, 2 for required water,
				false,		//--- True if some water can be in 25m radius
				_vehicle	//--- Ignored object
	];
	if (count _isFlat == 0) exitWith { 
		PROFILER_END();	
		false;
	};
	
	
	_u = count _list;
	
	while { _u != 0 } do {
		_u = _u - 1;
		_object = _list select _u;
		
		_allowedType = if (_object == _vehicle) then { false } else { true };
		if (!_ignoreVehicle) then {
			if ( (_object isKindOf "Man") || (_object isKindOf "Car") || (_object isKindOf "Tank") || (_object isKindOf "Air") ) then {
				_allowedType = false;
			};
		};
		
		if ( _allowedType ) then {

			_radius = (sizeof typeof _object)/2.35;
			if (_radius > 1) then {
				_meters = _object distance _position;
				if (_meters < _radius) then {
					_flat = false;
					_u = 0;	//-- end search;
				};
			};
		};
	};

PROFILER_END();
_flat;