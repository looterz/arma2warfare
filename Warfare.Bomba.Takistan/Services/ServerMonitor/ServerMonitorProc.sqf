private['_created','_lost'];

#include "profiler.h"
PROFILER_BEGIN("Service_ServerMonitorProc");

	diag_log format["----------------------------------------"];
	diag_log format["ServerMonitor: Time %1", time];
	diag_log format["ServerMonitor: FPS=%1", diag_fps];
	diag_log format["ServerMonitor: Managed Units: %1", (count ManagedUnitList)];
	diag_log format["ServerMonitor: Managed EmptyVehicles: %1", (count WBE_HandleEmptyVehicleCollection)];
	diag_log format["ServerMonitor: Managed TrashObjects: %1", (count WBE_TrashObjectCollection)];	
	diag_log format["ServerMonitor: AISquadRespawn: %1", (count WBE_AISQUAD_RESPAWN)];	
	
	#define LOG_STAT(side) \
		_created = WF_Logic getVariable format["%1VehiclesCreated", ##side]; \
		_lost    = WF_Logic getVariable format["%1VehiclesLost", ##side]; \
		if (isNil "_created") then { _created = 0; }; \
		if (isNil "_lost") then { _lost = 0; }; \
		diag_log format["ServerMonitor: %1 Veh: %2 = +%3 -%4", ##side, _created - _lost, _created, _lost];\
		_created = WF_Logic getVariable format["%1UnitsCreated", ##side];\
		_lost    = WF_Logic getVariable format["%1Casualties", ##side];\
		if (isNil "_created") then { _created = 0; }; \
		if (isNil "_lost") then { _lost = 0; }; \
		diag_log format["ServerMonitor: %1 Units: %2 = +%3 -%4", ##side, _created - _lost, _created, _lost];

	LOG_STAT("WEST");
	LOG_STAT("EAST");
	LOG_STAT("GUER");

PROFILER_END();