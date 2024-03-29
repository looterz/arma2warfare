#include "profiler.h"
PROFILER_BEGIN("Server_HQKilled");

private['_deployed','_dir','_hq','_HQName','_killer','_MHQ','_pos','_side','_type','_bounty','_killerid','_sidekiller','_uid','_kuid','_killedname','_tked','_kname'];
_hq = _this select 0;
_killer = _this select 1;
_side = _this select 2;
_type = _this select 3;

_pos = getPos _hq;
_dir = getDir _hq;
_kuid = if (isPlayer _killer) then {getPlayerUID _killer} else {'0'};
_kname = name _killer;

_deployed = (str _side) Call GetSideHQDeployed;

Format["Server_HQKilled: The %1 MHQ has been destroyed",str _side]  call LogInform;


if ((side _killer != _side)&&(isPlayer(_killer)))  then {

	_bounty = 25000;	
	_killerId = _killer Call GetClientID;
	_sideKiller = side _killer;
	[_bounty, _sideKiller,_killerId] Call ChangeClientFunds;
	
	_killedName = [_type, 'displayName'] Call GetConfigInfo;

	WFBE_LocalizeMessage = [[_killerId, _sideKiller],'CLTFNCLOCALIZEMESSAGE',['HeadHunterReceiveBounty',_bounty, _killedName]];
	publicVariable 'WFBE_LocalizeMessage';
	if (IsClientServer) then {[[_killerId, _sideKiller],'CLTFNCLOCALIZEMESSAGE',['HeadHunterReceiveBounty',_bounty, _killedName]] Spawn HandlePVF};
};


//--- Building Teamkill.
if ((side _killer == _side)&&(isPlayer(_killer))) then {
	_uid = if !(paramShowUID) then {_uid = 'xxxxxxx'} else {_kuid};
	_tked = [_type, 'displayName'] Call GetConfigInfo;
	WFBE_LocalizeMessage = [_side,'CLTFNCLOCALIZEMESSAGE',['BuildingTeamkill',name _killer,_uid,_tked]];
	publicVariable 'WFBE_LocalizeMessage';
	if (IsClientServer) then {[_side,'CLTFNCLOCALIZEMESSAGE',['BuildingTeamkill',name _killer,_uid,_tked]] Spawn HandlePVF};
	
	Format["Server_HQKilled: Player %1 (%2) has teamkilled the MHQ.",name _killer,_uid]  call LogInform;;
};

sleep random(2);
if (_deployed) then {
	_HQName = Format["WFBE_%1MHQNAME",_side] Call GetNamespace;
	_MHQ = _HQName createVehicle _pos;
	_MHQ setDir _dir;
	_MHQ setDammage 1;

	Call Compile Format ["%1MHQ = _MHQ; %1MHQDeployed = false; publicVariable '%1MHQ'; publicVariable '%1MHQDeployed';",str _side];
};

if (mysql) then {
	if ((side _killer != _side)&&(isPlayer(_killer))) then {
		WF_Logic setVariable ["WF_MYSQL_SERVER",(WF_Logic getVariable "WF_MYSQL_SERVER") + [Format ["MYSQLDATA�WFBE_Update�%1�%2�killedhq�%3",getPlayerUID _killer,name _killer,worldName]]];
		WF_Logic setVariable ["WF_MYSQL_SERVER",(WF_Logic getVariable "WF_MYSQL_SERVER") + [Format ["MYSQLDATA�WFBE_InsertOrUpdate_PKAI�%1�%2�%3�%4�%5�%6",_type,_kuid,_kname,"killed",4,worldName]]];
	};
};

if (_type == WESTHQ) then {_type = 'WFBE_WESTMHQNAME' Call GetNamespace};
if (_type == EASTHQ) then {_type = 'WFBE_EASTMHQNAME' Call GetNamespace};
['Destroyed',_type,_side] Spawn SideMessage;

PROFILER_END();