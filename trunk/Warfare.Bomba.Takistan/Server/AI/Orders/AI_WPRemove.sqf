#include "profiler.h"
PROFILER_BEGIN("Server_AIOrders_WPRemove");

Private ['_team','_u'];
_team = _this;

_u = count (waypoints _team);
while { !(_u == 0) } do {
	_u = _u - 1;
	deleteWaypoint [_team, _u];	
};

PROFILER_END();