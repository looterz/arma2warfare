Private ["_award","_location","_locationName","_mysqlUpdate","_name","_newScore","_objective","_ptask","_range","_sideToValue","_sideValue","_task","_units"];

_location = _this Select 0;
_sideValue = _this Select 1;
_sideToValue = _this Select 2;
_rewards = _this Select 3;
_name = str _location;
_mysqlUpdate = "";

if (_sideToValue != sideID) exitWith {};

_task = _location getVariable 'taskLink';
_ptask = currentTask player;
if (isNil '_task') then {_task = objNull};
_locationName = _location getVariable "name";

_marker1 = Format["%1Depot",_name];
_sideName = localize "STR_WF_Side_Resistance";

if (_sideValue == WESTID) then {_sideName = localize "STR_WF_Side_West"};
if (_sideValue == EASTID) then {_sideName = localize "STR_WF_Side_East"};
if (_sideValue == sideID) then {_marker1 setMarkerColorLocal "ColorGreen"} else {_marker1 setMarkerColorLocal "ColorRed"};
if (_sideValue == RESISTANCEID) then {_marker1 setMarkerColorLocal "ColorBlue"};

if (time > 10) then {[Format[Localize "STR_WF_Town_Captured",_locationName,_sideName]] Call TitleTextMessage};

if (_sideValue == sideID) then {
	_award = false;
	if ((leader group player) == player) then {
		_units = units group player;
		{if (_x distance _location < ('WFBE_TOWNCAPTURERANGE' Call GetNamespace)) then {_award = true}} forEach _units;
	};

	if (player distance _location < ('WFBE_TOWNCAPTURERANGE' Call GetNamespace) || _award) then {
		if (_task == _ptask) then {
			["TownHintDone",_location] Spawn TaskSystem;
				(_rewards select 0) Call ChangePlayerFunds;
				WFBE_RequestChangeScore = ['SRVFNCREQUESTCHANGESCORE',[player,score player + ('WFBE_SCORECAPTURETOWN' Call GetNamespace)]];
				publicVariable 'WFBE_RequestChangeScore';
			if (IsClientServer) then {['SRVFNCREQUESTCHANGESCORE',[player,score player + ('WFBE_SCORECAPTURETOWN' Call GetNamespace)]] Spawn HandleSPVF};
				Format[Localize "STR_WF_Town_Bounty_Full",_locationName,(_rewards select 0)] Call CommandChatMessage;		
				_mysqlUpdate = "towncaptured";				
			} else {
				(_rewards select 0) Call ChangePlayerFunds;
				WFBE_RequestChangeScore = ['SRVFNCREQUESTCHANGESCORE',[player,score player + ('WFBE_SCORECAPTURETOWN' Call GetNamespace)]];
				publicVariable 'WFBE_RequestChangeScore';
				if (IsClientServer) then {['SRVFNCREQUESTCHANGESCORE',[player,score player + ('WFBE_SCORECAPTURETOWN' Call GetNamespace)]] Spawn HandleSPVF};
				Format[Localize "STR_WF_Town_Bounty_Full",_locationName, (_rewards select 0)] Call CommandChatMessage;				
				_mysqlUpdate = "towncaptured";
			};
	} else {
		_range = (_location getVariable "range") * ('WFBE_TOWNCAPTUREASSISTRANGEMODIFIER' Call GetNamespace);
		if (player distance _location < _range) then {
			if (_task == _ptask) then {
				["TownHintDone",_location] Spawn TaskSystem;
					(_rewards select 1)*1.2 Call ChangePlayerFunds;
					WFBE_RequestChangeScore = ['SRVFNCREQUESTCHANGESCORE',[player,score player + ('WFBE_SCOREASSISTCAPTURETOWN' Call GetNamespace)]];
					publicVariable 'WFBE_RequestChangeScore';
					if (IsClientServer) then {['SRVFNCREQUESTCHANGESCORE',[player,score player + ('WFBE_SCOREASSISTCAPTURETOWN' Call GetNamespace)]] Spawn HandleSPVF};
					Format[Localize "STR_WF_Town_Bounty_Full",_locationName,(_rewards select 1)*1.2] Call CommandChatMessage;
					_mysqlUpdate = "townassist";					
				} else {
					(_rewards select 1) Call ChangePlayerFunds;
					WFBE_RequestChangeScore = ['SRVFNCREQUESTCHANGESCORE',[player,score player + ('WFBE_SCOREASSISTCAPTURETOWN' Call GetNamespace)]];
					publicVariable 'WFBE_RequestChangeScore';
					if (IsClientServer) then {['SRVFNCREQUESTCHANGESCORE',[player,score player + ('WFBE_SCOREASSISTCAPTURETOWN' Call GetNamespace)]] Spawn HandleSPVF};
					Format[Localize "STR_WF_Town_Bounty_Assist",_locationName, (_rewards select 1)] Call CommandChatMessage;
					_mysqlUpdate = "townassist";
				};			
			};
		};
	};

if (mysql) then {
	if (_mysqlUpdate != "") then {
		WF_Logic setVariable ["WF_MYSQL_CLIENT",(WF_Logic getVariable "WF_MYSQL_CLIENT") + [Format ["MYSQLDATA§WFBE_Update§%1§%2§%3§%4",getPlayerUID(player),name player,_mysqlUpdate,worldName]],true];
	};
};

if (!isNull commanderTeam && sideID == _sideValue) then {
	if (commanderTeam == group player) then {
		_bounty = ((_rewards select 0) + (_rewards select 1)) / 2;
		(_rewards select 0) Call ChangePlayerFunds;
		WFBE_RequestChangeScore = ['SRVFNCREQUESTCHANGESCORE',[player,score player + ('WFBE_COMMANDERTOWNCAPTURESCORE' Call GetNamespace)]];
		publicVariable 'WFBE_RequestChangeScore';
		if (IsClientServer) then {['SRVFNCREQUESTCHANGESCORE',[player,score player + ('WFBE_COMMANDERTOWNCAPTURESCORE' Call GetNamespace)]] Spawn HandleSPVF};
		Format[Localize "STR_WF_Commander_Bounty_Town",(_rewards select 0),_locationName] Call CommandChatMessage;
	};
};

/* Task Handling */
["TownUpdate",_location] Spawn TaskSystem;
if (sideID == _sideValue) then {
	if !(isNull _task) then {
		if (_ptask == _task) then {
			["TownAssignClosest"] Spawn TaskSystem;
		};
	};
};