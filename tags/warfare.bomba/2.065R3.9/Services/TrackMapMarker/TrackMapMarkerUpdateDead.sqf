#include "profiler.h"
PROFILER_BEGIN("Service_TrackMapMarkerUpdateDead");

	private['_dirty', '_u', '_deadMarker', '_timeout', '_markerName'];
	
	_dirty = false;
	_u = count WBE_TrackDeadMarkers;
	while { _u != 0 } do {
		_u = _u - 1;
		
		_deadMarker = WBE_TrackDeadMarkers select _u;
		_timeout = _deadMarker select 1;
		if (_timeout < time) then {
			
			_markerName = _deadMarker select 0;
			deleteMarkerLocal _markerName;
			
			WBE_TrackDeadMarkers set [_u, objNull];
			_dirty = true;
		};
		if (diag_fps < 40) then { sleep 0.005; };
	};
	
	if (_dirty) then {
		WBE_TrackDeadMarkers = WBE_TrackDeadMarkers - [ objNull ];
	};
	
PROFILER_END();