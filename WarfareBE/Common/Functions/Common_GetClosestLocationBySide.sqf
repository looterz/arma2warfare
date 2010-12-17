Private["_count","_location","_object","_nearest","_nearestDistance","_sideID","_tsideID"];
ScopeName "getClosestLocation";

_object = _this Select 0;
_sideID = _this Select 1;

_nearest = ObjNull;
_nearestDistance = 100000;

for [{_count = totalTowns - 1},{_count >= 0},{_count = _count - 1}] do {
	_location = towns Select _count;
	_tsideID = _location getVariable 'sideID';
	
	if (_tsideID != _sideID) then {
		_distance = _location distance _object;

		if (_distance < 100) then {_nearest = _location;BreakTo "getClosestLocation"};
		if (_distance < _nearestDistance) then {_nearest = _location;_nearestDistance = _distance};
	};
};

_nearest