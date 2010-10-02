Private ["_exit","_reset","_timer","_trash","_vehicle"];

_vehicle = _this;

_exit = false;
_timer = 0;

while {!_exit} do {
	sleep 20;
	_skip = false;
	if (!(alive _vehicle) && !(isNull _vehicle)) then {
		_skip = true;
		_exit = true;
		if !(_vehicle in trashQueu) then {
			trashQueu = trashQueu + [_trash];
			_trash Spawn TrashObject;
		};
	};
	if (!(isNull _vehicle) && !_skip) then {
		_reset = false;
		{if (alive _x) then {_reset = true}} forEach Crew _vehicle;
		if (_reset) then {_timer = 0};
		if (_timer > ('WFBE_ABANDONVEHICLETIMER' Call GetNamespace)) then {
			_exit = true;
			if (someAmmo _vehicle) then {_vehicle setVehicleAmmo 0};
			_vehicle setDammage 1;
			sleep 2;
			if !(_vehicle in trashQueu) then {
				trashQueu = trashQueu + [_trash];
				_trash Spawn TrashObject;
			};
		};
		_timer = _timer + 20;
	} else {_exit = true};
};

emptyQueu = emptyQueu - [_vehicle];