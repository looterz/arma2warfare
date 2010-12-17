#include "netsend.h"
#include "profiler.h"
PROFILER_BEGIN("NetSend_ServerMessageHandle");

private['_clientId', '_unitData', '_response', '_order', '_data', '_unitType', '_description', '_txt', '_vehicle' ];
	
	if (typeName _this != 'ARRAY') exitWith {
		PROFILER_END();
	};
	
	//_clientId = _this select 0;
	_msgId   = _this select 1;
	//_msgData = _this select 2;

	switch (_msgId) do {
		case NETSEND_MSGID_BUYUNIT: 	{ _this call BuyUnit_OrderRegister;	};
		case NETSEND_MSGID_LOCKVEHICLE: { _this call HandleRequest_LockVehicle; };
		
		default {
			format["NetSend_ServerMessageHandle: Unknown messageId. msgId=%1, data=%2", _msgId, _msgData] call LogError;
		};
	};

PROFILER_END();