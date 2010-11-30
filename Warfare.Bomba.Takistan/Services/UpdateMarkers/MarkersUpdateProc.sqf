Private ["_nextMarkerUpdate"];

	if (!(local player)) exitWith {
		"Client_MarkerUpdateThread Ended with reason: Execute on dedicated server does not required." call LogMedium;
	};

	WFBE_ANTIAIRRADARDETECTION = 'WFBE_ANTIAIRRADARDETECTION' Call GetNamespace;
	MarkerUpdateConditionAntiAir = { antiAirRadarInRange && (((getPos _this) select 2) > WFBE_ANTIAIRRADARDETECTION) };
	MarkerUpdateConditionCommon  = { true };
	
	waitUntil {commonInitComplete};

	WBE_TrackDeadMarkers = [];
	WBE_TrackedMarkerList = [];

	_nextMarkerUpdate = 0;
	while { !gameOver } do {
		
		sleep 2.5;
		if (visibleMap || _nextMarkerUpdate < time) then {
			[] call _fnUpdateALiveMarkers;
			[] call _fnUpdateDeadMarkers;
			
			_nextMarkerUpdate = time + 60;
		};
	};
