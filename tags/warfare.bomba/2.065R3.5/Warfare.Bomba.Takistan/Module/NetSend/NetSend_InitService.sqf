#include "profiler.h"
#include "netsend.h"

WBE_NETSEND_SERVER = objNull;
WBE_NETSEND_CLIENT = objNull;

WBE_NETSEND_CLIENTID = NETSEND_CLIENTID_AI;
WBE_NETSEND_CLIENTID_AI = NETSEND_CLIENTID_AI;

	NetSend_HandleClientMessage  = Compile preprocessFile "Module\NetSend\NetSend_HandleClientMessage.sqf";
	
	if (isServer) then {
		NetSend_ToServer  = Compile preprocessFile "Module\NetSend\NetSend_ToServerServer.sqf";
	} else {
		NetSend_ToServer  = Compile preprocessFile "Module\NetSend\NetSend_ToServer.sqf";
	};

	if (local player) then {	
		WBE_NETSEND_CLIENTID = getPlayerUID player;
		"WBE_NETSEND_CLIENT" addPublicVariableEventHandler {(_this select 1) spawn NetSend_HandleClientMessage; };
	};

	if (isServer) then {

		if (IsClientServer) then {
			NetSend_ToClient  = Compile preprocessFile "Module\NetSend\NetSend_ToClientServer.sqf";			
		} else {
			NetSend_ToClient  = Compile preprocessFile "Module\NetSend\NetSend_ToClient.sqf";			
		};

		NetSend_HandleServerMessage = Compile preprocessFile "Module\NetSend\NetSend_HandleServerMessage.sqf";
		"WBE_NETSEND_SERVER" addPublicVariableEventHandler {(_this select 1) spawn NetSend_HandleServerMessage; };
	};

"NetSend_InitService - [Done]" call LogMedium;

