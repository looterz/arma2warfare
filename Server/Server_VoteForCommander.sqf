Private ['_comVoteTime','_side'];
_side = _this select 0;

_comVoteTime = 'WFBE_VOTETIME' Call GetNamespace;
WF_Logic setVariable [Format["%1CommanderVoteTime",Str _side],_comVoteTime,true];

while {_comVoteTime > 0} do {
	sleep 1;
	_comVoteTime = _comVoteTime - 1;
	WF_Logic setVariable [Format["%1CommanderVoteTime",Str _side],_comVoteTime,true];
};
	
WF_Logic setVariable [Format["%1CommanderVoteTime",Str _side],_comVoteTime,true];

_commanderTeam = [_side] Call GetCommanderFromVotes;

if (!IsNull _commanderTeam) then {WF_Logic setVariable [Format ["%1CommanderTeam",Str _side],_commanderTeam,true]} else {WF_Logic setVariable [Format ["%1CommanderTeam",Str _side],objNull,true]};

_delay = 0;
if (_side == East) then {_delay = 1};

sleep _delay;

[_side,CMDCOMMANDERVOTE,_commanderTeam] Spawn CommandToSide;

//--- Flow Optimization, avoid spaming this on JIP.
_lastCom = Call Compile Format["%1LastCommander",_side];
if (!isNull(_commanderTeam)) then {
	_skip = true;
	_display = false;
	if (isNull _lastCom) then {_skip = false;_display = true};
	if (_skip) then{if (_lastCom != _commanderTeam) then {_skip = false;_display = true}};
	
	if (_display && AI) then {	
		for [{_count = 0},{_count < maxPlayers},{_count = _count + 1}] do {
			sleep 0.05;
			Call Compile Format["publicVariable '%1AITeam%2Coord'",str _side,_count + 1];
			Call Compile Format["publicVariable '%1AITeam%2Order'",str _side,_count + 1];
		};
	};
};
Call Compile Format["%1LastCommander = _commanderTeam",Str _side];

_aibase = Call Compile Format ["%1AIBase",str _side];
if (isNull _commanderTeam && AIcom && !_aibase) then {[_side] ExecFSM "Server\FSM\aibase.fsm";};