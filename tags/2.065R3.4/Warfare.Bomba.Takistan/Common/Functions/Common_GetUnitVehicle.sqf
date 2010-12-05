#include "profiler.h"
PROFILER_BEGIN("Common_GetUnitVehicle");

Private['_unit','_return'];
_unit = _this;

_return = if (_unit != vehicle _unit) then {vehicle _unit} else {_unit};

PROFILER_END();
_return;