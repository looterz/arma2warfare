#include "profiler.h"

private['_isArrayDirty', '_u', '_trashItem', '_timeout'];
PROFILER_BEGIN("Server_TrashExecute");

	_isArrayDirty = false;
	_u = count WBE_TrashObjectCollection;
	
	while { !(_u == 0) } do {
		_u = _u - 1;
		
		_trashItem = WBE_TrashObjectCollection select _u;
		_timeout = _trashItem select 1;
		
		if (_timeout == 0) then {
			_timeout = time + WFBE_UNITREMOVEDLAY;
			_trashItem set [1, _timeout];			
		} else {	

			if (_timeout < time) then {

				if ( (_trashItem call TrashDeleteObject) ) then {
					WBE_TrashObjectCollection set[ _u, objNull ];
					_isArrayDirty = true;
				};
			};
		};
	};
	
	if (_isArrayDirty) then {
		WBE_TrashObjectCollection = WBE_TrashObjectCollection - [ objNull ];
		WBE_TrashObjectCollectionQueu = WBE_TrashObjectCollectionQueu - [ objNull ];
	};
	
PROFILER_END();	