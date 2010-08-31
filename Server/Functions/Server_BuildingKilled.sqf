Private ["_structure","_structures","_side","_type"];
_structure = _this select 0;
_killer = _this select 1;
_side = _this select 2;
_type = _this select 3;

//--- Building Teamkill.
if ((side _killer == _side)&&(isPlayer(_killer))) then {
	_uid = getPlayerUID _killer;
	if (!showUID) then {_uid = "xxxxxxx"};
	_tked = GetText (configFile >> "CfgVehicles" >> _type >> "displayName");
	[_side,CMDLOCALIZEMESSAGE,"BuildingTeamkill",[name _killer,_uid,_tked]] Spawn CommandToSide;
	if (mysql) then {
		WF_Logic setVariable ["WF_MYSQL_SERVER",(WF_Logic getVariable "WF_MYSQL_SERVER") + [Format ["MYSQLDATA§WFBE_Update§%1§%2§teamkillstr§%3",_uid,name _killer,worldName]]];
	};
};

if (mysql) then {
	if ((side _killer != _side)&&(isPlayer(_killer))) then {
		WF_Logic setVariable ["WF_MYSQL_SERVER",(WF_Logic getVariable "WF_MYSQL_SERVER") + [Format ["MYSQLDATA§WFBE_InsertOrUpdate_PKAI§%1§%2§%3§%4§3§%5",_type,getPlayerUID _killer,name _killer,"killed",worldName]]];
	};
};

_structures = WF_Logic getVariable Format ["%1BaseStructures",str _side];
_structures = _structures - [_structure] - [objNull];
WF_Logic setVariable [Format ["%1BaseStructures",str _side],_structures,true];

["Destroyed",_type,_side] Spawn SideMessage;

sleep 10;

deleteVehicle _structure;