#include "profiler.h"
PROFILER_BEGIN("Common_SetTeamMovePos");

Private['_index','_movePos','_team'];

_team = _this select 0;
_movePos = _this select 1;

_index = _team Call GetClientIDFromTeam;

Call Compile Format ["%1MovePos%2 = _movePos; publicVariable '%1MovePos%2';",str (side _team),_index];

PROFILER_END();