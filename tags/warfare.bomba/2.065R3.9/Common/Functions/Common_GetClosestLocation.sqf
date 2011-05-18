#include "profiler.h"
PROFILER_BEGIN("Common_GetClosestLocation");

Private["_count","_location","_object","_nearest","_nearestDistance"];

_object = _this select 0;
_nearest = objNull;
_nearestDistance = 100000;

_count = totalTowns;
while { _count != 0 } do {
	_count = _count - 1;
	_location = towns Select _count;
	_distance = _location Distance _object;

	//Exit early if possible.
	if (_distance < 100) then {_nearest = _location; _count = 0; };
	if (_distance < _nearestDistance) then {_nearest = _location;_nearestDistance = _distance};
};

PROFILER_END();
_nearest;