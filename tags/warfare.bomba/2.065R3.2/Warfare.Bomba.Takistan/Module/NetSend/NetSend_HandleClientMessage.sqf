#include "netsend.h"
#include "profiler.h"
PROFILER_BEGIN("NetSend_ClientMessageHandle");

private['_clientId', '_unitData', '_response', '_order', '_data', '_unitType', '_description', '_txt', '_vehicle' ];
	
	_clientId = _this select 0;
	
	format["NetSend_ClientMessageHandle: %1", _this] call LogHigh;

	if ( !(_clientId == NETSEND_BROADCAST) && !(_clientId == WBE_NETSEND_CLIENTID) ) exitWith {
		PROFILER_END();	
	};

	_msgId   = _this select 1;
	_msgData = _this select 2;

	switch (_msgId) do {
		case NETSEND_MSGID_BUYUNIT: { _msgData call BuyUnit_OrderResponseHandle; };
		
		default {
			format["NetSend_ClientMessageHandle: Unknown messageId. msgId=%1, data=%2", _msgId, _msgData] call LogError;
		};
	};
	
PROFILER_END();