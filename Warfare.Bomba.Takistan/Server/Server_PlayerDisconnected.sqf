/* 
	Author: Benny
	Name: Server_PlayerDisconnected.sqf
	Parameters:
	  0 - User ID
	  1 - User Name
	Description:
	  This file is called upon a player disconnection, the player's information are updated.
*/
#include "profiler.h"
PROFILER_BEGIN("Server_PlayerDisconnected");

private['_buildings','_closestRespawn','_funds','_get','_hq','_name','_respawnLoc','_side','_sideText','_slotIndex','_team','_units','_uid','_cmdrteam','_strtrans'];
_uid = _this select 0;
_name = _this select 1;

waitUntil { !isNil "initJIP" };
Format["Server_PlayerDisconnected: Player %1 (%2) has left the game",_name,_uid] call LogNotify;

//--- Grab the player info (if they exist).
_get = Format["WFBE_JIP_USER%1",_uid] Call GetNamespace;
if (isNil '_get') exitWith {
	Format ["Server_PlayerDisconnected: Player %1 (%2) don't have any information stored.",_name,_uid] call LogNotify;
};

//--- Check this mess.
_side = _get select 4;
_sideText = str _side;
_slotIndex = _get select 1;
_team = (Format["WFBE_%1TEAMS",_sideText] Call GetNamespace) select _slotIndex;

//--- MySQL Update.
if (mysql && !gameOver) then {
	_strTrans = if (_side == west) then {'west'} else {'east'};
	WF_Logic setVariable ["WF_MYSQL_SERVER",(WF_Logic getVariable "WF_MYSQL_SERVER") + [Format ["MYSQLDATA�WFBE_Disconnect_Player�%1�%2�%3�%4�%5",_uid,_name,round(time - (_get select 5)),_strTrans,worldName]]];
};

//--- Is unit driving the HQ?
_hq = (_sideText) Call GetSideHQ;
if (vehicle(leader _team) == _hq) then {unassignVehicle (leader _team);[leader _team] allowGetIn false;(leader _team) action ["EJECT", _hq]};

//--- Keep AI over JIP?
if !(paramKeepAI) then {
	_units = units _team;
	_units = _units - [leader _team];
	_units = _units + ([_team,false] Call GetTeamVehicles) - [_hq];
	{deleteVehicle _x} forEach _units;
};

//--- Save the Client Cash.
_funds = _team Call GetTeamFunds;
_get set [2,_funds];

//--- SetPos the AI.
_buildings = (_sideText) Call GetSideStructures;
_respawnLoc = _hq;
if (count _buildings > 0) then {
	_closestRespawn = [leader _team,_buildings] Call SortByDistance;
	_respawnLoc = _closestRespawn select 0;
};
(leader _team) setPos ([_respawnLoc, 20, 30] Call GetRandomPositionEx);

//--- Is AI Enabled? if so we update the squads.
if (paramAI) then {[_team] ExecFSM "Server\FSM\aiteam.fsm"};

//--- ISIS.
if (paramISIS) then {(leader _team) addEventHandler['handleDamage',{_this Call ISIS_Wound}]}; 

//--- Update.
[Format["WFBE_JIP_USER%1",_uid],_get,true] Call SetNamespace;

//--- Player was commander?.
_cmdrTeam = (_side) Call GetCommanderTeam;
if !(isNull (_cmdrTeam)) then {
	if (_team == _cmdrTeam) then {
		WF_Logic setVariable [Format ["%1CommanderTeam",_sideText],objNull,true];
		WFBE_LocalizeMessage = [_side,'CLTFNCLOCALIZEMESSAGE',['CommanderDisconnected']];
		publicVariable 'WFBE_LocalizeMessage';
		
		//--- High Command (Remove).
		if (paramHighCommand && count (hcAllGroups (leader _team)) > 0) then {HCRemoveAllGroups (leader _team)};
		
		//--- AI Can move freely now & respawn at the default location.
		{[_x,false] Call SetTeamAutonomous;[_x, ""] Call SetTeamRespawn} forEach (Format["WFBE_%1TEAMS",_sideText] Call GetNamespace);
	};
};

PROFILER_END();