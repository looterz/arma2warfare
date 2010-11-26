#include "profiler.h"
PROFILER_BEGIN("Common_GetGridPosition");

Private["_pos","_maxRadius","_minRadius", "_grid", "_dt", "_x", "_y", "_pos1"  ];

	_pos = _this select 0;
	_minRadius = _this select 1;
	_maxRadius = _this select 2;

	_grid = [];

	_dt = (2 * _maxRadius) / 30;
	if (_dt < 5) then { _dt = 5; };

	for [ {_x = -_maxRadius}, { _x <= _maxRadius}, { _x = _x + _dt}] do {
		if ( _x <= -_minRadius || _x >= _minRadius ) then {
			for [ {_y = -_maxRadius}, { _y <= _maxRadius}, { _y = _y + _dt}] do {
				if ( _y <= -_minRadius || _y >= _minRadius ) then {
				
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