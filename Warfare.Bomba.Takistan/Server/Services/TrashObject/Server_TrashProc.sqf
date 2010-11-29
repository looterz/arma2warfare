#include "profiler.h"

private['_isArrayDirty', '_u', '_trashItem', '_timeout', '_i'];
PROFILER_BEGIN("Server_TrashProc");

	_isArrayDirty = false;
	_u = count WBE_TrashObjectCollection;
	
	format["Server_TrashProc: trash queue=%1", _u] call LogHigh;
	
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
		} else {
		
			_u = 0;		// if we reach point where unit still wait respawn, no need lookup more
		};
		
		_i = _i + 1;		
	};
	
	if (_isArrayDirty) then {
		WBE_TrashObjectCollection = WBE_TrashObjectCollection - [ objNull ];
	};
	
PROFILER_END();	