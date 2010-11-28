#include "profiler.h"
PROFILER_BEGIN("Common_GetRandomPosition");

Private["_position","_radius","_direction","_maxRadius","_minRadius", "_bFound"];

_position = _this select 0;
_minRadius = _this select 1;
_maxRadius = _this select 2;

	_bFound = false;
	while { !_bFound } do {
		_direction = random 360;
		_radius = (random (_maxRadius - _minRadius)) + _minRadius;
		_position = [(_position select 0)+((sin _direction)*_radius),(_position select 1)+((cos _direction)*_radius), _position select 2];
		_bFound = if (surfaceIsWater _position) then { false } else { true };
	};

PROFILER_END();
_position;