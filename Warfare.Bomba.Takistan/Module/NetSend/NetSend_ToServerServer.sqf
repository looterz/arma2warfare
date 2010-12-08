#include "profiler.h"
PROFILER_BEGIN("NetSend_ServerToServer");
	private['_msgId', '_msgData', '_netmessage'];
	
	//--- _msgId     = _this select 0;
	//--- _msgData   = _this select 1;
	
	Format["NetSend_ToServerServer: %1", _this] call LogHigh;
	_this spawn NetSend_HandleMessage;

PROFILER_END();
