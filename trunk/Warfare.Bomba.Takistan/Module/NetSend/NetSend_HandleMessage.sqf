#include "profiler.h"
PROFILER_BEGIN("NetSend_HandleMessage");

private['_data','_msgid'];
	
	if (typeName _this != 'ARRAY') exitWith {
		PROFILER_END();
	};
	
	_msgId   = _this select 0;
	_data = _this select 1;
	
	format["NetSend_HandleMessage: %1", _this] call LogHigh;

	switch (_msgId) do {
	
		case NETSEND_MSGID_BUYUNIT: 		{ _data spawn BuyUnit_HandleMessage; };
		case NETSEND_MSGID_LOCKVEHICLE: 	{ _data spawn HandleRequest_LockVehicle; };
		case NETSEND_MSGID_CHEATDETECT: 	{ _data spawn HandleRequest_CheatDetected; };		
		
		case NETSEND_MSGID_UPDATESTATS: 	{ _data spawn UpdateSideStats; };		
		case NETSEND_MSGID_ADDTRASH:		{ _data spawn TrashObject; };		
		case NETSEND_MSGID_MANAGEDUNITADD:	{ _data spawn ManagedUnitAdd; };
		
		default {
			format["NetSend_HandleMessage: Unknown msgId. %1", _msgId] call LogError;
		};
	};

PROFILER_END();