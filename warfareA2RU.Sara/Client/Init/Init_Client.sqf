Private ['_HQRadio','_base','_buildings','_condition','_get','_idbl','_isDeployed','_oc','_voteTime','_weat'];

sideJoined = side player;
sideJoinedText = str sideJoined;

//--- Position the client on the temp spawn (Common is not yet init'd so we call is straigh away).
player setPos ([getMarkerPos Format["%1TempRespawnMarker",sideJoinedText],1,10] Call Compile preprocessFile "Common\Functions\Common_GetRandomPosition.sqf");

ARTY_HandleILLUM = Compile preprocessFile "Client\Module\Arty\ARTY_HandleILLUM.sqf"; 
ARTY_HandleSADARM = Compile preprocessFile "Client\Module\Arty\ARTY_HandleSADARM.sqf"; 
if (paramArty) then {
	ARTY_Prep = Compile preprocessFile "Client\Module\Arty\ARTY_mobileMissionPrep.sqf";
	ARTY_Finish = Compile preprocessFile "Client\Module\Arty\ARTY_mobileMissionFinish.sqf";
	RequestFireMission = Compile preprocessFile "Client\Functions\Client_RequestFireMission.sqf"
};
if (paramBoundaries) then {
	BoundariesIsOnMap = Compile preprocessFile "Client\Functions\Client_IsOnMap.sqf";
	BoundariesHandleOnMap = Compile preprocessFile "Client\Functions\Client_HandleOnMap.sqf";
};
BuildUnit = Compile preprocessFile "Client\Functions\Client_BuildUnit.sqf";
ChangePlayerFunds = Compile preprocessFile "Client\Functions\Client_ChangePlayerFunds.sqf";
CommandChatMessage = Compile preprocessFile "Client\Functions\Client_CommandChatMessage.sqf";
if (paramCounterMeasures) then {
	CM_Countermeasures = Compile preprocessFile "Client\Module\CM\CM_Countermeasures.sqf";
	CM_Flares = Compile preprocessFile "Client\Module\CM\CM_Flares.sqf";
	CM_Spoofing = Compile preprocessFile "Client\Module\CM\CM_Spoofing.sqf";
};
DebugHint = Compile preprocessFile "Client\Functions\Client_DebugHint.sqf";
DisplayInventory = Compile preprocessFile "Client\Functions\Client_DisplayInventory.sqf";
FX = Compile preprocessFile "Client\Functions\Client_FX.sqf";
GetIncome = Compile preprocessFile "Client\Functions\Client_GetIncome.sqf";
GetMarkerColoration = Compile preprocessFile "Client\Functions\Client_GetMarkerColoration.sqf";
GetPlayerFunds = Compile preprocessFile "Client\Functions\Client_GetPlayerFunds.sqf";
GetRespawnAvailable = Compile preprocessFile "Client\Functions\Client_GetRespawnAvailable.sqf";
GetStructureMarkerLabel = Compile preprocessFile "Client\Functions\Client_GetStructureMarkerLabel.sqf";
GetTime = Compile preprocessFile "Client\Functions\Client_GetTime.sqf";
GroupChatMessage = Compile preprocessFile "Client\Functions\Client_GroupChatMessage.sqf";
HandleHQAction = Compile preprocessFile "Client\Functions\Client_HandleHQAction.sqf";
HandlePVF = Compile preprocessFile "Client\Functions\Client_HandlePVF.sqf";
MarkerAnim = Compile preprocessFile "Client\Functions\Client_MarkerAnim.sqf";
OnRespawnHandler = Compile preprocessFile "Client\Functions\Client_OnRespawnHandler.sqf";
PlayerKilled = Compile preprocessFile "Client\Client_Killed.sqf";
PreRespawnHandler = Compile preprocessFile "Client\Functions\Client_PreRespawnHandler.sqf";
ReplaceArray = Compile preprocessFile "Client\Functions\Client_ReplaceArray.sqf";
ReplaceInventoryAmmo = Compile preprocessFile "Client\Functions\Client_ReplaceInventoryAmmo.sqf";
if !(WF_A2_Vanilla) then {
	RespawningBag = Compile preprocessFile "Client\Functions\Client_RespawnBag.sqf";
} else {
	RespawningBag = {};
};
ReturnArraySortAsc = Compile preprocessFile "Client\Functions\Client_ReturnArraySortAsc.sqf";
SetControlFadeAnim = Compile preprocessFile "Client\Functions\Client_SetControlFadeAnim.sqf";
SetControlFadeAnimStop = Compile preprocessFile "Client\Functions\Client_SetControlFadeAnimStop.sqf";
SupportHeal = Compile preprocessFile "Client\Functions\Client_SupportHeal.sqf";
SupportRearm = Compile preprocessFile "Client\Functions\Client_SupportRearm.sqf";
SupportRefuel = Compile preprocessFile "Client\Functions\Client_SupportRefuel.sqf";
SupportRepair = Compile preprocessFile "Client\Functions\Client_SupportRepair.sqf";
TaskSystem = Compile preprocessFile "Client\Functions\Client_TaskSystem.sqf";
TitleTextMessage = Compile preprocessFile "Client\Functions\Client_TitleTextMessage.sqf";
UIAddItem = Compile preprocessFile "Client\Functions\Client_UIAddItem.sqf";
UIAddMagazine = Compile preprocessFile "Client\Functions\Client_UIAddMagazine.sqf";
UIChangeComboBuyUnits = Compile preprocessFile "Client\Functions\Client_UIChangeComboBuyUnits.sqf";
UIGearFillList = Compile preprocessFile "Client\Functions\Client_UIGearFillList.sqf";
UIGearFillTemplateList = Compile preprocessFile "Client\Functions\Client_UIGearFillTemplateList.sqf";
UIFillListBuyUnits = Compile preprocessFile "Client\Functions\Client_UIFillListBuyUnits.sqf";
UIFillListTeamOrders = Compile preprocessFile "Client\Functions\Client_UIFillListTeamOrders.sqf";
if (paramICBM) then {
	Nuke = Compile preprocessFile "Client\Module\Nuke\nuke.sqf";
	NukeIncomming = Compile preprocessFile "Client\Module\Nuke\nukeincoming.sqf";
};
//--- Namespace related (GUI).
BIS_FNC_GUIset = {UInamespace setVariable [_this select 0, _this select 1]};
BIS_FNC_GUIget = {UInamespace getVariable (_this select 0)};

