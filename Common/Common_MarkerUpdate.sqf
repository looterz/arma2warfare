#include "profiler.h"
PROFILER_BEGIN("Common_MarkerUpdate");

Private ["_deathMarkerColor","_deathMarkerSize","_deathMarkerType","_delete","_deletePrevious","_markerColor","_markerName","_markerSize","_markerType","_markerText","_refreshRate","_trackDeath","_tracked","_side"];

if (!(local player)) exitWith {
	PROFILER_END();
};

waitUntil {commonInitComplete && !isNil "WBE_TrackedMarkerList" };

_markerType = _this select 0;
_markerColor = _this select 1;
_markerSize = _this select 2;
_markerText = _this select 3;
_markerName = _this select 4;
_tracked = _this select 5;
_deletePrevious = _this select 10;
_side = _this select 11;

if (_side != side player || isNull _tracked || !(alive _tracked)) exitWith {
	PROFILER_END();
};
if (_deletePrevious) then {	
	deleteMarkerLocal _markerName;
};

createMarkerLocal [_markerName,getPos _tracked];
if (_markerText != "") then {	
	_markerName setMarkerTextLocal _markerText
};
_markerName setMarkerTypeLocal _markerType;
_markerName setMarkerColorLocal _markerColor;
_markerName setMarkerSizeLocal _markerSize;

WBE_TrackedMarkerList = WBE_TrackedMarkerList + [ _this ];
PROFILER_END();