#include "profiler.h"
PROFILER_BEGIN("Common_GetSideUpgrades");

private['_value'];

_value = Call Compile Format ["%1Upgrades",_this];

PROFILER_END();
if (!isNil "_value") exitWith { _value; };