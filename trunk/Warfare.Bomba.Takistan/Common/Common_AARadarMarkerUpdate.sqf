#include "profiler.h"
PROFILER_BEGIN("Common_AARadarMarkerUpdate");

Private ["_markerType", "_markerColor", "_markerSize", "_markerText", "_markerName", "_tracked", "_refreshRate", "_trackDeath", "_deathMarkerType", "_deathMarkerColor", "_deletePrevious", "_side", "_deathMarkerSize", "_markerInfo" ];

	if (!(local player)) exitWith {
		PROFILER_END();
	};

	_tracked 		  = _this select 0;
	_side		      = _this select 1;

	if (_side == side player || isNull _tracked || !(alive _tracked)) exitWith {
		PROFILER_END();
	};	
	
	waitUntil {commonInitComplete && !isNil "MarkerUpdateConditionAntiAir" };
	
	unitMarker = unitMarker + 1;

	_markerType 	  = "Vehicle";
	_markerColor 	  = "ColorRed";
	_markerSize 	  = [5,5];
	_markerText 	  = "";
	_markerName 	  = Format ["unitMarker%1", unitMarker];
	_tracked 		  = _this select 0;
	_refreshRate 	  = 1;
	_trackDeath 	  = false;
	_deathMarkerType  = objNull;
	_deathMarkerColor = objNull;
	_deletePrevious   = false;
	_side		      = side player; // just for compability 
	_deathMarkerSize  = objNull;

	_markerInfo = [_markerType, _markerColor, _markerSize, _markerText, _markerName, _tracked, _refreshRate, _trackDeath, _deathMarkerType, _deathMarkerColor, _deletePrevious, _side, _deathMarkerSize, MarkerUpdateConditionAntiAir];

	waitUntil { !isNil "TrackMapMarkerAdd" };
	_markerInfo call TrackMapMarkerAdd;
PROFILER_END();