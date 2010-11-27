#include "profiler.h"
PROFILER_BEGIN("Common_SetTeamMoveMode");

Private['_index','_moveMode','_team'];

_team = _this select 0;
_moveMode = _this select 1;

_index = _team Call GetClientIDFromTeam;

Call Compile Format ["%1MoveMode%2 = _moveMode; publicVariable '%1MoveMode%2';",str (side _team),_index];

PROFILER_END();