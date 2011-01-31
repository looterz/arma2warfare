#include "profiler.h"
PROFILER_BEGIN("Common_GetSideID");

private["_sideId"];
	_sideId = -1;

	switch(_this) do {
		case west  : { _sideId = WESTID; };
		case "WEST": { _sideId = WESTID; };
		case WESTID: { _sideId = WESTID; };
		
		case east: { _sideId = EASTID; };
		case "EAST": { _sideId = EASTID; };
		case EASTID: { _sideId = EASTID; };
		
		case resistance: { _sideId = RESISTANCEID; };
		case "RESISTANCE": { _sideId = RESISTANCEID; };
		case RESISTANCEID: { _sideId = RESISTANCEID; };
		default {
			format["Common_GetSideID: Unknown side variable: %1", _this] call LogError;		
		};
	};

PROFILER_END();
_sideId;