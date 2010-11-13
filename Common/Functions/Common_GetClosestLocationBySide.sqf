#include "profiler.h"
PROFILER_BEGIN("Common_GetClosestLocationBySide");

Private["_bFound", "_count","_location","_object","_nearest","_nearestDistance","_sideID","_tsideID"];

_object = _this Select 0;
_sideID = _this Select 1;

_nearest = ObjNull;
_nearestDistance = 100000;

_bFound = false;
_count = totalTowns;
while { !(_count == 0) && !_bFound } do {
	_count = _count - 1;
	
	_location = towns Select _count;
	_tsideID = _location getVariable 'sideID';
	
	if (_tsideID != _sideID) then {
		_distance = _location distance _object;

		if (_distance < 100) then {_nearest = _location; _bFound = true; };
		if (_distance < _nearestDistance) then {_nearest = _location;_nearestDistance = _distance};
	};
};

PROFILER_END();
_nearest;