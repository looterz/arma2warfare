#include "netsend.h"
#include "profiler.h"
PROFILER_BEGIN("NetSend_ToClient");
	private['_clientId', '_msgId', '_msgData', '_clientId', '_vehInfo' ];
	
	//--- _clientId = _this select 0;
	//--- _msgId    = _this select 1;
	//--- _msgData  = _this select 2;
	
	Format["NetSend_ToClient: %1", _this] call LogHigh;
	WBE_NETSEND_CLIENT = _this;
	publicVariable "WBE_NETSEND_CLIENT";

PROFILER_END();