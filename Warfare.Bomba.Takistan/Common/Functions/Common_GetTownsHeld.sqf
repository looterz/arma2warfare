#include "profiler.h"
PROFILER_BEGIN("Common_GetTownHeld");

private['_held','_sideID'];

_held = 0;
_sideID = _this Call GetSideID;

{	if ((_x getVariable 'sideID') == _sideID) then {
		_held = _held + 1;
	};
} forEach towns;

PROFILER_END();
_held;