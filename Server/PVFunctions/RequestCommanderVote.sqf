Private["_commanderTeam","_client","_side","_team"];

_side = _this Select 0;
_client = _this Select 1;

if ((WF_Logic getVariable Format["%1CommanderVoteTime",str _side]) <= 0) then {
	_team = -1;
	_commanderTeam = (_side) Call GetCommanderTeam;

	if (!IsNull _commanderTeam) then {
		_team = (Format["WFBE_%1TEAMS",str _side] Call GetNamespace) find _commanderTeam;
	};

	//Set votes to current commander.  Players will have to change their vote if they want a new commander.
	[_side,_team] Call SetCommanderVotes;

	[_side] Spawn SVoteForCommander;
	["VotingForNewCommander","",_side,""] Spawn SideMessage;
	
	[_side,CMDVOTEFORCOMMANDER,""] Spawn CommandToSide;
};