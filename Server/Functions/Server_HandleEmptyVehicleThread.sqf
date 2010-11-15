#include "profiler.h"
Private ["_period","_timeoutAbadonVehicle"];

waitUntil {commonInitComplete};

WBE_HandleEmptyVehicleList = [];
WBE_HandleEmptyVehicleQueu = [];
_timeoutAbadonVehicle = 'WFBE_ABANDONVEHICLETIMER' Call GetNamespace;

_fnIsVehicleEmpty = {
private['_vehicle', '_empty'];

	_vehicle = _this;
	_empty = true;
	{ if (alive _x) then { _empty = false; } } forEach Crew _vehicle;
	
	_empty;
};

_fnHandleEmptyVehicles = {
private['_dirty', '_u', '_vehicleInfo', '_vehicle', '_timeout'];

	_dirty = false;
	_u = count WBE_HandleEmptyVehicleList;
	while { !(_u == 0) } do {
		_u = _u - 1;
		
		_vehicleInfo = WBE_HandleEmptyVehicleList select _u;
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
				WBE_HandleEmptyVehicleList set [_u, objNull ];	
				_dirty = true;
			};
		} else {
			WBE_HandleEmptyVehicleList set [_u, objNull ];
			_dirty = true;
		};
	};
	
	if (_dirty) then {
		WBE_HandleEmptyVehicleList = WBE_HandleEmptyVehicleList - [ objNull ];
		WBE_HandleEmptyVehicleQueu = WBE_HandleEmptyVehicleQueu - [ objNull ];
	};
};

_period = 10;
while { !gameOver } do {
	sleep _period;
	[] call _fnHandleEmptyVehicles;
};