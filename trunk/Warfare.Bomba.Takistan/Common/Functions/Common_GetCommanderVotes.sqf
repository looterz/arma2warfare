#include "profiler.h"
PROFILER_BEGIN("Common_GetCommanderFromVotes");

Private["_count", "_u", "_side","_teams","_total","_vote","_votes"];

_side = _this Select 0;

_teams = (Format["WFBE_%1TEAMS",str _side] Call GetNamespace);
_total = count _teams + 1;

_votes = [];
_u = _total;
while { _u != 0 } do {
	_u = _u - 1;
	_votes = _votes + [0];
};

//Count votes.
_u = count _teams;
while { _u != 0 } do {
	_u = _u - 1;
	if (isPlayer (leader (_teams select _u))) then	{
		_vote = ([(_u+1), _side] call GetTeamVote) + 1;
		_votes set [_vote, (_votes select _vote) + 1];			
	};
};

PROFILER_END();
_votes;
