#include "profiler.h"
PROFILER_BEGIN("Service_HandleEmptyVehicle");

Private ["_exit","_reset","_timer","_trash","_vehicle"];

	_vehicle = _this;

	if (isNil "_vehicle") exitWith { PROFILER_END(); };
	if (isNull _vehicle)  exitWith { PROFILER_END(); };

	waitUntil { !(isNil "WBE_HandleEmptyVehicleOperation") };

	WBE_HandleEmptyVehicleOperation =WBE_HandleEmptyVehicleOperation + [ [_vehicle, time + WFBE_EMPTYVEHICLETIMER] ];

PROFILER_END();