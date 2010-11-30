	
	TrackMapMarkerAdd = Compile preprocessFile "Services\TrackMapMarker\TrackMapMarkerAdd.sqf";
	TrackMapMarkerProc = Compile preprocessFile "Services\TrackMapMarker\TrackMapMarkerProc.sqf";
	TrackMapMarkerUpdateAlive = Compile preprocessFile "Services\TrackMapMarker\TrackMapMarkerUpdateAlive.sqf";
	TrackMapMarkerUpdateDead = Compile preprocessFile "Services\TrackMapMarker\TrackMapMarkerUpdateDead.sqf";
	
	trackMapMarkerNext = time;
	
	WFBE_ANTIAIRRADARDETECTION = 'WFBE_ANTIAIRRADARDETECTION' Call GetNamespace;
	MarkerUpdateConditionAntiAir = { antiAirRadarInRange && (((getPos _this) select 2) > WFBE_ANTIAIRRADARDETECTION) };
	MarkerUpdateConditionCommon  = { true };
	
	waitUntil { commonInitComplete };
	WBE_TrackedMarkerList = [];
	WBE_TrackedMarkerListOperate = [];
	WBE_TrackDeadMarkers = [];

[TrackMapMarkerProc, 2.5];