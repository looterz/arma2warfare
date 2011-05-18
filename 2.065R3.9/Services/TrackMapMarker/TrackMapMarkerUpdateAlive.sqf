#include "profiler.h"
PROFILER_BEGIN("Service_TrackMapMarkerUpdateAlive");

private['_u', '_traced', '_mygroup', '_newDeadMarkers', '_text', '_amount', '_val', '_val2', '_ainumber', '_visible', '_timeout', '_marker', '_tracked', '_markerName', '_dirty', '_trackDeath', '_deathMarkerType', '_deathMarkerColor', '_deathMarkerSize' ];

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

	_newDeadMarkers = [];
	_mygroup = group player;
	_dirty = false;
	_u = count WBE_TrackedMarkerList;
	_traced = 50;
	while { _u != 0 } do {
		_u = _u - 1;
	
		_marker = WBE_TrackedMarkerList select _u;
		_markerName = _marker select 4;
		_tracked = _marker select 5;
				
		if (alive _tracked && !(isNull(_tracked)) ) then {
			
			_condition = _marker select 13; 
			_visible = true;
			if (!(isNil "_condition")) then { 
				_visible = (_tracked) call _condition;
				
				if (_visible) then {
					_markerName setMarkerAlphaLocal 1;
				} else {
					_markerName setMarkerAlphaLocal 0;				
				};
			};
			
			if ( _visible ) then {
				
				_markerName setMarkerPosLocal (getPos _tracked);
			
				if (group _tracked == _mygroup) then {					
					if (_tracked isKindOf "Man") then {
						_marker spawn TrackMapMarkerSetName;
					};
				};		
			};
		} else {
			
			WBE_TrackedMarkerList set[ _u, objNull ];
			_dirty = true;
			
			_trackDeath = _marker select 7;
			if (_trackDeath) then {
					
				_deathMarkerType = _marker select 8;
				_deathMarkerColor = _marker select 9;
				_deathMarkerSize = _marker select 12;
					
				_markerName setMarkerTypeLocal _deathMarkerType;
				_markerName setMarkerColorLocal _deathMarkerColor;
				_markerName setMarkerSizeLocal _deathMarkerSize;
				
				_timeout = time + ('WFBE_MARKERDEADDELAY' Call GetNamespace);
				_newDeadMarkers = _newDeadMarkers + [ [_markerName, _timeout] ];
			} else {
				deleteMarkerLocal _markerName;
			};
		};
		
		_traced = _traced - 1;
		if (_traced == 0) then {
			_traced = 50;
			if (diag_fps < 20) then { sleep 0.1; };		
		};
	};
	
	if (count _newDeadMarkers != 0) then {
		WBE_TrackDeadMarkers = WBE_TrackDeadMarkers + _newDeadMarkers;
	};
	
	if (_dirty) then {
		WBE_TrackedMarkerList = WBE_TrackedMarkerList - [ objNull ];
	};

PROFILER_END();