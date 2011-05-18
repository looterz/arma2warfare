#include "profiler.h"
PROFILER_BEGIN("Common_GetSideHQ");

private['_value'];
_value = Call Compile Format ["%1MHQ",_this];

PROFILER_END();
if (!isNil "_value") exitWith { _value; };