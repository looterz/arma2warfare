#include "profiler.h"
PROFILER_BEGIN("Common_GetNamespace");

Private ['_value'];
_value = missionNamespace getVariable _this;

PROFILER_END();
if (!isNil "_value") exitWith { _value; };