#include "profiler.h"
PROFILER_BEGIN("Common_GetSideID");

Private["_ID"];

_ID = RESISTANCEID;
if (_this == east) then {_ID = EASTID};
if (_this == west) then {_ID = WESTID};

PROFILER_END();
_ID;