clientInitComplete = true;

//--- Waiting for the common part to be executed.
waitUntil {commonInitComplete};

if (('WFBE_ISIS' Call GetNamespace) != 0) then {ISIS_Effects = Compile preProcessFile "Client\Module\ISIS\ISIS_Clientfx.sqf"};

//--- Queue Protection.
['WFBE_C_QUEUE_BARRACKS',0,true] Call SetNamespace;
['WFBE_C_QUEUE_BARRACKS_MAX',10,true] Call SetNamespace;
['WFBE_C_QUEUE_LIGHT',0,true] Call SetNamespace;
['WFBE_C_QUEUE_LIGHT_MAX',3,true] Call SetNamespace;
['WFBE_C_QUEUE_HEAVY',0,true] Call SetNamespace;
['WFBE_C_QUEUE_HEAVY_MAX',3,true] Call SetNamespace;
['WFBE_C_QUEUE_AIRCRAFT',0,true] Call SetNamespace;
['WFBE_C_QUEUE_AIRCRAFT_MAX',2,true] Call SetNamespace;
['WFBE_C_QUEUE_AIRPORT',0,true] Call SetNamespace;
['WFBE_C_QUEUE_AIRPORT_MAX',2,true] Call SetNamespace;
['WFBE_C_QUEUE_DEPOT',0,true] Call SetNamespace;
['WFBE_C_QUEUE_DEPOT_MAX',3,true] Call SetNamespace;

//--- Handle the Fast Time.
if (('WFBE_FASTTIMERATE' Call GetNamespace) > 0) then {[] ExecFSM "Client\FSM\fasttimecli.fsm"};

//--- Handle the weather.
_weat = 'WFBE_WEATHER' Call GetNamespace;
if (_weat == 3) then {
	[] ExecFSM "Client\FSM\overcast.fsm";
} else {
	_oc = 0.05;
	switch (_weat) do {
		case 0: {_oc = 0};
		case 1: {_oc = 0.5};
		case 2: {_oc = 1};
	};
	60 setOvercast _oc;
};
if (paramVolumClouds) then {[] Exec "CA\Modules\clouds\data\scripts\bis_cloudsystem.sqs"};

_idbl = [player] Call Compile preprocessFile "Client\Init\Init_Blacklist.sqf";
if (_idbl) exitWith {[] Spawn {Private["_txt"];_txt = "INFORMATION:\n\n You are currently blacklisted.";_txt Call DebugHint;sleep 5; disableUserInput true; sleep 60; disableUserInput false; failMission "END1"}};

//--- Global Client Variables.
sideID = sideJoined Call GetSideID;
clientID = player Call GetClientID;
clientIdentification = Format ["%1Slot%2",sideJoinedText,clientID];
clientTeam = group player;
clientTeams = (Format['WFBE_%1TEAMS',sideJoinedText] Call GetNamespace);
playerType = typeOf player;
playerDead = false;
paramBoundariesRunning = false;

