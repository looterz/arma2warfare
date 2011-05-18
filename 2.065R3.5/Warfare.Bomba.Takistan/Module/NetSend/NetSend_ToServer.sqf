#include "profiler.h"
PROFILER_BEGIN("NetSend_ToServer");
	private['_msgId', '_msgData', '_netmessage'];
	
	//--- _clientId  = _this select 0;
	//--- _msgId     = _this select 1;
	//--- _msgData   = _this select 2;
	
	Format["NetSend_ToServer: %1", _this] call LogHigh;
	WBE_NETSEND_SERVER = _this;
	publicVariable "WBE_NETSEND_SERVER";

PROFILER_END();
