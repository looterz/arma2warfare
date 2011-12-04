private['_defence', '_defenceInfo', '_markerName', '_lastcontact', '_crew'];
_defence = _this;
	_defenceInfo = [WF_DefenceTypeList, { (_x select DEFENCEINFO_TYPENAME) == typeof(_defence) } ] call getFirstOrDefault;
	if (!(_defenceInfo select DEFENCEINFO_WEAPONTYPE)) exitWith {};
	
	if (isNil "DefenceContactNotification") then {
		DefenceContactNotification = 0;
	};
	
	DefenceMarkerIdCounter = DefenceMarkerIdCounter + 1;
	_markerName = format["defence%1", DefenceMarkerIdCounter];

	createMarkerLocal [_markerName, position _defence];
	
	_markerName setMarkerTypeLocal  "mil_dot";
	_markerName setMarkerShapeLocal "ICON";		
	_markerName setMarkerColorLocal "ColorBlack"; 
	_markerName setMarkerAlphaLocal 0.25;
	_markerName setMarkerSizeLocal [0.5,0.5];
	
	_defence setVariable["markerId", _markerName];
	_defence setVariable["LastContact", 0];

	_defence addEventHandler["Fired", {
		private['_defence', '_lastcontact', '_markerName'];

		_defence = _this select 0;
		if ((vehicle player) == _defence) exitWith {};
	
		if (DefenceContactNotification == 0) then {
			hint "Contact!";
		};
		
		_lastcontact = _defence getVariable "LastContact";
		if (_lastcontact == 0) then {
			_markerName = _defence getVariable "markerId";
			_markerName setMarkerColorLocal "ColorYellow";
			_markerName setMarkerSizeLocal [1, 1];
			DefenceContactNotification = DefenceContactNotification + 1;
		};
		
		_defence setVariable["LastContact", time];
	}];
	
	while { alive _defence } do {
		_markerName setMarkerPosLocal (position _defence);
		_lastcontact = _defence getVariable "LastContact";
		if (_lastcontact > 0 && (_lastcontact + 10) < time) then {
			_markerName setMarkerColorLocal "ColorGreen";
			_markerName setMarkerSizeLocal [0.5,0.5];
			_defence setVariable["LastContact", 0];
			if (DefenceContactNotification > 0) then {
				DefenceContactNotification = DefenceContactNotification - 1;
			};
		};
		
		_crew = { alive _x } count (crew _defence);		
		if (_lastcontact == 0 && _crew > 0 ) then {
			_markerName setMarkerColorLocal "ColorGreen";
			_markerName setMarkerAlphaLocal 1;
		};	

		if ( _crew == 0 ) then {
			_markerName setMarkerColorLocal "ColorBlack";
			_markerName setMarkerAlphaLocal 0.25;
		};		
		
		sleep 15;
	};
	
	deleteMarkerLocal _markerName;
