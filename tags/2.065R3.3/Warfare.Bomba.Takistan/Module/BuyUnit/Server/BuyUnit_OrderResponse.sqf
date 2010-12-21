#include "netsend.h"
#include "profiler.h"
PROFILER_BEGIN("BuyUnit_OrderResponse");

private['_clientId'];

	_clientId     = _this select 0;	
	format["BuyUnit_OrderResponseA: %1", _this] call LogHigh;
	
	if (_clientId == WBE_NETSEND_CLIENTID_AI) exitWith {		
		PROFILER_END();	
	};

	[_clientId, NETSEND_MSGID_BUYUNIT, _this] spawn NetSend_ToClient;
PROFILER_END();