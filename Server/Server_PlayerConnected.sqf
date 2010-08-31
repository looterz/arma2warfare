//--- JIP Script, experimental. By Benny 23/09/09.
Private ['_attempts','_funds','_index','_leader','_name','_side','_sideLeft','_slotIndex','_team','_uid'];
_uid = _this select 0;
_name = _this select 1;

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

if (isNull _team) exitWith {};
_leader = leader _team;
_side = objNull;

//--- Nasty hack, a leader side can be enemy so we do a class check.
if (_leader isKindOf westSoldierBaseClass) then {_side = west};
if (_leader isKindOf eastSoldierBaseClass) then {_side = east};

_slotIndex = (Format["WFBE_%1TEAMS",str _side] Call GetNamespace) find _team;
if (_slotIndex == -1) exitWith {};

if (mysql && _name != "__SERVER__") then {
	WF_Logic setVariable ["WF_MYSQL_SERVER",(WF_Logic getVariable "WF_MYSQL_SERVER") + [Format ["MYSQLDATA§WFBE_Insert_Players§%1§%2",_uid,_name]]];
};

if !(keepAI) then {
	_units = units _team;
	_units = _units - [_leader];
	_units = _units + ([_team,false] Call GetTeamVehicles);
	{deleteVehicle _x} forEach _units;
};

_team Call AIWPRemove;
_leader setDammage 0;

//--- ISIS.
if (ISIS) then {_leader removeAllEventHandlers "handleDamage"};

//--- Player didn't d/c.
_index = JIPArrayUID find _uid;
if (_index == -1) exitWith {
	JIPArrayUID = JIPArrayUID + [_uid];
	JIPArrayIndex = JIPArrayIndex + [_slotIndex];
	JIPArrayCash = JIPArrayCash + [0];
	JIPArraySide = JIPArraySide + [_side];
	JIPArrayCurSide = JIPArrayCurSide + [_side];
	if (mysql) then {JIP_SQL_Time = JIP_SQL_Time + [round(time)]};

	_team setVariable ["funds",Format ["WFBE_%1STARTINGMONEY",str _side] Call GetNamespace,true];
};
//--- Player d/c before, update arrays.
if (_index != -1) then {
	JIPArrayIndex set [_index,_slotIndex];
	JIPArrayCurSide set [_index,_side];
	if (mysql) then {JIP_SQL_Time set [_index,round(time)]};
};

//--- Player d/c before.
_funds = JIPArrayCash select _index;
_sideLeft = JIPArraySide select _index;

//--- Teamswap.
if (_sideLeft != _side) then {
	_funds = Format ["WFBE_%1STARTINGMONEY",str _side] Call GetNamespace;
	if !(showUID) then {_uid = "xxxxxxx"};
	[CMDLOCALIZEMESSAGE,"Teamswap",[_name,_uid,_sideLeft,_side]] Spawn CommandToClients;
	if (kickTeamswappers) then {serverCommand Format["#kick %1",_name]};
};

//--- Set the cash.
_team setVariable ["funds",_funds,true];