commanderTeam = objNull;
buildingMarker = 0;
gearCost = 0;
currentTG = 25;
lastBuilt = [];
unitQueu = 0;
fireMissionTime = -1000;
artyRange = 15;
artyPos = [0,0,0];
playerUAV = objNull;
comTask = objNull;
voted = false;
votePopUp = true;
manningDefense = true;
currentFX = 0;
lastParaCall = -1200;
lastSupplyCall = -1200;
canBuildWHQ = true;

hqInRange = false;
barracksInRange = false;
gearInRange = false;
lightInRange = false;
heavyInRange = false;
aircraftInRange = false;
serviceInRange = false;
commandInRange = false;
depotInRange = false;
antiAirRadarInRange = false;
hangarInRange = false;

enableTeamSwitch false;

/* Airfields Init */
if (isNil "Airfields") then {Airfields = []};

/* Exec SQF|FSM Misc stuff. */
if (paramTrackPlayer) then {[] ExecFSM "Client\FSM\updateteamsmarkers.fsm"};
[] ExecFSM "Client\FSM\updateactions.fsm";
/* Don't pause the client initialization process. */
[] Spawn {
	waitUntil {townInit};
	/* Handle the capture GUI */
	[] ExecFSM "Client\FSM\updatecapture.fsm";
	/* Handle the map town markers */
	[] ExecFSM "Client\FSM\updatetownmarkers.fsm";
	waitUntil {!isNil Format["%1BaseStructures",sideJoinedText]};
	/* Handle the client actions */
	[] ExecFSM "Client\FSM\updateavailableactions.fsm";
	/* Resources Handler */
	if (('WFBE_INCOMESYSTEM' Call GetNamespace) != 3) then {(sideJoined) ExecFSM "Client\FSM\resources_cli.fsm"};
};
[] Spawn {
	Private ["_commanderTeam"];
	waitUntil{sleep 0.1;_commanderTeam = (sideJoined) Call GetCommanderTeam; !isNil '_commanderTeam';};
	/* Commander Handling */
	[] ExecFSM "Client\FSM\updateclient.fsm";
};
[] Call Compile preprocessFile "briefing.sqf";

/* HQ Radio system. */
waitUntil {!isNil Format ["BIS_WF_HQ%1",sideJoinedText]};
_HQRadio = Call Compile Format ["BIS_WF_HQ%1",sideJoinedText];
waitUntil {!isNil Format ["BIS_WF_HQ%1_TI",sideJoinedText]};
WFBE_V_HQTopicSide = Call Compile Format ["BIS_WF_HQ%1_TI",sideJoinedText];
_HQRadio setIdentity WFBE_V_HQTopicSide;
_HQRadio setRank "COLONEL";
_HQRadio setGroupId ["HQ"]; 
_HQRadio kbAddTopic [WFBE_V_HQTopicSide,"Client\kb\hq.bikb","Client\kb\hq.fsm",{call compile preprocessFileLineNumbers "Client\kb\hq.sqf"}];
player kbAddTopic [WFBE_V_HQTopicSide,"Client\kb\hq.bikb","Client\kb\hq.fsm",{call compile preprocessFileLineNumbers "Client\kb\hq.sqf"}];
sideHQ = _HQRadio;

/* Wait for a valid signal (Teamswaping) with failover */
if (isMultiplayer && paramKickTeamswappers && time > 5) then {
	_get = true;

	WFBE_RequestJoin = ['SRVFNCREQUESTJOIN',[getPlayerUID(player),sideJoined,name player,clientID]];
	publicVariable 'WFBE_RequestJoin';
	
	_timelaps = 0;
	while {true} do {
		sleep 0.05;
		_get = 'WFBE_P_CANJOIN' Call GetNamespace;
		if !(isNil '_get') exitWith {};
		
		_timelaps = _timelaps + 0.05;
		if (_timelaps > 10) then {
			_timelaps = 0;
			WFBE_RequestJoin = ['SRVFNCREQUESTJOIN',[getPlayerUID(player),sideJoined,name player,clientID]];
			publicVariable 'WFBE_RequestJoin';
		};
	};
	
	if !(_get) exitWith {
		(localize 'STR_WF_Teamswap_Warnning') Call CommandChatMessage;
		sleep 3;
		failMission "END1";
	};
};

