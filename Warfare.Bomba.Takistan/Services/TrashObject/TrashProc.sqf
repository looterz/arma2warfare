#include "profiler.h"

private['_isArrayDirty', '_u', '_trashItem', '_timeout', '_i', '_body', '_force'];
PROFILER_BEGIN("Service_TrashProc");

	_isArrayDirty = false;
	
	if (count WBE_TrashObjectOperation != 0) then {		//-- copy from operation buffer to processing
		_tmp = WBE_TrashObjectOperation;
		WBE_TrashObjectOperation = [];
		WBE_TrashObjectCollection = WBE_TrashObjectCollection + _tmp;
	};
	
	_u = count WBE_TrashObjectCollection;
	
	if ( _u > 10 && diag_fps < 20 ) then {
	
		format["Service_TrashProc: trash queue=%1, but low fps (%2) - force delete dead vehicles and bodies", _u, diag_fps] call LogHigh;
		_i = floor(_u / 2);
		while { _i != 0 } do {
			_i = _i - 1;
			_trashItem = WBE_TrashObjectCollection select _i;
			_body  = _trashItem select 0;
			if (!isNull _body) then {
				deleteVehicle _body;
			};
			WBE_TrashObjectCollection set[ _i, objNull ];
			sleep 0.005;
		};
		WBE_TrashObjectCollection = WBE_TrashObjectCollection - [ objNull ];
		_u = count WBE_TrashObjectCollection;
	};
	
	format["Service_TrashProc: trash queue=%1", _u] call LogHigh;
	
	_i = 0;
	while { _u != 0 } do {
		_u = _u - 1;
		
		_trashItem = WBE_TrashObjectCollection select _i;
		_timeout = _trashItem select 1;
		
		if (_timeout < time) then {

			if ( (_trashItem call TrashDeleteObject) ) then {
				WBE_TrashObjectCollection set[ _i, objNull ];
				_isArrayDirty = true;
			};
			_i = _i + 1;
		} else {
			_u = 0;		// if we reach point where unit still wait respawn, no need lookup more
		};
		sleep 0.005;
	};
	
	if (_isArrayDirty) then {
		WBE_TrashObjectCollection = WBE_TrashObjectCollection - [ objNull ];
	};
	
PROFILER_END();	