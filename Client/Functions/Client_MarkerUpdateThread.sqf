#include "profiler.h"
PROFILER_BEGIN("Client_MarkerUpdateThread");

Private ["_nextMarkerUpdate"];

if (!(local player)) exitWith {
	"Client_MarkerUpdateThread Ended with reason: Execute on dedicated server does not required." call LogMedium;
	PROFILER_END();
};

waitUntil {commonInitComplete};

WBE_TrackDeadMarkers = [];
WBE_TrackedMarkerList = [];

_fnUpdateALiveMarkers = {
private['_u', '_timeout', '_marker', '_tracked', '_markerName', '_isArrayDirty', '_trackDeath', '_deathMarkerType', '_deathMarkerColor', '_deathMarkerSize' ];

	_isArrayDirty = false;
	_u = count WBE_TrackedMarkerList;
	while { !(_u == 0) } do {
			_u = _u - 1;
			
			_marker = WBE_TrackedMarkerList select _u;
			_tracked = _marker select 5;
			_markerName = _marker select 4;
			
			if (alive _tracked && !(isNull _tracked)) then {
				_markerName setMarkerPosLocal (getPos _tracked);
			} else {
				
				WBE_TrackedMarkerList set[ _u, objNull ];
				_isArrayDirty = true;
				
				_trackDeath = _marker select 7;
				if (_trackDeath) then {
						
					_deathMarkerType = _marker select 8;
					_deathMarkerColor = _marker select 9;
					_deathMarkerSize = if (count _marker > 12) then { _marker select 12 } else { [1,1] };
						
					_markerName setMarkerTypeLocal _deathMarkerType;
					_markerName setMarkerColorLocal _deathMarkerColor;
					_markerName setMarkerSizeLocal _deathMarkerSize;
					
					_timeout = time + ('WFBE_MARKERDEADDELAY' Call GetNamespace);
					WBE_TrackDeadMarkers = WBE_TrackDeadMarkers + [ [_markerName, _timeout] ];
				} else {
					WBE_TrackDeadMarkers = WBE_TrackDeadMarkers + [ [_markerName, 0] ];
				};
			};
	};
	
	if (_isArrayDirty) then {
		WBE_TrackedMarkerList = WBE_TrackedMarkerList - [ objNull ];
	};
};

_fnUpdateDeadMarkers = {
private['_isArrayDirty', '_u', '_deadMarker', '_timeout', '_markerName'];
	_isArrayDirty = false;
	_u = count WBE_TrackDeadMarkers;
	while { !(_u == 0) } do {
		_u = _u - 1;
		
		_deadMarker = WBE_TrackDeadMarkers select _u;
		_timeout = _deadMarker select 1;
		if (_timeout < time) then {
			
			_markerName = _deadMarker select 0;
			deleteMarkerLocal _markerName;
			
			WBE_TrackDeadMarkers set [_u, objNull];
			_isArrayDirty = true;
		};
	};
	
	if (_isArrayDirty) then {
		WBE_TrackDeadMarkers = WBE_TrackDeadMarkers - [ objNull ];
	};
};

_nextMarkerUpdate = 0;
while { !gameOver } do {
	
	sleep 2.5;
	if (visibleMap || _nextMarkerUpdate < time) then {
		[] call _fnUpdateALiveMarkers;
		[] call _fnUpdateDeadMarkers;
		
		_nextMarkerUpdate = time + 60;
	};
};