/* Get the client starting location */
_base = objNull;
if (time < 30) then {
	waitUntil {!isNil Format ["%1StartingLocation",sideJoinedText]};
	_base = Call Compile Format ["%1StartingLocation",sideJoinedText];
} else {
	waitUntil {!isNil Format ["%1MHQ",sideJoinedText]};
	_base = (sideJoinedText) Call GetSideHQ;
	if !(alive _base) then {
		waitUntil {!isNil Format["%1BaseStructures",sideJoinedText]};
		_buildings = (sideJoinedText) Call GetSideStructures;
		if (count _buildings > 0) then {
			_base = _buildings select 0;
		} else {
			waitUntil {!isNil Format ["%1StartingLocation",sideJoinedText]};
			_base = Call Compile Format ["%1StartingLocation",sideJoinedText];
		};
	};
};

/* Positionate the client at the previously defined location */
player setPos ([getPos _base,20,30] Call GetRandomPosition);

/* HQ Building Init. */
waitUntil {!isNil Format ["%1MHQDeployed",sideJoinedText]};
_isDeployed = (sideJoinedText) Call GetSideHQDeployed;
if (_isDeployed) then {
	['WFBE_AREAHQDEPLOYED' Call GetNamespace,true,MCoin] Call Compile preprocessFile "Client\Init\Init_Coin.sqf";
} else {
	['WFBE_AREAHQUNDEPLOYED' Call GetNamespace,false,MCoin] Call Compile preprocessFile "Client\Init\Init_Coin.sqf";
};

/* Options menu. */
Options = player addAction ["<t color='#F8D664'>" + (localize "STR_WF_Options") + "</t>","Client\Action\Action_Menu.sqf", "", 1, false, true, "", "_target == player"];

/* Zeta Cargo Lifter. */
[] Call Compile preprocessFile "Client\Module\ZetaCargo\Zeta_Init.sqf";
/* Set Groups ID. */
[] Call Compile preprocessFile "Client\Functions\Client_SetGroupsID.sqf";

sleep 1;

/* Override player's Gear.*/
[player,Format ["WFBE_%1DEFAULTWEAPONS",sideJoinedText] Call GetNamespace,Format ["WFBE_%1DEFAULTAMMO",sideJoinedText] Call GetNamespace] Call EquipLoadout;
/* Default gear menu filler. */
WF_Logic setVariable ['filler','primary'];

/* Skill Module. */
[] Call Compile preprocessFile "Client\Module\Skill\Skill_Init.sqf";
(player) Call WFBE_SK_FNC_Apply;

/* Vote System, define whether a vote is already running or not */
_voteTime = 0;
waitUntil {sleep 0.1;_voteTime = WF_Logic getVariable Format ["%1CommanderVoteTime",sideJoinedText];!(isNil '_voteTime')};
if (_voteTime > 0) then {createDialog "RscDisplayWFVoting"};

/* Debug System - Client */
if (WF_Debug) then {
	onMapSingleClick "vehicle player setpos _pos;(vehicle player) setVelocity [0,0,-0.1];"; //--- Teleport
	//player addEventHandler ["HandleDamage", {false}];
	// player setCaptive true;
	player addEventHandler ["HandleDamage", {false;if (player != (_this select 3)) then {(_this select 3) setDammage 1}}]; //--- God-Slayer mode.
};

/* ISIS Module */
if (('WFBE_ISIS' Call GetNamespace) != 0) then {player addEventHandler['handleDamage',{_this Call ISIS_Wound}]};

/* Artillery UI */
if (paramArtyUI) then {[] ExecVM "ca\modules\ARTY\data\scripts\init.sqf"};

/* EASA */
if (paramEASA) then {[] Call Compile preProcessFile "Client\Module\EASA\EASA_Init.sqf"};

/* Key Binding */
[] Call Compile preprocessFile "Client\Init\Init_Keybind.sqf";

/* JIP Handler */
waitUntil {townInit};

sleep 3;
/* JIP System, initialize the camps and towns properly. */
[] Spawn {
	sleep 2;
	[] ExecVM "Client\Functions\Client_InitTownsAndCamps.sqf";
};

/* Repair Truck CoIn Handling. */
['WFBE_AREAREPAIRTRUCK' Call GetNamespace,false,RCoin,"REPAIR"] Call Compile preprocessFile "Client\Init\Init_Coin.sqf";

/* A new player come to reinforce the battlefield */
[sideJoinedText,'UnitsCreated',1] Call UpdateStatistics;

/* Towns Task System */
["TownAddComplete"] Spawn TaskSystem;

/* End Init */
finishMissionInit;

/* Client death handler. */
Call Compile Format ["player addEventHandler ['Killed',{[_this select 0,_this select 1] Spawn PlayerKilled;[_this select 0,_this select 1,%1,false] Spawn UnitKilled}]",sideJoined];

/* Client Init Done - Remove the blackout */
12452 cutText [(localize 'STR_WF_Loading')+"...","BLACK IN",5];