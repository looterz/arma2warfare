#include "profiler.h"
#include "netsend.h"

WBE_NETSEND_SERVERID = "0";
WBE_NETSEND_CLIENTID = NETSEND_CLIENTID_AI;
WBE_NETSEND_CLIENTID_AI = NETSEND_CLIENTID_AI;

	NetSend_ToClientLock  = 0;
	NetSend_BroadcastLock = 0;	
	
	NetSend_HandleMessage  = compile preprocessFile "Module\NetSend\NetSend_HandleMessage.sqf";	
	NetSend_Broadcast = compile preprocessFile "Module\NetSend\NetSend_Broadcast.sqf";
	
	if (isServer) then {
		NetSend_ToServer  = Compile preprocessFile "Module\NetSend\NetSend_ToServerServer.sqf";
	} else {
		NetSend_ToServer  = Compile preprocessFile "Module\NetSend\NetSend_ToServer.sqf";
	};

	WBE_NETSEND_CLIENTID = if (local player) then { getPlayerUID player } else { "0" };
	
	_varName = format["NETSEND_MSG%1", WBE_NETSEND_CLIENTID];
	_varName addPublicVariableEventHandler {(_this select 1) spawn NetSend_HandleMessage; };
	"NETSEND_BROADCAST" addPublicVariableEventHandler {(_this select 1) spawn NetSend_HandleMessage; };

	if (isServer) then {

		if (IsClientServer) then {
			NetSend_ToClient  = Compile preprocessFile "Module\NetSend\NetSend_ToClientServer.sqf";			
		} else {
			NetSend_ToClient  = Compile preprocessFile "Module\NetSend\NetSend_ToClient.sqf";			
		};
	};

"NetSend_InitService - [Done]" call LogMedium;

