#include "profiler.h"

WBE_TrashObjectCollection = [];
WBE_TrashObjectCollectionQueu = [];

_timeoutUnitRemoveDelay = 'WFBE_UNITREMOVEDLAY' Call GetNamespace;

_fnHideBody = {
private["_object", '_group', '_get', '_alive'];
PROFILER_BEGIN("Server_TrashObjectThread::HideBody");

	_object = _this;
	_group = group _object;
	_get = _group getVariable 'funds';
	if (isNil '_get') then {
		_alive = units _group Call GetLiveUnits;
		if ( (count _alive) == 0) then {
			deleteGroup _group;
		};
	};
	hideBody _object;
	
PROFILER_END();	
};

_fnDeleteObject = {
private["_trashItem", '_object', '_canDelete', '_isDeleted'];
PROFILER_BEGIN("Server_TrashObjectThread::DeleteObject");

	_isDeleted = false;
	_trashItem = _this;

	_object  = _trashItem select 0;
	_canDelete = _trashItem select 2;
	
	if (!(isNull _object)) then {
		if ( (_object isKindOf "Man") ) then {
			
			if (_canDelete == 0) then {
				"ProcessTrashItemList: Hide Body" call LogHigh;
				_object call _fnHideBody;							
				_trashItem set [1, time + 6];	// add time for hide body;
				_trashItem set [2, 1];			// set flag that now we can delete body							
			};						
		} else {
			_canDelete = 1;
		};
		
		if (_canDelete == 1) then {
		
			WBE_TrashObjectCollectionQueu = WBE_TrashObjectCollectionQueu - [_object];
			"ProcessTrashItemList: Delete Body" call LogHigh;
			deleteVehicle _object;
			_isDeleted = true;
		};
	} else {
		_isDeleted = true;
	};	
	
PROFILER_END();	
	_isDeleted;
};

_fnProcessTrashItemCollection = {
private['_isArrayDirty', '_u', '_trashItem', '_timeout'];
PROFILER_BEGIN("Server_TrashObjectThread::ProcessTrashItemCollection");

	_isArrayDirty = false;
	_u = count WBE_TrashObjectCollection;
	
	while { !(_u == 0) } do {
		_u = _u - 1;
		
		_trashItem = WBE_TrashObjectCollection select _u;
		_timeout = _trashItem select 1;
		
		if (_timeout == 0) then {
			_timeout = time + _timeoutUnitRemoveDelay;
			_trashItem set [1, _timeout];			
		};		
		
		if (_timeout < time) then {

			if ( (_trashItem call _fnDeleteObject) ) then {
				WBE_TrashObjectCollection set[ _u, objNull ];
				_isArrayDirty = true;
			};
		};
	};
	
	if (_isArrayDirty) then {
		WBE_TrashObjectCollection = WBE_TrashObjectCollection - [ objNull ];
		WBE_TrashObjectCollectionQueu = WBE_TrashObjectCollectionQueu - [ objNull ];
	};
	
PROFILER_END();	
};

while { !gameOver } do {
	
	sleep 10;
	[] call _fnProcessTrashItemCollection;
};