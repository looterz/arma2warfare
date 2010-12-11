#include "profiler.h"

NETSEND_MSGID_BUYUNIT 	   = 10;
NETSEND_MSGID_LOCKVEHICLE  = 20;
NETSEND_MSGID_CHEATDETECT  = 30;
NETSEND_MSGID_UPDATESTATS  = 40;

WBE_NETSEND_SERVERID = objNull;
WBE_NETSEND_CLIENTID = WBE_NETSEND_SERVERID;

	if (!isServer) then {
		waitUntil { !(isNull WBE_NETSEND_SERVERID) };
	};

	NetSend_ToClientLock  = 0;
	NetSend_BroadcastLock = 0;	
	
	NetSend_HandleMessage  = compile preprocessFile "Module\NetSend\NetSend_HandleMessage.sqf";	
	NetSend_Broadcast = compile preprocessFile "Module\NetSend\NetSend_Broadcast.sqf";
	NetSend_ToClient  = Compile preprocessFile "Module\NetSend\NetSend_ToClient.sqf";
	NetSend_ToServer  = Compile preprocessFile "Module\NetSend\NetSend_ToServer.sqf";

	if (local player) then {
		WBE_NETSEND_CLIENTID = getPlayerUID player;
		_varName = format["NETSEND_MSG%1", WBE_NETSEND_CLIENTID];
		_varName addPublicVariableEventHandler {(_this select 1) spawn NetSend_HandleMessage; };
	};
	
	if (isServer) then {
	
		WBE_NETSEND_SERVERID = if (IsClientServer) then { WBE_NETSEND_CLIENTID } else { "SRV" };
		publicVariable "WBE_NETSEND_SERVERID";
	
		if (WBE_NETSEND_SERVERID != WBE_NETSEND_CLIENTID) then {
			_varName = format["NETSEND_MSG%1", WBE_NETSEND_SERVERID];
			_varName addPublicVariableEventHandler {(_this select 1) spawn NetSend_HandleMessage; };	
		};
	};
	
	"NETSEND_BROADCAST" addPublicVariableEventHandler {(_this select 1) spawn NetSend_HandleMessage; };
	

"NetSend_InitService - [Done]" call LogMedium;

