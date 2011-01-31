#include "profiler.h"
PROFILER_BEGIN("Common_GetSideUpgrades");

	private['_sideId'];
	_sideId = (_this) call GetSideID;
	if (_sideId == WESTID) exitWith {
		PROFILER_END();
		WESTUpgrades;
	};

	if (_sideId == EASTID) exitWith {
		PROFILER_END();
		EASTUpgrades;
	};
	format["Common_GetSideUpgrades unknown side: '%1'", _side] call LogError;
	
PROFILER_END();