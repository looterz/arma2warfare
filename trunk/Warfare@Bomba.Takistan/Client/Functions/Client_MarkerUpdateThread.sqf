_fnUpdateALiveMarkers = {
private['_u', '_mygroup', '_text', '_amount', '_val', '_val2', '_ainumber', '_visible', '_timeout', '_marker', '_tracked', '_markerName', '_dirty', '_trackDeath', '_deathMarkerType', '_deathMarkerColor', '_deathMarkerSize' ];

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

	_mygroup = group player;
	_dirty = false;
	_u = count WBE_TrackedMarkerList;
	while { !(_u == 0) } do {
			_u = _u - 1;
			
			_marker = WBE_TrackedMarkerList select _u;

			_markerName = _marker select 4;
			_tracked = _marker select 5;
			
			if (alive _tracked && !(isNull _tracked)) then {
				
				_condition = _marker select 13; 
				_visible = if (isNil "_condition") then { true } else { (_tracked) call _condition; };
				
				if ( _visible ) then {
					_markerName setMarkerAlphaLocal 1;
					_markerName setMarkerPosLocal (getPos _tracked);
				
					if (group _tracked == _mygroup && (_tracked isKindOf "Man")) then {
					
						_markerText = _marker select 3;
						if (_markerText == "" || _markerText == "TE") then {
							
							_markerText = toArray(str _tracked);
							_amount = count _markerText;
							_val = _markerText select (_amount-2);
							_val2 = _markerText select (_amount-1);
							_ainumber = if (_val == 58) then {[_val2]} else {[_val, _val2]};
							_markerText = toString(_ainumber);
							
							_marker set[3, _markerText];
							_markerName setMarkerTextLocal _markerText;							
						};
					};		
				} else {
					_markerName setMarkerAlphaLocal 0;
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
					WBE_TrackDeadMarkers = WBE_TrackDeadMarkers + [ [_markerName, _timeout] ];
				} else {
					WBE_TrackDeadMarkers = WBE_TrackDeadMarkers + [ [_markerName, 0] ];
				};
			};
	};
	
	if (_dirty) then {
		WBE_TrackedMarkerList = WBE_TrackedMarkerList - [ objNull ];
	};
};

_fnUpdateDeadMarkers = {
private['_dirty', '_u', '_deadMarker', '_timeout', '_markerName'];
	_dirty = false;
	_u = count WBE_TrackDeadMarkers;
	while { !(_u == 0) } do {
		_u = _u - 1;
		
		_deadMarker = WBE_TrackDeadMarkers select _u;
		_timeout = _deadMarker select 1;
		if (_timeout < time) then {
			
			_markerName = _deadMarker select 0;
			deleteMarkerLocal _markerName;
			
			WBE_TrackDeadMarkers set [_u, objNull];
			_dirty = true;
		};
	};
	
	if (_dirty) then {
		WBE_TrackDeadMarkers = WBE_TrackDeadMarkers - [ objNull ];
	};
};

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
