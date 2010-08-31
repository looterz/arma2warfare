Private ["_team","_totalWP","_waypoints"];
_team = _this;

_waypoints = waypoints _team;
_totalWP = (count _waypoints)-1;

while {_totalWP >= 0} do {
	deleteWaypoint [_team, _totalWP];
	_totalWP = _totalWP - 1;
};