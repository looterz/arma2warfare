#include "profiler.h"

private['_trashItem','_object','_canDelete','_isDeleted'];
PROFILER_BEGIN("Service_TrashDeleteObject");

	_isDeleted = false;
	_trashItem = _this;
	_object  = _trashItem select 0;
	
	if (!(isNull _object)) then {
		
		_canDelete = 1;
		if ( (_object isKindOf "Man") ) then {
				
			_canDelete = _trashItem select 2;
			if (_canDelete == 0) then {
				"Service_TrashDeleteObject: Hide Body" call LogHigh;
				_object spawn TrashHideBody;							
				_trashItem set [1, time + 6];	// add time for hide body;
				_trashItem set [2, 1];			// set flag that now we can delete body							
			};						
		};
		
		if (_canDelete == 1) then {
			"Service_TrashDeleteObject: Delete Body" call LogHigh;
			deleteVehicle _object;
			_isDeleted = true;
		};
	} else {
		_isDeleted = true;
	};	
	
PROFILER_END();	
_isDeleted;