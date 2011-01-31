#include "profiler.h"
PROFILER_BEGIN("Common_GetSideStructures");

private['_sideId'];

_sideId = (_this) call GetSideID;
if (_side == WESTID) exitWith {
	PROFILER_END();
	WESTBaseStructures;
};

if (_side == EASTID) exitWith {
	PROFILER_END();
	EASTBaseStructures;
};

format["Common_GetSideStructures unknown side: '%1'", _side] call LogError;
PROFILER_END();