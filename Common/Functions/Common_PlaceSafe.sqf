#include "profiler.h"
PROFILER_BEGIN("Common_PlaceSafe");

Private["_count","_currentPosition","_direction","_object","_obstacles","_placed","_position","_radius","_vehicles"];
ScopeName "PlaceSafe";

_object = _this Select 0;
_position = _this Select 1;

_radius = 25;
if (Count _this > 2) then {_radius = _this Select 2};

_currentPosition = _position;
_placed = false;
_direction = 0;

for [{_count = 0},{_count < 10 && !_placed},{_count = _count + 1}] do {
	_obstacles = _currentPosition NearEntities[["Building"],15];
	_vehicles = _currentPosition NearEntities[["Building","Car","Tank","Air"],6];

	if (Count _obstacles > 0 || Count _vehicles > 0 || SurfaceIsWater _currentPosition) then {
		_currentPosition = [(_position Select 0)+((sin _direction)*_radius),(_position Select 1)+((cos _direction)*_radius),0];
		_direction = _direction + 36;
	} else {
		_object SetPos _currentPosition;
		_placed = true;
		BreakTo "PlaceSafe";
	};
};

if (!_placed) then {_object SetPos _position};

PROFILER_END();