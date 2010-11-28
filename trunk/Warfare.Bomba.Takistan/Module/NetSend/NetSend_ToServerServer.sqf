#include "profiler.h"
PROFILER_BEGIN("NetSend_ServerToServer");
	private['_msgId', '_msgData', '_netmessage'];
	
	//--- _clientId  = _this select 0;
	//--- _msgId     = _this select 1;
	//--- _msgData   = _this select 2;
	
	Format["NetSend_ToServerServer: %1", _this] call LogHigh;
	_this spawn NetSend_HandleServerMessage;

PROFILER_END();
