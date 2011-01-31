#include "profiler.h"
PROFILER_BEGIN("Common_GetSideID");

if (_this == west || _this == "WEST" || _this == WESTID ) exitwith { 
	PROFILER_END();
	WESTID;
};
if (_this == east || _this == "EAST" || _this == EASTID ) exitwith { 
	PROFILER_END();
	EASTID;
};

if (_this == resistance || _this == "RESISTANCE" || _this == RESISTANCEID ) exitwith { 
	PROFILER_END();
	RESISTANCEID;
};

format["Common_GetSide: Unknown side variable: %1", _this] call LogError;
PROFILER_END();