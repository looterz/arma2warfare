#include "netsend.h"
#include "profiler.h"
PROFILER_BEGIN("NetSend_ToClientServer");
	private['_clientId', '_msgId', '_msgData', '_clientId', '_vehInfo' ];
	
	//--- _clientId = _this select 0;
	//--- _msgId    = _this select 1;
	//--- _msgData  = _this select 2;
	
	Format["NetSend_ToClientServer: %1", _this] call LogHigh;
	_this spawn NetSend_HandleClientMessage;

PROFILER_END();
