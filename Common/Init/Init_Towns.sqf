waitUntil{townModeSet};
_startAt = time;
waitUntil {!isNil "totalTowns"};
waitUntil {(count towns == totalTowns) ||  time - _startAt > 30};
if (time - _startAt >= 25 && local player) then {
	_txt = "DEBUG: \n\n Something might be wrong with the town initialization process, please check the WF_Logic entity (a blue little flag icon) inside the editor, make sure that the right amount of towns is set in it. \n\n Note that this won't affect the gameplay, this will just slow down the initialization process.";
	_txt Call DebugHint;
} else {townInit = true};