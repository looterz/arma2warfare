#include "profiler.h"
PROFILER_BEGIN("Common_GetSideHQDeployed");

private['_value'];

_value = Call Compile Format ["%1MHQDeployed",_this];

PROFILER_END();
if (!isNil "_value") exitWith { _value; };