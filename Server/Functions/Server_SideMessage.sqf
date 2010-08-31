Private ["_canSpeak","_extra","_side","_speaker","_special","_specialb","_topicSide"];
_special = _this select 0;
_specialb = _this select 1;
_side = _this select 2;
_extra = "";
if (count _this > 3) then {_extra = _this select 3};

_speaker = BIS_WF_HQEAST; _receiver = BIS_WF_HQEAST2; 
if (_side == west) then {_speaker = BIS_WF_HQWEST;_receiver = BIS_WF_HQWEST2};
_topicSide = _speaker getVariable "_topic_identity";

if (_special == "Destroyed" || _special == "IsUnderAttack" || _special == "Constructed") then {
	_localizedString = localize "strwfbarracks";
	_value = "Barracks";
	switch (typeName _specialb) do {
		case "OBJECT": {
			_localizedString = _specialb getVariable "name";
			_value = _extra;
		};
		case "STRING": {
			if (_specialb == ('WFBE_WESTMHQNAME' Call GetNamespace) || _specialb == ('WFBE_EASTMHQNAME' Call GetNamespace)) then {_localizedString = localize "STRHeadquarters";_value = "Headquarters";if (_special == "Constructed") then {_special = "Mobilized"}};
			if (_specialb == WESTHQ || _specialb == EASTHQ) then {_localizedString = localize "STRHeadquarters";_value = "Headquarters";if (_special == "Constructed") then {_special = "Deployed"}};
			if (_specialb == WESTLVF || _specialb == EASTLVF) then {_localizedString = localize "STRLightVehicleSupply";_value = "LightVehicleSupply"};
			if (_specialb == WESTCC || _specialb == EASTCC) then {_localizedString = localize "STR_WF_CommandCenter";_value = "UAVTerminal"};
			if (_specialb == WESTHEAVY || _specialb == EASTHEAVY) then {_localizedString = localize "STRHeavyVehicleSupply";_value = "HeavyVehicleSupply"};
			if (_specialb == WESTAIR || _specialb == EASTAIR) then {_localizedString = localize "STRHelipad";_value = "Helipad"};
			if (_specialb == WESTSP || _specialb == EASTSP) then {_localizedString = localize "STRServicePoint";_value = "ServicePoint"};
			if (_specialb == WESTAAR || _specialb == EASTAAR) then {_localizedString = localize "STRAntiAirRadar";_value = "AntiAirRadar"};
		};
	};
	_speaker kbTell [_receiver, _topicSide, _special,["1","",_localizedString,[_value]],true];
};

if (_special == "Lost" || _special == "Captured" || _special == "HostilesDetectedNear") then {
	_locRaw = str _specialb;
	_rlName = _specialb getVariable "name";
	_canSpeak = if (_side == east && WF_A2_CombinedOps && worldName in ('WFBE_WORLDWHITELISTVA' Call GetNamespace)) then {true} else {false};
	if (!_canSpeak) then {_canSpeak = if (_side == west && WF_A2_CombinedOps && worldName in ('WFBE_WORLDWHITELISTOA' Call GetNamespace)) then {true} else {false}};
	if (!_canSpeak) then {_canSpeak = if (WF_A2_Vanilla && worldName in ('WFBE_WORLDWHITELISTVA' Call GetNamespace)) then {true} else {false}};
	if (!_canSpeak) then {_canSpeak = if (WF_A2_Arrowhead && worldName in ('WFBE_WORLDWHITELISTOA' Call GetNamespace)) then {true} else {false}};
	
	if !(_canSpeak) then {_locRaw = "Town"} else {
		switch (_locRaw) do {
			case "Vyshnoye": {_locRaw = "Vyshnoe"};
			case "Shahbaz": {_locRaw = "Town"};
			case "Qeslaq": {_locRaw = "Town"};
		};
	};
	_speaker kbTell [_receiver, _topicSide, _special,["1","",_rlName,[_locRaw]],true];
};
if (_special == "VotingForNewCommander" || _special == "NewIntelAvailable") then {_speaker kbTell [_receiver, _topicSide, _special,true]};
if (_special == "CapturedNear" || _special == "LostAt") then {
	_locRaw = str _extra;
	_rlName = _extra getVariable "name";
	_canSpeak = if (_side == east && WF_A2_CombinedOps && worldName in ('WFBE_WORLDWHITELISTVA' Call GetNamespace)) then {true} else {false};
	if (!_canSpeak) then {_canSpeak = if (_side == west && WF_A2_CombinedOps && worldName in ('WFBE_WORLDWHITELISTOA' Call GetNamespace)) then {true} else {false}};
	if (!_canSpeak) then {_canSpeak = if (WF_A2_Vanilla && worldName in ('WFBE_WORLDWHITELISTVA' Call GetNamespace)) then {true} else {false}};
	if (!_canSpeak) then {_canSpeak = if (WF_A2_Arrowhead && worldName in ('WFBE_WORLDWHITELISTOA' Call GetNamespace)) then {true} else {false}};
	
	if !(_canSpeak) then {_locRaw = "Town"} else {
		switch (_locRaw) do {
			case "Vyshnoye": {_locRaw = "Vyshnoe"};
			case "Shahbaz": {_locRaw = "Town"};
			case "Qeslaq": {_locRaw = "Town"};
		};
	};
	_speaker kbTell [_receiver, _topicSide, _special,["1","",_specialb,[_specialb]],["2","",_rlName,[_locRaw]],true];
};