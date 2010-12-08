#include "profiler.h"
PROFILER_BEGIN("NetSend_ToServer");
	private['_msgId', '_msgData', '_netmessage'];
	
	//--- _clientId  = _this select 0;
	//--- _msgId     = _this select 1;
	//--- _msgData   = _this select 2;
	
	while {(NetSend_ToServerLock) != 0} do {Sleep 0.1};
	NetSend_ToServerLock = 1;
	
	Format["NetSend_ToServer: %1", _this] call LogHigh;
	WBE_NETSEND_SERVER = _this;
	publicVariable "WBE_NETSEND_SERVER";

	//To prevent overwrites.  Lock the command for a little while before can send it again.
	sleep 0.1;
	NetSend_ToServerLock = 0;
PROFILER_END();
