#include "profiler.h"
PROFILER_BEGIN("Common_GetVehicleMags");

private ["_entry", "_value"];
_entry = _this select 0;

_value = getArray(_entry >> 'magazines');

PROFILER_END();
if (!isNil "_value") exitWith { _value; };