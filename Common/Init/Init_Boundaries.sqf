Private ['_boundariesXY'];
_boundariesXY = -1;

switch (worldName) do {
	case 'chernarus': {_boundariesXY = 15360};
	case 'utes': {_boundariesXY = 5120};
	case 'queshkibrul': {_boundariesXY = 5120};
	case 'eden': {_boundariesXY = 12800};
	case 'isladuala': {_boundariesXY = 10240};
	case 'Panthera2': {_boundariesXY = 10240};
	case 'SaraLite': {_boundariesXY = 10240};
	case 'Sara': {_boundariesXY = 20480};
	case 'Zargabad': {_boundariesXY = 8192};
	case 'Takistan': {_boundariesXY = 12800};
};

if (_boundariesXY == -1) then {
	paramBoundaries = false;
	if (local player) then {
		BoundariesIsOnMap = nil;
		BoundariesHandleOnMap = nil;
	};
} else {
	['WFBE_BOUNDARIESXY',_boundariesXY,true] Call SetNamespace;
};