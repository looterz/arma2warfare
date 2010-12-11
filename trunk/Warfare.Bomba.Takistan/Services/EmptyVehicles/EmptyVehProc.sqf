#include "profiler.h"
PROFILER_BEGIN("Service_EmptyVehProc");

private['_dirty', '_u', '_vehicleInfo', '_vehicle', '_timeout', '_tmp'];

	_dirty = false;
	
	if (count WBE_HandleEmptyVehicleOperation > 0) then {	// copy vehicles from operation buffer to processing buffer
		_tmp = WBE_HandleEmptyVehicleOperation;
		WBE_HandleEmptyVehicleOperation = [];
		WBE_HandleEmptyVehicleCollection = WBE_HandleEmptyVehicleCollection + _tmp;
	};
	
	_u = count WBE_HandleEmptyVehicleCollection;
	format["Service_EmptyVehProc: registered vehicle queue=%1", _u] call LogHigh;
	format["Service_EmptyVehProc: FPS=%1", diag_fps] call LogHigh;
	
#define LOG_STAT(side) _created = WF_Logic getVariable format["%1VehiclesCreated", ##side]; \
					   _lost    = WF_Logic getVariable format["%1VehiclesLost", ##side]; \
						if (isNil "_created") then { _created = 0; }; \
					    if (isNil "_lost") then { _lost = 0; }; \
						format["Service_EmptyVehProc: %1 Veh =%2 (%3 - %4)", ##side, _created - _lost, _created, _lost] call LogHigh;\
						_created = WF_Logic getVariable format["%1UnitsCreated", ##side];\
						_lost    = WF_Logic getVariable format["%1Casualties", ##side];\
						if (isNil "_created") then { _created = 0; }; \
					    if (isNil "_lost") then { _lost = 0; }; \
						format["Service_EmptyVehProc: %1 Units =%2 (%3 - %4)", ##side, _created - _lost, _created, _lost] call LogHigh;

	LOG_STAT("WEST");
	LOG_STAT("EAST");
	LOG_STAT("GUER");
	
	while { _u != 0 } do {
		_u = _u - 1;
		
		_vehicleInfo = WBE_HandleEmptyVehicleCollection select _u;
		_vehicle = _vehicleInfo select 0;
		
		if (!(isNull _vehicle)) then {
			
			_timeout = 0;
			if (alive _vehicle) then {
				_timeout = _vehicleInfo select 1;				
				
				if (_vehicle call EmptyVehicleIsEmpty) then {
				
					if (_timeout < time) then {
	
						// destroy vehicle
						if (someAmmo _vehicle) then {_vehicle setVehicleAmmo 0};
						_vehicle setDammage 1;				

						// register in trash dead vehicle
						_vehicle spawn TrashObject;
						WBE_HandleEmptyVehicleCollection set [_u, objNull ];
						_dirty = true;						
					};
				} else {
				
					_timeout = time + WFBE_EMPTYVEHICLETIMER;
					_vehicleInfo set [1, _timeout];
				};
			} else {
			
				_vehicle spawn TrashObject;		// register in trash dead vehicle
				WBE_HandleEmptyVehicleCollection set [_u, objNull ];			
				_dirty = true;						
			};
		} else {
			WBE_HandleEmptyVehicleCollection set [_u, objNull ];
			_dirty = true;
		};
	};
	
	if (_dirty) then {
		WBE_HandleEmptyVehicleCollection = WBE_HandleEmptyVehicleCollection - [ objNull ];
	};
PROFILER_END();