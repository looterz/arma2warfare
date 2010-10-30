Private ['_boundariesXY'];
_boundariesXY = -1;

switch (worldName) do {
	case 'chernarus': {_boundariesXY = 15360};
	case 'Chernarus': {_boundariesXY = 15360};
	
	case 'utes': {_boundariesXY = 5120};
	case 'queshkibrul': {_boundariesXY = 5120};
	case 'eden': {_boundariesXY = 12800};
	case 'isladuala': {_boundariesXY = 10240};
	case 'Panthera2': {_boundariesXY = 10240};
	case 'SaraLite': {_boundariesXY = 10240};
	case 'Sara': {_boundariesXY = 20480};
	case 'Zargabad': {_boundariesXY = 8192};
	case 'takistan': {_boundariesXY = 12800};
	case 'Takistan': {_boundariesXY = 12800};
};

if (_boundariesXY == -1) then {
	paramBoundaries = false;
	if (local player) then {
		BoundariesIsOnMap = nil;
		BoundariesHandleOnMap = nil;
	};
	Format["Init_Boundaries: There is no proper boundaries set for the island '%1'",worldName] call LogMedium;
} else {
	['WFBE_BOUNDARIESXY',_boundariesXY,true] Call SetNamespace;
	Format["Init_Boundaries: Boundaries found for the island '%1' %2",worldName,_boundariesXY] call LogMedium;
};