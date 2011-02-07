private['_varname'];
#include "profiler.h"

NETSEND_MSGID_BUYUNIT 	   	 = 10;
NETSEND_MSGID_LOCKVEHICLE  	 = 20;
NETSEND_MSGID_CHEATDETECT  	 = 30;
NETSEND_MSGID_UPDATESTATS  	 = 40;
NETSEND_MSGID_ADDTRASH     	 = 50;
NETSEND_MSGID_MANAGEDUNITADD = 60;
NETSEND_MSGID_KICKTEAMSWAP   = 70;

//WBE_NETSEND_SERVERID = "SRV";
WBE_NETSEND_CLIENTID = "SRV";

	if (!isServer) then {
		waitUntil { !isNil "WBE_NETSEND_SERVERID" };
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
		format["NetSend_InitService - Register Client Channel: '%1'", _varName] call LogMedium;
	};
	
	if (isServer) then {
	
		WBE_NETSEND_SERVERID = if (IsClientServer) then { WBE_NETSEND_CLIENTID } else { "SRV" };
		publicVariable "WBE_NETSEND_SERVERID";
		
		format["NetSend_InitService - Publish Server Name: '%1'", WBE_NETSEND_SERVERID] call LogMedium;
	
		if (WBE_NETSEND_SERVERID != WBE_NETSEND_CLIENTID ||
		    WBE_NETSEND_CLIENTID == "SRV") then {
			_varName = format["NETSEND_MSG%1", WBE_NETSEND_SERVERID];
			_varName addPublicVariableEventHandler {(_this select 1) spawn NetSend_HandleMessage; };

			format["NetSend_InitService - Register Server Channel: '%1'", _varName] call LogMedium;			
		} else {
			format["NetSend_InitService - Server channel is Equal Client Channel so do nothing"] call LogMedium;		
		};
	};
	NetSend_IsClientServer = if (WBE_NETSEND_CLIENTID == WBE_NETSEND_SERVERID) then { true } else { false };
	
	"NETSEND_BROADCAST" addPublicVariableEventHandler {(_this select 1) spawn NetSend_HandleMessage; };
	format["NetSend_InitService - Register Broadcast channel"] call LogMedium;

"NetSend_InitService - [Done]" call LogMedium;

