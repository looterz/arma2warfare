#include "profiler.h"
PROFILER_BEGIN("Service_TrackMapMarkerProc");

Private ["_nextMarkerUpdate", "_tmp"];

	if (count WBE_TrackedMarkerListOperate > 0) then {
		_tmp = WBE_TrackedMarkerListOperate;
		WBE_TrackedMarkerListOperate = [];
		WBE_TrackedMarkerList = WBE_TrackedMarkerList + _tmp;
	};

	if (visibleMap || trackMapMarkerNext < time) then {
		
		format["Service_TrackMapMarkerProc: markers queue=%1", (count WBE_TrackedMarkerList)] call LogHigh;
		
		[] spawn TrackMapMarkerUpdateAlive;
		[] spawn TrackMapMarkerUpdateDead;
			
		trackMapMarkerNext = time + 60;
	};
	
PROFILER_END();
