Private ["_award", "_awardValue", "_rewards", "_location","_locationName","_mysqlUpdate","_name","_locations","_objective","_range","_side","_sideValue","_units"];

_location = _this Select 0;
_sideValue = _this Select 1;
_rewards = _this select 2;
_name = Str _location;
_mysqlUpdate = "";

format["TownCapturePublic: %1", _this] call LogHigh;
_locationName = _location getVariable "name";

_sideName = Localize "STR_WF_Side_East";
if (_sideValue == WESTID) then {_sideName = Localize "STR_WF_Side_West"};

[Format[Localize "STR_WF_Town_Captured",_locationName,_sideName]] Call TitleTextMessage;
_marker1 = Format["%1Depot",_name];

if (_sideValue == sideID) then {_marker1 SetMarkerColorLocal "ColorGreen"} else {_marker1 SetMarkerColorLocal "ColorRed"};

cutText["","PLAIN"];

if (_sideValue == sideID) then {
	_award = false;
	_range = ('WFBE_TOWNCAPTURERANGE' Call GetNamespace);
	
	if ((Leader Group player) == player) then {
		_units = Units Group player;
		{if (_x Distance _location < _range) then {_award = true};} ForEach _units;
	};
	
	if (isNil "currentMission") then {
		currentMission = objNull;
	};

	if (player Distance _location < _range || _award) then {
		format["TownCapturePublic: Assault Distance %1 range:%2", player Distance _location, _range] call LogHigh;
		format["TownCapturePublic: CurrentMission: %1", currentMission] call LogHigh;
	
		if (isNull currentMission) then {
			format["TownCapturePublic: Assault currentMission is Null"] call LogHigh;
			(_rewards select 0) Call ChangePlayerFunds;
			WFBE_RequestChangeScore = ['SRVFNCREQUESTCHANGESCORE',[player,score player + ('WFBE_SCORECAPTURETOWN' Call GetNamespace)]];
			publicVariable 'WFBE_RequestChangeScore';
			if (IsClientServer) then {['SRVFNCREQUESTCHANGESCORE',[player,score player + ('WFBE_SCORECAPTURETOWN' Call GetNamespace)]] Spawn HandleSPVF};
			Format[Localize "STR_WF_Town_Bounty_Full",_locationName,(_rewards select 0)] Call CommandChatMessage;
			_mysqlUpdate = "towncaptured";
		} else {
			if (currentMission == _location) then {
				format["TownCapturePublic: Assault currentMission is %1", _location] call LogHigh;
			
				["TownSuccess",currentMission] Spawn TaskSystem;
				["TownHintDone",currentMission] Spawn TaskSystem;
				((_rewards select 0)*1.2) Call ChangePlayerFunds;
				WFBE_RequestChangeScore = ['SRVFNCREQUESTCHANGESCORE',[player,score player + ('WFBE_SCORECAPTURETOWN' Call GetNamespace)]];
				publicVariable 'WFBE_RequestChangeScore';
				if (IsClientServer) then {['SRVFNCREQUESTCHANGESCORE',[player,score player + ('WFBE_SCORECAPTURETOWN' Call GetNamespace)]] Spawn HandleSPVF};
				Format[Localize "STR_WF_Town_Bounty_Full",_locationName, ((_rewards select 0)*1.2) ] Call CommandChatMessage;
				_mysqlUpdate = "towncaptured";
			} else {
				format["TownCapturePublic: Assault currentMission is not %1, award: %2", _location, _rewards select 0] call LogHigh;
			
				(_rewards select 0) Call ChangePlayerFunds;
				WFBE_RequestChangeScore = ['SRVFNCREQUESTCHANGESCORE',[player,score player + ('WFBE_SCORECAPTURETOWN' Call GetNamespace)]];
				publicVariable 'WFBE_RequestChangeScore';
				if (IsClientServer) then {['SRVFNCREQUESTCHANGESCORE',[player,score player + ('WFBE_SCORECAPTURETOWN' Call GetNamespace)]] Spawn HandleSPVF};
				Format[Localize "STR_WF_Town_Bounty_Full",_locationName,(_rewards select 0)] Call CommandChatMessage;
				_mysqlUpdate = "towncaptured";
			};
		};
	} else {
		_range = (_location getVariable "range") * ('WFBE_TOWNCAPTUREASSISTRANGEMODIFIER' Call GetNamespace);		
		format["TownCapturePublic: Assist Distance %1 range:%2", player Distance _location, _range] call LogHigh;
		
		if (player Distance _location < _range) then {
			if (isNull currentMission) then {
				(_rewards select 1) Call ChangePlayerFunds;
				WFBE_RequestChangeScore = ['SRVFNCREQUESTCHANGESCORE',[player,score player + ('WFBE_SCOREASSISTCAPTURETOWN' Call GetNamespace)]];
				publicVariable 'WFBE_RequestChangeScore';
				if (IsClientServer) then {['SRVFNCREQUESTCHANGESCORE',[player,score player + ('WFBE_SCOREASSISTCAPTURETOWN' Call GetNamespace)]] Spawn HandleSPVF};
				Format[Localize "STR_WF_Town_Bounty_Assist",_locationName,(_rewards select 1)] Call CommandChatMessage;
				_mysqlUpdate = "townassist";
			} else {
				if (currentMission == _location) then {
					["TownSuccess",currentMission] Spawn TaskSystem;
					["TownHintDone",currentMission] Spawn TaskSystem;
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
					Format[Localize "STR_WF_Town_Bounty_Assist",_locationName,(_rewards select 1)] Call CommandChatMessage;
					_mysqlUpdate = "townassist";
				};			
			};
		};
	};
};

if (mysql) then {
	if (_mysqlUpdate != "") then {
		WF_Logic setVariable ["WF_MYSQL_CLIENT",(WF_Logic getVariable "WF_MYSQL_CLIENT") + [Format ["MYSQLDATA�WFBE_Update�%1�%2�%3�%4",getPlayerUID(player),name player,_mysqlUpdate,worldName]],true];
	};
};

if (!isNull commanderTeam && sideID == _sideValue) then {
	if (commanderTeam == Group player) then {
		_bounty = floor(((_rewards select 0) + (_rewards select 1)) / 2);
		_bounty Call ChangePlayerFunds;
		WFBE_RequestChangeScore = ['SRVFNCREQUESTCHANGESCORE',[player,score player + ('WFBE_COMMANDERTOWNCAPTURESCORE' Call GetNamespace)]];
		publicVariable 'WFBE_RequestChangeScore';
		if (IsClientServer) then {['SRVFNCREQUESTCHANGESCORE',[player,score player + ('WFBE_COMMANDERTOWNCAPTURESCORE' Call GetNamespace)]] Spawn HandleSPVF};
		Format[Localize "STR_WF_Commander_Bounty_Town",_bounty, _locationName] Call CommandChatMessage;
	};
};

if !(isNull currentMission) then {
	if (currentMission == _location) then {
		["TownRemove",currentMission] Call TaskSystem;
		currentMission = objNull;
		["TownAddComplete"] Spawn TaskSystem;
	};
};