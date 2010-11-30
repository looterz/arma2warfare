#include "profiler.h"
PROFILER_BEGIN("Service_EmptyVehIsEmpty");

private['_vehicle', '_empty'];

	_vehicle = _this;
	_empty = true;
	{ if (alive _x) then { _empty = false; } } forEach Crew _vehicle;
	
PROFILER_END();	
_empty;