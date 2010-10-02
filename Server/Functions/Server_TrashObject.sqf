Private ["_alive","_group","_isMan","_object"];
_object = _this;

if !(isNull _object) then {
	_group = [];
	_isMan = if (_object isKindOf "Man") then {true} else {false};
	if (_isMan) then {_group = group _object};
	sleep ('WFBE_UNITREMOVEDLAY' Call GetNamespace);
	trashQueu = trashQueu - [_object];
	if (_isMan) then {
		_get = _group getVariable 'funds';
		if (isNil '_get') then {
			_alive = units _group Call GetLiveUnits;
			if (count _alive <= 0) then {deleteGroup _group};
		};
		hideBody _object;
		sleep 6;
	};
	deleteVehicle _object;
};