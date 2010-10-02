Private ['_team','_x'];
_team = _this;

for [{_x = (count (waypoints _team))-1},{_x > -1},{_x = _x - 1}] do {
	deleteWaypoint [_team, _x];
};