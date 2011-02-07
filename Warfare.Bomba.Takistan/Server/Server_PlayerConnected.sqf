/* 
	Author: Benny
	Name: Server_PlayerConnected.sqf
	Parameters:
	  0 - User ID
	  1 - User Name
	Description:
	  This file is called upon a player connection, the player's information are stored or retrieved before being updated.
*/
#include "profiler.h"
PROFILER_BEGIN("Server_PlayerConnected");

private['_attempts','_funds','_get','_leader','_name','_side','_sideLeft','_slotIndex','_team','_uid','_units'];

_uid = _this select 0;
_name = _this select 1;

Format["Server_PlayerConnected: Player %1 (%2) has joined the game",_name,_uid] call LogNotify;

sleep (0.1+random(0.1));

//--- Attempt to get the player's team.
_attempts = 0;
_team = ObjNull;
while {_attempts < 12 && isNull _team} do {
	sleep 1;
	{if ((getPlayerUID (leader _x)) == _uid) then {_team = _x}} forEach ('WFBE_EASTTEAMS' Call GetNamespace);
	{if ((getPlayerUID (leader _x)) == _uid) then {_team = _x}} forEach ('WFBE_WESTTEAMS' Call GetNamespace);
	_attempts = _attempts + 1;
};

//--- Not found, exit.
if (isNull _team) exitWith {
	Format ["Server_PlayerConnected: Player %1 (%2) is not defined within the west and east teams.",_name,_uid] call LogNotify;
	PROFILER_END();
};
_leader = leader _team;
_side = objNull;

//--- Nasty hack, a leader side can be enemy so we do a class check.
if (_leader isKindOf westSoldierBaseClass) then {_side = west};
if (_leader isKindOf eastSoldierBaseClass) then {_side = east};

//--- Retrieve the player's team.
_slotIndex = (Format["WFBE_%1TEAMS",str _side] Call GetNamespace) find _team;
if (_slotIndex == -1) exitWith {
	Format ["Server_PlayerConnected: Player %1 (%2) team's wasn't found.",_name,_uid] call LogNotify;
};

//--- MySQL Update.
if (mysql && _name != "__SERVER__") then {
	WF_Logic setVariable ["WF_MYSQL_SERVER",(WF_Logic getVariable "WF_MYSQL_SERVER") + [Format ["MYSQLDATA§WFBE_Insert_Players§%1§%2",_uid,_name]]];
};

//--- Do we keep the AI over JIP?.
if !(paramKeepAI) then {
	_units = units _team;
	_units = _units - [_leader];
	_units = _units + ([_team,false] Call GetTeamVehicles);
	{deleteVehicle _x} forEach _units;
};

//--- 'Sanitize' the player.
_team Call AIWPRemove;
_leader setDammage 0;

//--- ISIS.
if (paramISIS) then {_leader removeAllEventHandlers "handleDamage"};

//--- Grab the player info (if they exist).
_get = Format["WFBE_JIP_USER%1",_uid] Call GetNamespace;

//--- Player didn't d/c.
if (isNil '_get') exitWith {
	/* 
		UID | Slot Index | Cash | Side | Current Side | (mysql) time
		This new method allows the server to execute the code faster, it will also prevent any possible 'wrong indexing' with the array (JIP Scripts are ExecVM'ed
		 by the engine), note that this method also sanitize the values, preventing them from being modified by anything else than the server.
	*/
	[Format["WFBE_JIP_USER%1",_uid],[_uid,_slotIndex,0,_side,_side,if (mysql) then {round(time)} else {0}],true] Call SetNamespace;

	_funds = if (_side == west) then { "WFBE_WESTSTARTINGMONEY" call GetNamespace  } else { "WFBE_EASTSTARTINGMONEY"  call GetNamespace };
	[_funds, _side, _slotIndex+1] call SetClientFunds;
	PROFILER_END();
};

//--- Player d/c before, update info.
_get set [1,_slotIndex];
_get set [4,_side];
if (mysql) then {_get set [5,round(time)]};

//--- Player d/c before, grab the info.
_funds = _get select 2;
_sideLeft = _get select 3;

//--- Update.
[Format["WFBE_JIP_USER%1",_uid],_get,true] Call SetNamespace;

//--- Did the player teamswap?.
if (_sideLeft != _side) then {
	_funds = Format ["WFBE_%1STARTINGMONEY",str _side] Call GetNamespace;
	
	//--- Do we hide the UID?.
	if !(paramShowUID) then {_uid = "xxxxxxx"};
	
	//--- Warn the clients.
	WFBE_LocalizeMessage = [nil,'CLTFNCLOCALIZEMESSAGE',['Teamswap',_name,_uid,_sideLeft,_side]];
	publicVariable 'WFBE_LocalizeMessage';
	
	//--- Kick the player?.
	if (paramKickTeamswappers) then {
		//serverCommand Format["#kick %1",_name];
		[_uid, NETSEND_MSGID_KICKTEAMSWAP, nil] call NetSend_ToClient;
		
		Format["Server_PlayerConnected: Player %1 (%2) was kicked for teamswapping",_name,_get select 0] call LogNotify;
	};
};

//--- Set the cash.
[_funds, _side, _slotIndex+1] call SetClientFunds;
PROFILER_END();