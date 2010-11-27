#include "netsend.h"
#include "profiler.h"
PROFILER_BEGIN("NetSend_ToClient");
	private['_clientId', '_msgId', '_msgData', '_clientId', '_vehInfo' ];
	
	//--- _clientId = _this select 0;
	//--- _msgId    = _this select 1;
	//--- _msgData  = _this select 2;
	Format["NetSend_ToClientA: %1", _this] call LogHigh;
	
	if (isServer) then { 
		_this call NetSend_HandleClientMessage;
	} else {
		WBE_NETSEND_CLIENT = _this;
		publicVariable "WBE_NETSEND_CLIENT";
	};
	
	Format["NetSend_ToClientB: %1", _this] call LogHigh;

PROFILER_END();
