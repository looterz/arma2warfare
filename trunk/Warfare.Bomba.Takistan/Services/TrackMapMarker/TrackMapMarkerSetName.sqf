#include "profiler.h"
PROFILER_BEGIN("Service_TrackMapMarkerSetName");

private['_marker','_markerText','_amount','_val','_val2','_ainumber','_markerName','_tracked'];

	_marker = _this;
	_markerText = _marker select 3;
	if (_markerText == "" || _markerText == "TE") then {
		_tracked = _marker select 5;
		_markerText = toArray(str _tracked);
		_amount = count _markerText;
		_val = _markerText select (_amount-2);
		_val2 = _markerText select (_amount-1);
		_ainumber = if (_val == 58) then {[_val2]} else {[_val, _val2]};
		_markerText = toString(_ainumber);
		
		_marker set[3, _markerText];
		
		_markerName = _marker select 4;
		_markerName setMarkerTextLocal _markerText;	
	};

PROFILER_END();