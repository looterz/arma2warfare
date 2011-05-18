#include "profiler.h"
PROFILER_BEGIN("Market_RoundValue");

	if (_this < 10) exitWith { 
		PROFILER_END();				// i knew that this is bad, for profiling
		floor(_this);
	};

	if (_this < 100) exitWith { 
		PROFILER_END();
		floor(_this / 10) * 10;
	};

	if (_this < 10000) exitWith { 
		PROFILER_END();
		floor(_this / 100)*100; 
	};

PROFILER_END();
floor(_this / 1000)*1000; 
