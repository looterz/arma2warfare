#include "profiler.h"
PROFILER_BEGIN("Service_TrashObject");

private['_object'];
_object = _this;

	if (isNil "_object") exitWith { PROFILER_END(); };
	if (isNull _object)  exitWith { PROFILER_END(); };

	if (!isServer) exitWith {		// add to trash on server if function called from client
		[NETSEND_MSGID_ADDTRASH, _object] spawn NetSend_ToServer;
		PROFILER_END();		
	};
	
	waitUntil { !(isNil "WBE_TrashObjectOperation") };
	WBE_TrashObjectOperation = WBE_TrashObjectOperation + [ [_object, (time + WFBE_UNITREMOVEDLAY), 0] ];

PROFILER_END();