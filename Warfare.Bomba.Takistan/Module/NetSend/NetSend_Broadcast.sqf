#include "profiler.h"
PROFILER_BEGIN("NetSend_Broadcast");
	
	//--- _msgId    = _this select 0;
	//--- _msgData  = _this select 1;
	
	while {(NetSend_BroadcastLock) != 0} do { sleep 0.1 };
	NetSend_BroadcastLock = 1;	
	
	Format["NetSend_Broadcast: %1", _this] call LogHigh;
	NETSEND_BROADCAST = _this;
	publicVariable "NETSEND_BROADCAST";
	
	_this spawn NetSend_HandleMessage;

	//To prevent overwrites.  Lock the command for a little while before can send it again.
	sleep 0.1;
	NetSend_BroadcastLock = 0;	
	
PROFILER_END();
