private['_msgId','_msgData','_msgTo'];
#include "profiler.h"
PROFILER_BEGIN("NetSend_ToClient");
	private['_msgId', '_msgData', '_msgTo', '_vehInfo' ];
	
	_msgTo    = _this select 0;
	_msgId    = _this select 1;
	_msgData  = _this select 2;
		
	format["NetSend_ToClient: From %1 Msg: %2", WBE_NETSEND_CLIENTID, _this] call LogHigh;
	
	if ((_msgTo == WBE_NETSEND_CLIENTID)) then 
	{
		[_msgId, _msgData] spawn NetSend_HandleMessage;
	} else 
	{
		while {(NetSend_ToClientLock) != 0} do { sleep 0.1 };
		NetSend_ToClientLock = 1;	
		call compile format["NETSEND_MSG%1=[_msgId, _msgData]; publicVariable 'NETSEND_MSG%1';", _msgTo];
		//To prevent overwrites.  Lock the command for a little while before can send it again.
		sleep 0.1;
		NetSend_ToClientLock = 0;	
	};
	
	
PROFILER_END();
