if (votePopUp) then {
	_voteTime = 0;
	waitUntil {_voteTime = WF_Logic getVariable Format ["%1CommanderVoteTime",sideJoinedText];!isNil "_voteTime"};
	if (_voteTime != 0 && !voted) then {CreateDialog "RscDisplayWFVoting"};
	if (voted) then {voted = false};
};