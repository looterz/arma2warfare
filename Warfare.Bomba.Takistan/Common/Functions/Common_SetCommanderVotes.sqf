#include "profiler.h"
PROFILER_BEGIN("Common_SetCommanderVotes");

private['_side','_teams','_total','_value','_id','_vote'];

_side = _this Select 0;
_value = _this Select 1;

_teams = (Format["WFBE_%1TEAMS",str _side] Call GetNamespace);
_total = Count _teams + 1;

for [{_id = 1},{_id < _total},{_id = _id + 1}] do {
	if (isPlayer (leader (_teams Select (_id - 1)))) then {
		_vote = [_id, _side, _value] call SetTeamVote;
	};
};

PROFILER_END();