#include "profiler.h"
PROFILER_BEGIN("Common_GetCommanderFromVotes");

private['_AI','_commander','_count','_highest','_highestTeam','_side','_teams','_total','_vote','_votes','_tie'];
_side = _this Select 0;

_AI = 0;
_teams = (Format["WFBE_%1TEAMS",str _side] Call GetNamespace);
_total = Count _teams;

_votes = [];
for [{_count = 0},{_count < _total},{_count = _count + 1}] do {_votes = _votes + [0]};

//Count votes.
for [{_count = 0},{_count < _total},{_count = _count + 1}] do {
	if (isPlayer (leader (_teams Select _count))) then {
		_vote = [(_count + 1), _side] call GetTeamVote;
		if (_vote != -1) then {
			_votes set[_vote,(_votes Select _vote) + 1];
		} else {
			_AI = _AI + 1;
		};
	}
};

_count = 0;
_highest = 0;
_highestTeam = -1;
_tie = false;
{
	if (_x == _highest && _x > 0) then { _tie = true; };
	if (_x > _highest) then {_highestTeam = _count;_highest = _x;_tie = false};
	_count = _count + 1;
} ForEach _votes;

_commander = ObjNull;

if (!_tie && _highest > _AI && _highestTeam != -1) then {
	_commander = _teams select _highestTeam;
};

PROFILER_END();
_commander;