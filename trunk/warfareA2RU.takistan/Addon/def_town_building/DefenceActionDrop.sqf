	_takenDefence = player getVariable "DefenceTaken";
	if (_takenDefence == objNull) exitWith {};
	
	detach _takenDefence;
	player setVariable["DefenceTaken", objNull];
	
	_defenceInfo = [WF_DefenceTypeList, { (_x select DEFENCEINFO_TYPENAME) == typeof(_takenDefence) } ] call getFirstOrDefault;
	if (isNil "_defenceInfo") exitWith {};	
	
	_dir = getDir player;
	_dis = (_defenceInfo select DEFENCEINFO_RANGE);
	_pos = getPosATL player;	
	_pos = [(_pos select 0) + sin _dir * _dis, (_pos select 1) + cos _dir * _dis, (_pos select 2) + (_defenceInfo select DEFENCEINFO_ZOFFSET)];
	
	_takenDefence setPosATL _pos;
	_takenDefence setDir _dir;
	_takenDefence lock false;