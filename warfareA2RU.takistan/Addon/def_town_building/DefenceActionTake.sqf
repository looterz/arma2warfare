_defence = cursorTarget;

	_dir = getDir Player;

	_defenceInfo = [WF_DefenceTypeList, { (_x select DEFENCEINFO_TYPENAME) == typeof(_defence) } ] call getFirstOrDefault;
	if (isNil "_defenceInfo") exitWith {};
	
	_defence setDir _dir;
	_defence attachTo [player,[0, _defenceInfo select DEFENCEINFO_RANGE, 1.0 + (_defenceInfo select DEFENCEINFO_ZTAKEOFFSET)]];
	_defence lock true;

	hint format ["%1\n%2", (_defenceInfo select DEFENCEINFO_DESCRIPTION), localize "PC_taked"];
	player setVariable ["DefenceTaken", _defence];

