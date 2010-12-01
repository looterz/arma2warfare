#include "profiler.h"
PROFILER_BEGIN("Market_RoundValue");
private['_result'];

	if (_this > 10000) exitWith { 
		_result = floor(_this / 1000)*1000; 
		PROFILER_END();
		_result;
	};
	if (_this > 1000) exitWith { 
		_result = floor(_this / 100)*100; 
		PROFILER_END();
		_result;
	};
	if (_this > 100) exitWith { 
		_result = floor(_this / 10)*10; 
		PROFILER_END();
		_result;
	};
	if (_this > 10) exitWith { 
		_result = floor(_this); 
		PROFILER_END();
		_result;
	};

PROFILER_END();	
_this;
