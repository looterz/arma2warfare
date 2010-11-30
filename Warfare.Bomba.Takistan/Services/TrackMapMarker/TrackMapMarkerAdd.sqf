#include "profiler.h"
PROFILER_BEGIN("Service_TrackMapMarkerAdd");

Private ["_countArgs", "_markerType", "_markerColor", "_markerSize", "_markerText", "_markerName", "_tracked", "_refreshRate", "_trackDeath", "_deathMarkerType", "_deathMarkerColor", "_deletePrevious", "_side", "_deathMarkerSize", "_condition", "_markerInfo" ];

	if (!(local player)) exitWith {
		PROFILER_END();
	};

	_tracked 		  = _this select 5;
	_side			  = if (_countArgs >= 11) then { _this select 11 } else { "ANY" };

	if (_side != side player || isNull _tracked || !(alive _tracked)) exitWith {
		PROFILER_END();
	};

	_countArgs		  = count _this;
	_markerType 	  = _this select 0;
	_markerColor 	  = _this select 1;
	_markerSize 	  = _this select 2;
	_markerText 	  = _this select 3;
	_markerName 	  = _this select 4;
	_refreshRate 	  = if (_countArgs >=  6) then { _this select  6 } else { 10 };
	_trackDeath 	  = if (_countArgs >=  7) then { _this select  7 } else { false };
	_deathMarkerType  = if (_countArgs >=  8) then { _this select  8 } else { objNull };
	_deathMarkerColor = if (_countArgs >=  9) then { _this select  9 } else { objNull };
	_deletePrevious   = if (_countArgs >= 10) then { _this select 10 } else { true  };
	_deathMarkerSize  = if (_countArgs >= 12) then { _this select 12 } else { [1,1] };
	
	if (_deletePrevious) then {	
		deleteMarkerLocal _markerName;
	};

	createMarkerLocal [_markerName, getPos _tracked];
	_markerName setMarkerAlphaLocal 0;
	_markerName setMarkerTypeLocal  _markerType;
	_markerName setMarkerColorLocal _markerColor;
	_markerName setMarkerSizeLocal  _markerSize;

	if (_markerText != "") then {	
		_markerName setMarkerTextLocal _markerText;
	};

	_markerInfo = [_markerType, _markerColor, _markerSize, _markerText, _markerName, _tracked, _refreshRate, _trackDeath, _deathMarkerType, _deathMarkerColor, _deletePrevious, _side, _deathMarkerSize, MarkerUpdateConditionCommon];
	
	if (_countArgs >= 13) then {
	
		_condition = _this select 13;
		if ( !(isNil "_condition") ) then {
		
			_markerInfo set[13, _condition];
			format["MarkerUpdate: Set Condition condition=%1", _condition] call LogHigh;
		};
	};	
	
	waitUntil { !isNil "WBE_TrackedMarkerListOperate" };
	WBE_TrackedMarkerListOperate = WBE_TrackedMarkerListOperate + [ _markerInfo ];
PROFILER_END();