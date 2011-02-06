#include "profiler.h"
PROFILER_BEGIN("Common_GetGridPosition");

private['_pos','_maxRadius','_minRadius','_grid','_dt','_y','_pos1'];

	_pos = _this select 0;
	_minRadius = _this select 1;
	_maxRadius = _this select 2;
	format["GetGridPosition: %1 Rmin=%2 Rmax=%3", _pos, _minRadius, _maxRadius] call LogHigh;

	_grid = [];

	_dt = (2 * _maxRadius) / 30;
	if (_dt < 10) then { 
		_dt = 10; 
		if (_dt > _maxRadius) then {
			_dt = _maxRadius;
		};
	};
	
	for [ {_x = -_maxRadius}, { _x <= _maxRadius}, { _x = _x + _dt}] do {
		if ( _x < -_minRadius || _x > _minRadius ) then {
			for [ {_y = -_maxRadius}, { _y <= _maxRadius}, { _y = _y + _dt}] do {
				if ( _y < -_minRadius || _y > _minRadius ) then {
				
					_pos1 = [(_pos select 0) + _x, (_pos select 1) + _y, 0];					
					if ( !(surfaceIsWater _pos1) ) then {
					
						if ( ([_pos1, 5, false, objNull] call GetIsFlatPosition) ) then {
							_grid = _grid + [ _pos1 ];
						};
					};
				};
			};
		};
	};
	
	if ( (count _grid) == 0 ) then {
		_grid = [ _pos ];
	};

PROFILER_END();
_grid;