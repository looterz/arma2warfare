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
						
						WBE_HandleEmptyVehicleCollection set [_u, objNull ];
						_dirty = true;						
					};
				} else {
				
					_timeout = time + WFBE_EMPTYVEHICLETIMER;
					_vehicleInfo set [1, _timeout];
				};
			} else {
				WBE_HandleEmptyVehicleCollection set [_u, objNull ];			
				_dirty = true;						
			};
		} else {
			WBE_HandleEmptyVehicleCollection set [_u, objNull ];
			_dirty = true;
		};
		sleep 0.005;
	};
	
	if (_dirty) then {
		WBE_HandleEmptyVehicleCollection = WBE_HandleEmptyVehicleCollection - [ objNull ];
	};
PROFILER_END();