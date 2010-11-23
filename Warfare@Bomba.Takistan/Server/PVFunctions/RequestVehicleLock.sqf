#include "profiler.h"
PROFILER_BEGIN("RequestVehicleLock");

Private["_client","_locked","_side","_vehicle"];

_vehicle = _this select 0;
_locked = _this select 1;

_vehicle lock _locked;

WFBE_SetVehicleLock = [nil,'CLTFNCSETVEHICLELOCK',[_vehicle,_locked]];
publicVariable 'WFBE_SetVehicleLock';
if (IsClientServer) then {[nil,'CLTFNCSETVEHICLELOCK',[_vehicle,_locked]] Spawn HandlePVF};

PROFILER_END();