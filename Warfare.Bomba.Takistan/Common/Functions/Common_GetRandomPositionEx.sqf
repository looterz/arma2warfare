#include "profiler.h"
PROFILER_BEGIN("Common_GetRandomPositionEx");

private['_position','_radius','_direction','_maxRadius','_minRadius','_bCount'];
	
	_position = getPos (_this select 0);
	_minRadius = _this select 1;
	_maxRadius = _this select 2;

	_bCount = 5;
	while { _bCount != 0 } do {
		_direction = random 360;
		_radius = (random (_maxRadius - _minRadius)) + _minRadius;
		_position = [(_position select 0)+((sin _direction)*_radius),(_position select 1)+((cos _direction)*_radius), _position select 2];
		_bCount = if (surfaceIsWater _position) then { _bCount - 1 } else { 0 };
	};	
	
PROFILER_END();
_position;