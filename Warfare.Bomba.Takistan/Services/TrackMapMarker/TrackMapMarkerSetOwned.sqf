#include "profiler.h"
PROFILER_BEGIN("Service_TrackMapMarkerSetOwned");

private['_unit','_marker','_timeout','_initDone','_markername'];

	//--- _markerType 	    = _marker select 0;
	//--- _markerColor 	    = _marker select 1;
	//--- _markerSize 	    = _marker select 2;
	//--- _markerText 	    = _marker select 3;
	//--- _markerName 	    = _marker select 4;
	//--- _tracked 		    = _marker select 5;
	//--- _refreshRate 	    = _marker select 6;
	//--- _trackDeath 	    = _marker select 7;
	//--- _deathMarkerType  = _marker select 8;
	//--- _deathMarkerColor = _marker select 9;
	//--- _deletePrevious   = _marker select 10;
	//--- _side			    = _marker select 11;
	//--- _deathMarkerSize  = _marker select 12;
	//--- _condition        = _marker select 13;

	_unit = _this;
	
	format["TrackMapMarkerSetOwned: %1", _unit] call LogHigh;
	
	_timeout = time + 15;
	_initDone = false;
	while { !_initDone && time < _timeout } do {
		
		_marker = _unit call TrackMapMarkerGet;		
		format["TrackMapMarkerSetOwned: %1, marker:%2", _unit, _marker] call LogHigh;		
		if (!isNil "_marker") then {
			_markerName = _marker select 4;
			_markerName setMarkerColorLocal "ColorOrange";
			_initDone = true;
		} else {
			sleep 1;
		};
	};	
	
	if ( !_initDone ) then {
		format["TrackMapMarkerSetOwned: %1, marker:%2", _unit, _marker] call LogHigh;
	};

PROFILER_END();