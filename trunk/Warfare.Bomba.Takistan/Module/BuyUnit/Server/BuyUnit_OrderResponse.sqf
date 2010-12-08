#include "profiler.h"
PROFILER_BEGIN("BuyUnit_OrderResponse");

private['_clientId'];

	_clientId     = _this select 0;	
	format["BuyUnit_OrderResponseA: %1", _this] call LogHigh;
	
	if (_clientId != CLIENTID_AI) exitWith {		
		[_clientId, NETSEND_MSGID_BUYUNIT, _this] spawn NetSend_ToClient;
	};

	
PROFILER_END();
