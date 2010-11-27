#include "profiler.h"
PROFILER_BEGIN("Common_GetLiveUnits");

Private["_liveUnits","_units"];

_units = _this;
_liveUnits = [];

{if (alive _x) then {_liveUnits = _liveUnits + [_x]}} ForEach _units;

PROFILER_END();
_liveUnits;
