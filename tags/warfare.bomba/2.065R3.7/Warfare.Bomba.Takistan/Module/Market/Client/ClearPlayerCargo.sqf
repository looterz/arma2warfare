#include "profiler.h"
PROFILER_BEGIN("Market_ClearPlayerCargo");
Private ['_containerItems','_u','_type','_items', '_u'];

	_containerItems = [] + marketEmptyContainer;	
	player setVariable ["marketProductStorage", _containerItems, true];
PROFILER_END();