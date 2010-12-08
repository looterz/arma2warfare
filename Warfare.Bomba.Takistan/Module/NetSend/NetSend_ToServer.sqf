#include "profiler.h"
PROFILER_BEGIN("NetSend_ToServer");
	private['_msgId', '_msgData', '_netmessage'];
	
	//--- _msgId     = _this select 0;
	//--- _msgData   = _this select 1;
	
	[WBE_NETSEND_SERVERID, _this select 0, _this select 1] spawn NetSend_ToClient;
	
PROFILER_END();
