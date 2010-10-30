Private ["_structure","_structures","_side","_type"];
_structure = _this select 0;
_killer = _this select 1;
_side = _this select 2;
_type = _this select 3;

Format["Server_BuildingKilled: A %1 %2 Structure has been destroyed",str _side,_type] call LogInform;


if ((side _killer != _side)&&(isPlayer(_killer)))  then {
	
	_bounty = 5000;	
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
	_uid = getPlayerUID _killer;
	if !(paramShowUID) then {_uid = "xxxxxxx"};
	_tked = [_type, 'displayName'] Call GetConfigInfo;
	WFBE_LocalizeMessage = [_side,'CLTFNCLOCALIZEMESSAGE',['BuildingTeamkill',name _killer,_uid,_tked]];
	publicVariable 'WFBE_LocalizeMessage';
	if (IsClientServer) then {[_side,'CLTFNCLOCALIZEMESSAGE',['BuildingTeamkill',name _killer,_uid,_tked]] Spawn HandlePVF};
	if (mysql) then {
		WF_Logic setVariable ["WF_MYSQL_SERVER",(WF_Logic getVariable "WF_MYSQL_SERVER") + [Format ["MYSQLDATA§WFBE_Update§%1§%2§teamkillstr§%3",_uid,name _killer,worldName]]];
	};
	
	Format["Server_BuildingKilled: Player %1 (%2) has teamkilled a friendly building.",name _killer,_uid] call LogNotify;
};

if (mysql) then {
	if ((side _killer != _side)&&(isPlayer(_killer))) then {
		WF_Logic setVariable ["WF_MYSQL_SERVER",(WF_Logic getVariable "WF_MYSQL_SERVER") + [Format ["MYSQLDATA§WFBE_InsertOrUpdate_PKAI§%1§%2§%3§%4§3§%5",_type,getPlayerUID _killer,name _killer,"killed",worldName]]];
	};
};

Call Compile Format ["%1BaseStructures = %1BaseStructures - [_structure] - [objNull]; publicVariable '%1BaseStructures';",str _side];

["Destroyed",_type,_side] Spawn SideMessage;

sleep 10;

deleteVehicle _structure;