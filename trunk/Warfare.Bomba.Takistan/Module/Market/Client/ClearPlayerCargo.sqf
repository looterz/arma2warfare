#include "profiler.h"
PROFILER_BEGIN("Market_ClearPlayerCargo");
	player setVariable ["marketProductStorage", [], true];
PROFILER_END();