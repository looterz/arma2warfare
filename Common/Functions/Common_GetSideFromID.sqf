#include "profiler.h"
PROFILER_BEGIN("Common_GetSideFromId");

Private["_side"];

_side = Resistance;
if (_this == EASTID) then {
	_side = East
} else {
	if (_this == WESTID) then {
		_side = West
	};
};

PROFILER_END();
_side;