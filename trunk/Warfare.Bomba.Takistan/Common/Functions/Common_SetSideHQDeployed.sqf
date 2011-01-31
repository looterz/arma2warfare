#include "profiler.h"
PROFILER_BEGIN("Common_SetSideHQDeployed");

private["_sideId"];
// [sideId, deployState, _mhqVehicle]

_sideId = (_this select 0) call GetSideID;
if (_sideId == WESTID) exitWith {
	PROFILER_END();
	WESTMHQ = (_this select 2);
	publicVariable 'WESTMHQ';
	
	WESTMHQDeployed = (_this select 1);
	publicVariable 'WESTMHQDeployed';
};

if (_sideId == EASTID) exitWith {
	PROFILER_END();
	EASTMHQ = (_this select 2);
	publicVariable 'EASTMHQ';

	EASTMHQDeployed = (_this select 1);
	publicVariable 'EASTMHQDeployed';
};

format["Common_SetSideHQDeployed unknown side: '%1'", _this] call LogError;
PROFILER_END();