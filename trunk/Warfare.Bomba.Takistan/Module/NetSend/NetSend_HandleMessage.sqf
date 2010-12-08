#include "netsend.h"
#include "profiler.h"
PROFILER_BEGIN("NetSend_ServerMessageHandle");

private['_clientId', '_unitData', '_response', '_order', '_data', '_unitType', '_description', '_txt', '_vehicle' ];
	
	if (typeName _this != 'ARRAY') exitWith {
		PROFILER_END();
	};
	
	_msgId   = _this select 0;
	_data = _this select 1;

	switch (_msgId) do {
	
		case NETSEND_MSGID_BUYUNIT: 		{ _data spawn BuyUnit_OrderResponseHandle; };
		case NETSEND_MSGID_BUYUNIT_ORDER: 	{ _data spawn BuyUnit_OrderRegister;	};
		case NETSEND_MSGID_LOCKVEHICLE: 	{ _data spawn HandleRequest_LockVehicle; };
		case NETSEND_MSGID_CHEATDETECT: 	{ _data spawn HandleRequest_CheatDetected; };
		
		default {
			format["NetSend_ServerMessageHandle: Unknown msgId. %1", _this] call LogError;
		};
	};

PROFILER_END();