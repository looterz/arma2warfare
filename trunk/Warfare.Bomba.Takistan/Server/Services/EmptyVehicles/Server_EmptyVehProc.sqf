#include "profiler.h"
PROFILER_BEGIN("Server_EmptyVehProc");

private['_dirty', '_u', '_vehicleInfo', '_vehicle', '_timeout'];

	_dirty = false;
	_u = count WBE_HandleEmptyVehicleCollection;
	while { !(_u == 0) } do {
		_u = _u - 1;
		
		_vehicleInfo = WBE_HandleEmptyVehicleCollection select _u;
		_vehicle = _vehicleInfo select 0;
		_timeout = 0;
		
		if (!(isNull _vehicle)) then {
			
			if (alive _vehicle) then {
				_timeout = _vehicleInfo select 1;				
				
				if ( _timeout == 0 || !(_vehicle call EmptyVehicleIsEmpty) ) then {
					_timeout = time + WFBE_EMPTYVEHICLETIMER;
					_vehicleInfo set [1, _timeout];
				};
			};
			
			if (_timeout < time) then {
			
				if (alive _vehicle) then {
					if (someAmmo _vehicle) then {_vehicle setVehicleAmmo 0};
					_vehicle setDammage 1;				
				};
			
				WBE_HandleEmptyVehicleQueu = WBE_HandleEmptyVehicleQueu - [_vehicle];
				_vehicle spawn TrashObject;
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
		WBE_HandleEmptyVehicleQueu = WBE_HandleEmptyVehicleQueu - [ objNull ];
	};
PROFILER_END();