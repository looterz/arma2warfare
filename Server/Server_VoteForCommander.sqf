Private ['_aibase','_commanderTeam','_comVoteTime','_side','_sideText'];
_side = _this select 0;

waitUntil { initJIP };
waitUntil { !isNil "LogInited" };

_sideText = _side;
_comVoteTime = 'WFBE_VOTETIME' Call GetNamespace;
WF_Logic setVariable [Format["%1CommanderVoteTime",_sideText],_comVoteTime,true];

while {_comVoteTime > 0} do {
	sleep 1;
	_comVoteTime = _comVoteTime - 1;
	WF_Logic setVariable [Format["%1CommanderVoteTime",_sideText],_comVoteTime,true];
};
	
WF_Logic setVariable [Format["%1CommanderVoteTime",_sideText],_comVoteTime,true];

_commanderTeam = [_side] Call GetCommanderFromVotes;

if (!IsNull _commanderTeam) then {WF_Logic setVariable [Format ["%1CommanderTeam",_sideText],_commanderTeam,true]} else {WF_Logic setVariable [Format ["%1CommanderTeam",_sideText],objNull,true]};

_delay = 0;
if (_side == East) then {_delay = 1};

sleep _delay;

WFBE_CommanderVote = [_side,'CLTFNCCOMMANDERVOTE',_commanderTeam];
publicVariable 'WFBE_CommanderVote';
if (IsClientServer) then {[_side,'CLTFNCCOMMANDERVOTE',_commanderTeam] Spawn HandlePVF};

[Format["WFBE_%1_LastCommander",_sideText],_commanderTeam,true] Call SetNamespace;

_aibase = Format["WFBE_%1_AIBase",_sideText] Call GetNamespace;
if (isNull _commanderTeam && paramAIcom && !_aibase) then {[_side] ExecFSM "Server\FSM\aibase.fsm"};

if (isNull _commanderTeam) then {
	Format["Server_VoteForCommander: %1 Commander = AI Commander.",_sideText] call LogMedium;
} else {
	Format["Server_VoteForCommander: %1 Commander = %2.",_sideText,name leader _commanderTeam] call LogMedium;
};