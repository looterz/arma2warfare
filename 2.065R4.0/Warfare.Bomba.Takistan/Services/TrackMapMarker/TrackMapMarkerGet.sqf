#include "profiler.h"
PROFILER_BEGIN("Service_TrackMapMarkerUpdateAlive");

private['_u', '_unit', '_markerData', '_marker', '_tracked' ];

	_unit = _this;
	_markerData = objNull;

	_u = count WBE_TrackedMarkerList;
	while { _u != 0 } do {
		_u = _u - 1;
	
		_marker = WBE_TrackedMarkerList select _u;
		_tracked = _marker select 5;
		
		if (_tracked == _unit) then {
			_markerData = _marker;
			_u = 0;
		};
	};
				
PROFILER_END();
_markerData;