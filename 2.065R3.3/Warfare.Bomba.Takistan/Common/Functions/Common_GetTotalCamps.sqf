#include "profiler.h"
PROFILER_BEGIN("Common_GetTotalCamps");

private["_result"];
_result = count (_this getVariable "camps");

PROFILER_END();
_result;