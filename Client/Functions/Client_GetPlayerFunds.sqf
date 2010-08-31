Private ['_funds','_txt'];

_funds = clientTeam getVariable 'funds';
if (isNil '_funds') then {
	_funds = Format['WFBE_%1STARTINGMONEY',sideJoinedText] Call GetNamespace;
	_txt = 'DEBUG:\n\n There seems to be a problem with your funds, your funds were reseted due to an issue.';
	_txt Call DebugHint;
};

_funds