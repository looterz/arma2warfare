#include "profiler.h"
PROFILER_BEGIN("Common_GetClosestLocationBySide");

private['_bFound','_count','_location','_object','_nearest','_nearestDistance','_sideID','_tsideID','_distance'];

_object = _this Select 0;
_sideID = _this Select 1;

_nearest = objNull;
_nearestDistance = 100000;

_bFound = false;
_count = totalTowns;
while { _count != 0 } do {
	_count = _count - 1;
	
	_location = towns Select _count;
	_tsideID = _location getVariable 'sideID';
	
	if (_tsideID != _sideID) then {
		_distance = _location distance _object;

		if (_distance < 100) then {_nearest = _location; _count = 0; };
		if (_distance < _nearestDistance) then {_nearest = _location;_nearestDistance = _distance};
	};
};

PROFILER_END();
_nearest;