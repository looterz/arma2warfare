#include "profiler.h"
PROFILER_BEGIN("Common_CreateVehicle");

private['_lock','_position','_side','_type','_vehicle','_markers','_placement','_special'];

	_type = _this select 0;
	_position = _this select 1;
	_side = _this select 2;
	_lock = _this select 3;

	_vehicle = objNull;
	if (count _this == 7) then { 	
		_markers = _this select 4;
		_placement = _this select 5;
		_special = _this select 6;		
		_vehicle = createVehicle [_type, _position, _markers, _placement, _special];
	} else {
		_vehicle = createVehicle [_type, _position, [], 0, ""];
	};

	if (_lock) then {
		_vehicle lock _lock;
	};
	
	if (_side != resistance) then {
		_vehicle setVehicleInit Format["[this,%1] ExecVM 'Common\Common_InitUnit.sqf';",_side];
		ProcessInitCommands;
	};
	
	[_vehicle, _side] spawn SetKilledEventHandler;
	[_vehicle, _side] spawn ManagedUnitAdd;
	
	Format["Common_CreateVehicle: A %1 '%2' vehicle has been created",str _side,_type] call LogInform;

PROFILER_END();
_vehicle;
