#include "profiler.h"
PROFILER_BEGIN("Common_GetSideHQ");

private["_sideId"];

_sideId = (_this) call GetSideID;
if (_sideId == WESTID) exitWith {
	PROFILER_END();
	WESTMHQ;
};

if (_sideId == EASTID) exitWith {
	PROFILER_END();
	EASTMHQ;
};

format["Common_GetSideHQ unknown side: '%1'", _this] call LogError;
PROFILER_END();