Private ["_camp","_campSideID","_camps","_count","_count1","_ex","_marker","_town","_townSideID"];

for [{_count = totalTowns - 1},{_count >= 0},{_count = _count - 1}] do {
	_town = towns select _count;
	_townSideID = _town getVariable "sideID";

	if (sideID == _townSideID) then	{
		_marker = Format["%1Depot",str _town];
		_marker setMarkerColorLocal "ColorGreen";
	};

	_ex = false;
	while {!_ex} do {
		sleep 0.05;
		_camps = _town getVariable "camps";
		if !(isNil "_camps") then {_ex = true};
	};
	_camps = _town getVariable "camps";

	for [{_count1 = count _camps - 1},{_count1 >= 0},{_count1 = _count1 - 1}] do {
		_camp = _camps select _count1;
		if !(isNull _camp) then {
			_marker = Format["%1Camp%2",str _town,_camps find _camp];
			
			_ex = false;
			while {!_ex} do {
				sleep 0.05;
				_campSideID = _camp getVariable "sideID";
				if !(isNil "_campSideID") then {_ex = true};
			};
			_campSideID = _camp getVariable "sideID";

			if (sideID == _campSideID) then	{
				_marker setMarkerColorLocal "ColorGreen";
			} else{
				if (_townSideID == sideID) then	{
					_marker setMarkerColorLocal "ColorRed";
				};
			};
		};
	};
};