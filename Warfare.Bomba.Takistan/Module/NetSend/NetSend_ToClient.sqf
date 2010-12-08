#include "netsend.h"
#include "profiler.h"
PROFILER_BEGIN("NetSend_ToClient");
	private['_clientId', '_msgId', '_msgData', '_clientId', '_vehInfo' ];
	
	//--- _clientId = _this select 0;
	//--- _msgId    = _this select 1;
	//--- _msgData  = _this select 2;
	
	while {(NetSend_ToClientLock) != 0} do { sleep 0.1 };
	NetSend_ToClientLock = 1;	
	
	Format["NetSend_ToClient: %1", _this] call LogHigh;
	
	call compile format["NETSEND_MSG%1=[_this select 0, _this select 1]; publicVariable 'NETSEND_MSG%1';", _this select 0];

	//To prevent overwrites.  Lock the command for a little while before can send it again.
	sleep 0.1;
	NetSend_ToClientLock = 0;	
	
PROFILER_END();
