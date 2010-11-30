#include "profiler.h"
PROFILER_BEGIN("Common_MarkerUpdate");

	if (!(local player)) exitWith {
		PROFILER_END();
	};

	waitUntil { !isNil "TrackMapMarkerAdd" };
	_this call TrackMapMarkerAdd;

PROFILER_END();