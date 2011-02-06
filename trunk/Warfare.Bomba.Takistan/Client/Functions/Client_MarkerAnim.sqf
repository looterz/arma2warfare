private['_additionalErase','_markerColor','_markerName','_markerPosition','_markerSize','_markerType','_direction','_expand'];
_markerName = _this select 0;
_markerPosition = _this select 1;
_markerType = _this select 2;
_markerSize = _this select 3;
_markerColor = _this select 4;
_additionalErase = "";
if (count _this > 5) then {_additionalErase = _this select 5};

deleteMarkerLocal _markerName;
CreateMarkerLocal [_markerName,_markerPosition];
_markerName setMarkerTypeLocal _markerType;
_markerName setMarkerColorLocal _markerColor;
_markerName setMarkerSizeLocal [_markerSize,_markerSize];

_direction = 0;
_expand = true;
activeAnimMarker = true;

if (_additionalErase != "") then {
	Private ["_pr"];
	_pr = 'WFBE_PATROLRANGE' Call GetNamespace;
	createMarkerLocal [_additionalErase,_markerPosition];
	_additionalErase setMarkerShapeLocal "Ellipse";
	_additionalErase setMarkerColorLocal _markerColor;
	_additionalErase setMarkerSizeLocal [_pr,_pr];
};

while {activeAnimMarker} do {
	sleep 0.03;

	_direction = (_direction + 1) % 360;
	_markerName setMarkerDirLocal _direction;
	_markerName setMarkerSizeLocal [_markerSize,_markerSize];

	if (_markerSize > 1.2) then {_expand = false};
	if (_markerSize < 1) then {_expand = true};
	if (_expand) then {_markerSize = _markerSize + 0.02} else {_markerSize = _markerSize - 0.02};
};

deleteMarkerLocal _markerName;
if (_additionalErase != "") then {deleteMarkerLocal _additionalErase};