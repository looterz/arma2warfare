#include "profiler.h"
PROFILER_BEGIN("Common_GetSideHQ");

private["_sideId"];

_sideId = (_this) call GetSideID;
if (_side == WESTID) exitWith {
	PROFILER_END();
	WESTMHQ;
};

if (_side == EASTID) exitWith {
	PROFILER_END();
	EASTMHQ;
};

format["Common_GetSideHQ unknown side: '%1'", _side] call LogError;
PROFILER_END();