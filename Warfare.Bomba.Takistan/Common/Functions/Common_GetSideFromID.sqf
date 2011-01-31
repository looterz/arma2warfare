#include "profiler.h"
PROFILER_BEGIN("Common_GetSideFromId");

if (_this == EASTID) exitWith {
	PROFILER_END();
	east;
};

if (_this == WESTID) exitWith {
	PROFILER_END();
	west;
};

PROFILER_END();
resistance;