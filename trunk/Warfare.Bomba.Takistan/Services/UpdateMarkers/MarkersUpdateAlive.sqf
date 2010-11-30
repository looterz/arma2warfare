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
