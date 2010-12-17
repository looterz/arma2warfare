#include "profiler.h"
PROFILER_BEGIN("Common_GetTotalCamps");

private["_result", "_camps"];

_camps = _this getVariable "camps";
if (isNil '_camps') exitWith {1};

_result = count _camps;

PROFILER_END();
_result;