#include "profiler.h"
PROFILER_BEGIN("Server_HandleEmptyVehicle");

Private ["_exit","_reset","_timer","_trash","_vehicle"];

_vehicle = _this;

if (isNil "_vehicle") exitWith { PROFILER_END(); };
if (isNull _vehicle)  exitWith { PROFILER_END(); };

waitUntil { !(isNil "WBE_HandleEmptyVehicleList") };

if ( !(_vehicle in WBE_HandleEmptyVehicleQueu) ) then {
	WBE_HandleEmptyVehicleQueu = WBE_HandleEmptyVehicleQueu + [ _vehicle ];
	WBE_HandleEmptyVehicleList = WBE_HandleEmptyVehicleList + [ [_vehicle, 0] ];
};

PROFILER_END();