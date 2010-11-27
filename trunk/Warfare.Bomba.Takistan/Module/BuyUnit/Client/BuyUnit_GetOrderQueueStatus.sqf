#include "profiler.h"
PROFILER_BEGIN("BuyUnit_GetOrderQueueStatus");

private['_building', '_orderQueue'];
	
	_building = _this;
	_orderQueue = _building getVariable "orderQueue";
	
	if (isNil "_orderQueue") then {
		_orderQueue = 0;
	};

PROFILER_END();
_orderQueue;
