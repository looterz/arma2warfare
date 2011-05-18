Private ["_award","_location","_locationName","_mysqlUpdate","_name","_newScore","_objective","_range","_sideToValue","_sideValue","_units"];

_location = _this Select 0;
_sideValue = _this Select 1;
_sideToValue = _this Select 2;
_name = Str _location;
_mysqlUpdate = "";

if (_sideToValue != sideID) exitWith {};

_locationName = _location getVariable "name";

_marker1 = Format["%1Depot",_name];
_sideName = Localize "STR_WF_Side_Resistance";

if (_sideValue == WESTID) then {_sideName = Localize "STR_WF_Side_West"};
if (_sideValue == EASTID) then {_sideName = Localize "STR_WF_Side_East"};
if (_sideValue == sideID) then {_marker1 SetMarkerColorLocal "ColorGreen"} else {_marker1 SetMarkerColorLocal "ColorRed"};
if (_sideValue == RESISTANCEID) then {_marker1 SetMarkerColorLocal "ColorBlue"};

if (time > 10) then {[Format[Localize "STR_WF_Town_Captured",_locationName,_sideName]] Call TitleTextMessage};

cutText["","PLAIN"];

if (_sideValue == sideID) then {
	_award = false;
	if ((Leader Group player) == player) then {
		_units = Units Group player;
		{if (_x Distance _location < ('WFBE_TOWNCAPTURERANGE' Call GetNamespace)) then {_award = true}} ForEach _units;
	};

	if (player Distance _location < ('WFBE_TOWNCAPTURERANGE' Call GetNamespace) || _award) then {
		if (isNull currentMission) then {
			('WFBE_TOWNCAPTUREBOUNTY' Call GetNamespace) Call ChangePlayerFunds;
			WFBE_RequestChangeScore = ['SRVFNCREQUESTCHANGESCORE',[player,score player + ('WFBE_SCORECAPTURETOWN' Call GetNamespace)]];
			publicVariable 'WFBE_RequestChangeScore';
			if (IsClientServer) then {['SRVFNCREQUESTCHANGESCORE',[player,score player + ('WFBE_SCORECAPTURETOWN' Call GetNamespace)]] Spawn HandleSPVF};
			Format[Localize "STR_WF_Town_Bounty_Full",_locationName,('WFBE_TOWNCAPTUREBOUNTY' Call GetNamespace)] Call CommandChatMessage;
			_mysqlUpdate = "towncaptured";
		} else {
			if (currentMission == _location) then {
				["TownSuccess",currentMission] Spawn TaskSystem;
				["TownHintDone",currentMission] Spawn TaskSystem;
				('WFBE_TOWNMISSIONCAPTUREBOUNTY' Call GetNamespace) Call ChangePlayerFunds;
				WFBE_RequestChangeScore = ['SRVFNCREQUESTCHANGESCORE',[player,score player + ('WFBE_SCORECAPTURETOWN' Call GetNamespace)]];
				publicVariable 'WFBE_RequestChangeScore';
				if (IsClientServer) then {['SRVFNCREQUESTCHANGESCORE',[player,score player + ('WFBE_SCORECAPTURETOWN' Call GetNamespace)]] Spawn HandleSPVF};
				Format[Localize "STR_WF_Town_Bounty_Full",_locationName,('WFBE_TOWNMISSIONCAPTUREBOUNTY' Call GetNamespace)] Call CommandChatMessage;		
				_mysqlUpdate = "towncaptured";				
			} else {
				('WFBE_TOWNCAPTUREBOUNTY' Call GetNamespace) Call ChangePlayerFunds;
				WFBE_RequestChangeScore = ['SRVFNCREQUESTCHANGESCORE',[player,score player + ('WFBE_SCORECAPTURETOWN' Call GetNamespace)]];
				publicVariable 'WFBE_RequestChangeScore';
				if (IsClientServer) then {['SRVFNCREQUESTCHANGESCORE',[player,score player + ('WFBE_SCORECAPTURETOWN' Call GetNamespace)]] Spawn HandleSPVF};
				Format[Localize "STR_WF_Town_Bounty_Full",_locationName,('WFBE_TOWNCAPTUREBOUNTY' Call GetNamespace)] Call CommandChatMessage;				
				_mysqlUpdate = "towncaptured";
			};
		};
	} else {
		_range = (_location getVariable "range") * ('WFBE_TOWNCAPTUREASSISTRANGEMODIFIER' Call GetNamespace);
		if (player Distance _location < _range) then {
			if (isNull currentMission) then {
				('WFBE_TOWNASSISTCAPTUREBOUNTY' Call GetNamespace) Call ChangePlayerFunds;
				WFBE_RequestChangeScore = ['SRVFNCREQUESTCHANGESCORE',[player,score player + ('WFBE_SCOREASSISTCAPTURETOWN' Call GetNamespace)]];
				publicVariable 'WFBE_RequestChangeScore';
				if (IsClientServer) then {['SRVFNCREQUESTCHANGESCORE',[player,score player + ('WFBE_SCOREASSISTCAPTURETOWN' Call GetNamespace)]] Spawn HandleSPVF};
				Format[Localize "STR_WF_Town_Bounty_Assist",_locationName,('WFBE_TOWNASSISTCAPTUREBOUNTY' Call GetNamespace)] Call CommandChatMessage;
				_mysqlUpdate = "townassist";
			} else {
				if (currentMission == _location) then {
					["TownSuccess",currentMission] Spawn TaskSystem;
					["TownHintDone",currentMission] Spawn TaskSystem;
					('WFBE_TOWNMISSIONASSISTCAPTUREBOUNTY' Call GetNamespace) Call ChangePlayerFunds;
					WFBE_RequestChangeScore = ['SRVFNCREQUESTCHANGESCORE',[player,score player + ('WFBE_SCOREASSISTCAPTURETOWN' Call GetNamespace)]];
					publicVariable 'WFBE_RequestChangeScore';
					if (IsClientServer) then {['SRVFNCREQUESTCHANGESCORE',[player,score player + ('WFBE_SCOREASSISTCAPTURETOWN' Call GetNamespace)]] Spawn HandleSPVF};
					Format[Localize "STR_WF_Town_Bounty_Full",_locationName,('WFBE_TOWNMISSIONASSISTCAPTUREBOUNTY' Call GetNamespace)] Call CommandChatMessage;
					_mysqlUpdate = "townassist";					
				} else {
					('WFBE_TOWNASSISTCAPTUREBOUNTY' Call GetNamespace) Call ChangePlayerFunds;
					WFBE_RequestChangeScore = ['SRVFNCREQUESTCHANGESCORE',[player,score player + ('WFBE_SCOREASSISTCAPTURETOWN' Call GetNamespace)]];
					publicVariable 'WFBE_RequestChangeScore';
					if (IsClientServer) then {['SRVFNCREQUESTCHANGESCORE',[player,score player + ('WFBE_SCOREASSISTCAPTURETOWN' Call GetNamespace)]] Spawn HandleSPVF};
					Format[Localize "STR_WF_Town_Bounty_Assist",_locationName,('WFBE_TOWNASSISTCAPTUREBOUNTY' Call GetNamespace)] Call CommandChatMessage;
					_mysqlUpdate = "townassist";
				};			
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
	if (commanderTeam == Group player) then {
		_bounty = (_location getVariable "startingSupplyValue") * ('WFBE_COMMANDERTOWNCAPTURECOEF' Call GetNamespace);
		_bounty Call ChangePlayerFunds;
		WFBE_RequestChangeScore = ['SRVFNCREQUESTCHANGESCORE',[player,score player + ('WFBE_COMMANDERTOWNCAPTURESCORE' Call GetNamespace)]];
		publicVariable 'WFBE_RequestChangeScore';
		if (IsClientServer) then {['SRVFNCREQUESTCHANGESCORE',[player,score player + ('WFBE_COMMANDERTOWNCAPTURESCORE' Call GetNamespace)]] Spawn HandleSPVF};
		Format[Localize "STR_WF_Commander_Bounty_Town",_bounty,_locationName] Call CommandChatMessage;
	};
};

if !(isNull currentMission) then {
	if (currentMission == _location) then {
		["TownRemove",currentMission] Call TaskSystem;
		currentMission = objNull;
		["TownAddComplete"] Spawn TaskSystem;
	};
};