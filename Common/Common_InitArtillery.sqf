#include "profiler.h"
PROFILER_BEGIN("Common_InitArtillery");

Private ["_arty"];
_arty = _this select 0;

waitUntil {BIS_ARTY_LOADED};
sleep 5;

[_arty] call BIS_ARTY_F_initVehicle;

PROFILER_END();