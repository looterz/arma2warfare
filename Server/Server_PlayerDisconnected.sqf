//--- JIP Script, experimental. By Benny 23/09/09.
Private ['_buildings','_closestRespawn','_funds','_hq','_index','_name','_respawnLoc','_side','_sideText','_slotIndex','_team','_units','_uid'];
_uid = _this select 0;
_name = _this select 1;

_index = JIPArrayUID find _uid;
if (_index == -1) exitWith {};

//--- Check this mess.
_side = JIPArrayCurSide select _index;
_sideText = str _side;
_slotIndex = JIPArrayIndex select _index;
_team = (Format["WFBE_%1TEAMS",_sideText] Call GetNamespace) select _slotIndex;

if (mysql && !gameOver) then {
	_strTrans = if (_side == west) then {'west'} else {'east'};
	WF_Logic setVariable ["WF_MYSQL_SERVER",(WF_Logic getVariable "WF_MYSQL_SERVER") + [Format ["MYSQLDATA§WFBE_Disconnect_Player§%1§%2§%3§%4§%5",_uid,_name,round(time - (JIP_SQL_Time select _index)),_strTrans,worldName]]];
};

//--- Is unit driving the HQ?
_hq = WF_Logic getVariable Format ["%1MHQ",_sideText];
if (vehicle(leader _team) == _hq) then {unassignVehicle (leader _team);[leader _team] allowGetIn false;(leader _team) action ["EJECT", _hq]};

if (!keepAI) then {
	_units = units _team;
	_units = _units - [leader _team];
	_units = _units + ([_team,false] Call GetTeamVehicles) - [_hq];
	{deleteVehicle _x} forEach _units;
};

//--- Save the Client Cash.
_funds = _team Call GetTeamFunds;
JIPArrayCash set [_index,_funds];

//--- SetPos the AI.
_buildings = WF_Logic getVariable Format ["%1BaseStructures",_sideText];
_respawnLoc = _hq;
if (count _buildings > 0) then {
	_closestRespawn = [leader _team,_buildings] Call SortByDistance;
	_respawnLoc = _closestRespawn select 0;
};
(leader _team) setPos ([getPos _respawnLoc,20,30] Call GetRandomPosition);

//--- Is AI Enabled? if so we update the squads.
if (AI) then {[_team] ExecFSM "Server\FSM\aiteam.fsm"};

//--- ISIS.
if (ISIS) then {(leader _team) addEventHandler['handleDamage',{_this Call ISIS_Wound}]}; 

//--- Player was commander?.
_cmdrTeam = (_side) Call GetCommanderTeam;
if !(isNull (_cmdrTeam)) then {
	if (_team == _cmdrTeam) then {
		WF_Logic setVariable [Format ["%1CommanderTeam",_sideText],objNull,true];
		[_side,CMDLOCALIZEMESSAGE,"CommanderDisconnected"] Spawn CommandToSide;
		//--- High Command (Remove).
		if (highcommand && count (hcAllGroups (leader _team)) > 0) then {HCRemoveAllGroups (leader _team)};
		//--- AI Can move freely now & respawn at the default location.
		{[_x,false] Call SetTeamAutonomous;[_x, ""] Call SetTeamRespawn} forEach (Format["WFBE_%1TEAMS",_sideText] Call GetNamespace);
	};
};