#include "profiler.h"
PROFILER_BEGIN("Server_BuildingDamaged");

Private["_currentDammages","_damage","_damagedBy","_side","_structure","_timeAttacked"];

_structure = _this Select 0;
_damagedBy = _this Select 1;
_damage = _this Select 2;
_currentDammages = getDammage _structure;

_side = east;

PROFILER_END();