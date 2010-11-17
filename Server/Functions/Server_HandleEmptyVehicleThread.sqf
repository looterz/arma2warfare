#include "profiler.h"
Private ["_period","_timeoutAbadonVehicle"];

waitUntil {commonInitComplete};

WBE_HandleEmptyVehicleCollection = [];
WBE_HandleEmptyVehicleQueu = [];
_timeoutAbadonVehicle = 'WFBE_ABANDONVEHICLETIMER' Call GetNamespace;

_fnIsVehicleEmpty = {
private['_vehicle', '_empty'];
PROFILER_BEGIN("Server_HandleEmptyVehicle::IsVehicleEmpty");

	_vehicle = _this;
	_empty = true;
	{ if (alive _x) then { _empty = false; } } forEach Crew _vehicle;
	
PROFILER_END();	
	_empty;
};

_fnProcessEmptyVehicleCollection = {
private['_dirty', '_u', '_vehicleInfo', '_vehicle', '_timeout'];
PROFILER_BEGIN("Server_HandleEmptyVehicle::ProcessEmptyVehicleCollection");

	_dirty = false;
	_u = count WBE_HandleEmptyVehicleCollection;
	while { !(_u == 0) } do {
		_u = _u - 1;
		
		_vehicleInfo = WBE_HandleEmptyVehicleCollection select _u;
		_vehicle = _vehicleInfo select 0;
		_timeout = _vehicleInfo select 1;
		
		if (!(isNull _vehicle)) then {
			
			if (alive _vehicle) then {
				
				if ( _timeout == 0 || !(_vehicle call _fnIsVehicleEmpty) ) then {
					_timeout = time + _timeoutAbadonVehicle;
					_vehicleInfo set [1, _timeout];
				};
			} else {
				_timeout = 0;
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
};

_period = 10;
while { !gameOver } do {
	sleep _period;
	[] call _fnProcessEmptyVehicleCollection;
};