#include "profiler.h"
PROFILER_BEGIN("Common_GetRandomPositionEx");

Private["_pos", "_grid"];

	_grid = _this call GetGridTarget;	
	_pos = _grid select ( floor(random(count _grid)) );
	
PROFILER_END();
_pos;