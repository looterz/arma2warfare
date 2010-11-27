#include "profiler.h"
PROFILER_BEGIN("Common_GetSideStructures");

private['_value'];

_value = Call Compile Format ["%1BaseStructures",_this];

PROFILER_END();
if (!isNil "_value") exitWith { _value; };