#include "netsend.h"
#include "profiler.h"
PROFILER_BEGIN("NetSend_ToClient");
	private['_clientId', '_msgId', '_msgData', '_clientId', '_vehInfo' ];
	
	//--- _clientId = _this select 0;
	//--- _msgId    = _this select 1;
	//--- _msgData  = _this select 2;
	
	if (IsClientServer) then { 
		Format["NetSend_ToClient Server-Server Mode: %1", _this] call LogHigh;
		_this call NetSend_HandleClientMessage;
	} else {
		Format["NetSend_ToClient Server-Client Mode: %1", _this] call LogHigh;
		WBE_NETSEND_CLIENT = _this;
		publicVariable "WBE_NETSEND_CLIENT";
	};
	
	Format["NetSend_ToClientB: %1", _this] call LogHigh;

PROFILER_END();
