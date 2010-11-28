#include "profiler.h"
PROFILER_BEGIN("Common_GetRandomPositionEx");

Private["_grid", "_position","_radius","_direction","_maxRadius","_minRadius", "_bFound"];
	
	_position = getPos (_this select 0);
	_minRadius = _this select 1;
	_maxRadius = _this select 2;

	_bFound = false;
	while { !_bFound } do {
		_direction = random 360;
		_radius = (random (_maxRadius - _minRadius)) + _minRadius;
		_position = [(_position select 0)+((sin _direction)*_radius),(_position select 1)+((cos _direction)*_radius), _position select 2];
		_bFound = if (surfaceIsWater _position) then { false } else { true };
	};	
	
	//_position = [getPos (_this select 0), _this select 1, _this select 2 ] call GetRandomPosition;
	//_grid = _this call GetGridTarget;	
	//_position = _grid select ( floor(random(count _grid)) );
	
PROFILER_END();
_position;