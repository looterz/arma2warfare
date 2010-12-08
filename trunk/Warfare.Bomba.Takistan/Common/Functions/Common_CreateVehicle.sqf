#include "profiler.h"
PROFILER_BEGIN("Common_CreateVehicle");

Private ["_lock","_position","_side","_type","_vehicle"];

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
		_vehicle = _type createVehicle _position;
	};
	
	if (_side != resistance) then {
	
		_built = WF_Logic getVariable Format ["%1VehiclesCreated", _side];
		_built = _built + 1;
		WF_Logic setVariable [Format["%1VehiclesCreated", _side],_built,true];		
	
		_vehicle SetVehicleInit Format["[this,%1] ExecVM 'Common\Common_InitUnit.sqf';",_side];
		ProcessInitCommands;
		Call Compile Format ["_vehicle addEventHandler ['Killed',{[_this select 0,_this select 1,%1] Spawn UnitKilled}]",_side];
	} else {
		//--- Note To be optimized, 1.03 BIS BUG, cannot add resistance side via call compile format.
		_vehicle addEventHandler ["Killed",{[_this select 0,_this select 1,resistance] Spawn UnitKilled}];
	};
	
	if (_lock) then {
		_vehicle lock _lock;
	};
	
	_vehicle spawn HandleEmptyVehicle;
	Format["Common_CreateVehicle: A %1 '%2' vehicle has been created",str _side,_type] call LogInform;

PROFILER_END();
_vehicle;
