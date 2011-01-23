#include "profiler.h"
PROFILER_BEGIN("Common_GetClientID");

Private["_index", "_slot"];

_slot = _this;
_index = ('WFBE_EASTSLOTNAMES' Call GetNamespace) find (vehicleVarName _slot);
if (_index < 0) then {_index = ('WFBE_WESTSLOTNAMES' Call GetNamespace) find (vehicleVarName _slot)};

PROFILER_END();
_index + 1;