#include "profiler.h"
PROFILER_BEGIN("NetSend_ToServer");
	private['_msgId', '_msgData', '_netmessage'];
	
	//--- _msgId     = _this select 0;
	//--- _msgData   = _this select 1;
	format["NetSend_ToServer: From %1 Msg: %2", WBE_NETSEND_CLIENTID, _this] call LogHigh;
	
	if (NetSend_IsClientServer) then 
	{
		_this spawn NetSend_HandleMessage;
	} else 
	{
		while {(NetSend_ToClientLock) != 0} do { sleep 0.1 };
		NetSend_ToClientLock = 1;	
		call compile format["NETSEND_MSG%1=[_msgId, _msgData]; publicVariable 'NETSEND_MSG%1';", WBE_NETSEND_SERVERID];
		//To prevent overwrites.  Lock the command for a little while before can send it again.
		sleep 0.1;
		NetSend_ToClientLock = 0;	
	};	
	
	
PROFILER_END();
