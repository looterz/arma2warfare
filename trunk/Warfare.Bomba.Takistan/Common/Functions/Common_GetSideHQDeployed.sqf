#include "profiler.h"
PROFILER_BEGIN("Common_GetSideHQDeployed");

private["_sideId"];

_sideId = (_this) call GetSide;
if (_sideId == WESTID) exitWith {
	PROFILER_END();
	WESTMHQDeployed;
};

if (_sideId == EASTID) exitWith {
	PROFILER_END();
	EASTMHQDeployed;
};

format["Common_GetSideHQDeployed unknown side: '%1'", _this] call LogError;
PROFILER_END();