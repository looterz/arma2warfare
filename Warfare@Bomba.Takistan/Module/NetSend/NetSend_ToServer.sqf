#include "profiler.h"
PROFILER_BEGIN("NetSend_ToServer");
	private['_msgId', '_msgData', '_netmessage'];
	
	//--- _clientId  = _this select 0;
	//--- _msgId     = _this select 1;
	//--- _msgData   = _this select 2;
	
	if (IsClientServer) then { 
		_this spawn NetSend_HandleServerMessage;
	} else {
		WBE_NETSEND_SERVER = _this;
		publicVariable "WBE_NETSEND_SERVER";
	};
	
	Format["NetSend_ToServer: %1", _this] call LogInform;

PROFILER_END();
