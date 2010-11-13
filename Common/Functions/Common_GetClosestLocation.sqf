#include "profiler.h"
PROFILER_BEGIN("Common_GetClosestLocation");

Private["_bFound", "_count","_location","_object","_nearest","_nearestDistance"];

_object = _this select 0;
_nearest = ObjNull;
_nearestDistance = 100000;

_bFound = false;
_count = totalTowns;
while { !(_count == 0) && !_bFound } do {
	_count = _count - 1;
	_location = towns Select _count;
	_distance = _location Distance _object;

	//Exit early if possible.
	if (_distance < 100) then {_nearest = _location; _bFound = true; };
	if (_distance < _nearestDistance) then {_nearest = _location;_nearestDistance = _distance};
};

PROFILER_END();
_nearest;