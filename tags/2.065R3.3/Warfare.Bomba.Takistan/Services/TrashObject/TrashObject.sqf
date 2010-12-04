#include "profiler.h"
PROFILER_BEGIN("Service_TrashObject");

Private ["_alive","_group","_isMan","_object"];
_object = _this;

	if (isNil "_object") exitWith { PROFILER_END(); };
	if (isNull _object)  exitWith { PROFILER_END(); };

	waitUntil { !(isNil "WBE_TrashObjectOperation") };

	WBE_TrashObjectOperation = WBE_TrashObjectOperation + [ [_object, (time + WFBE_UNITREMOVEDLAY), 0] ];

PROFILER_END();