#include "profiler.h"
PROFILER_BEGIN("Server_HandleEmptyVehicle");

Private ["_exit","_reset","_timer","_trash","_vehicle"];

	_vehicle = _this;

	if (isNil "_vehicle") exitWith { PROFILER_END(); };
	if (isNull _vehicle)  exitWith { PROFILER_END(); };

	waitUntil { !(isNil "WBE_HandleEmptyVehicleCollection") };

	if ( !(_vehicle in WBE_HandleEmptyVehicleQueu) ) then {
		WBE_HandleEmptyVehicleQueu = WBE_HandleEmptyVehicleQueu + [ _vehicle ];
		WBE_HandleEmptyVehicleCollection = WBE_HandleEmptyVehicleCollection + [ [_vehicle, 0] ];
	};

PROFILER_END();