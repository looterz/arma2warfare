#include "profiler.h"
PROFILER_BEGIN("Server_HandleEmptyVehicle");

waitUntil { !(isNil "EmptyVehicleService_AddVehicle") };
_this call EmptyVehicleService_AddVehicle;