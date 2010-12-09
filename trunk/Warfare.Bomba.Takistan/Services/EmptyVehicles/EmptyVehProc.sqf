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
	
	//-- -------------------------------------------------
	_created = WF_Logic getVariable "WESTVehiclesCreated";
	_lost    = WF_Logic getVariable "WESTVehiclesLost";
	format["Service_EmptyVehProc: WEST Veh =%1 (%2 - %3)", _created - _lost, _created, _lost] call LogHigh;

	_created = WF_Logic getVariable "WESTUnitsCreated";
	_lost    = WF_Logic getVariable "WESTCasualties";
	format["Service_EmptyVehProc: WEST Units =%1 (%2 - %3)", _created - _lost, _created, _lost] call LogHigh;

	//-- -------------------------------------------------
	_created = WF_Logic getVariable "EASTVehiclesCreated";
	_lost    = WF_Logic getVariable "EASTVehiclesLost";
	format["Service_EmptyVehProc: EAST Veh =%1 (%2 - %3)", _created - _lost, _created, _lost] call LogHigh;

	_created = WF_Logic getVariable "EASTUnitsCreated";
	_lost    = WF_Logic getVariable "EASTCasualties";
	format["Service_EmptyVehProc: EAST Units =%1 (%2 - %3)", _created - _lost, _created, _lost] call LogHigh;

	//-- -------------------------------------------------
	_created = WF_Logic getVariable "GUERVehiclesCreated";
	_lost    = WF_Logic getVariable "GUERVehiclesLost";
	format["Service_EmptyVehProc: GUER Veh =%1 (%2 - %3)", _created - _lost, _created, _lost] call LogHigh;

	_created = WF_Logic getVariable "GUERUnitsCreated";
	_lost    = WF_Logic getVariable "GUERCasualties";
	format["Service_EmptyVehProc: GUER Units =%1 (%2 - %3)", _created - _lost, _created, _lost] call LogHigh;

	
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