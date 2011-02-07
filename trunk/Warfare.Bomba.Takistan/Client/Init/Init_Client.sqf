private['_base','_hqradio','_oc','_votetime','_weat','_lo','_buildings','_idbl','_txt','_commanderteam','_team','_isdeployed'];

waitUntil { !isNil "initJIP" };

ARTY_HandleILLUM = Compile preprocessFile "Client\Module\Arty\ARTY_HandleILLUM.sqf"; 
ARTY_HandleSADARM = Compile preprocessFile "Client\Module\Arty\ARTY_HandleSADARM.sqf"; 

if (paramArty) then {
	ARTY_Prep = Compile preprocessFile "Client\Module\Arty\ARTY_mobileMissionPrep.sqf";
	ARTY_Finish = Compile preprocessFile "Client\Module\Arty\ARTY_mobileMissionFinish.sqf";
	RequestFireMission = Compile preprocessFile "Client\Functions\Client_RequestFireMission.sqf";
};
if (paramBoundaries) then {
	BoundariesIsOnMap = Compile preprocessFile "Client\Functions\Client_IsOnMap.sqf";
	BoundariesHandleOnMap = Compile preprocessFile "Client\Functions\Client_HandleOnMap.sqf";
};
BuildUnit = Compile preprocessFile "Client\Functions\Client_BuildUnit.sqf";
ChangePlayerFunds = Compile preprocessFile "Client\Functions\Client_ChangePlayerFunds.sqf";
CommandChatMessage = Compile preprocessFile "Client\Functions\Client_CommandChatMessage.sqf";
CommanderUpgrade = Compile preprocessFile "Client\Functions\Client_CommanderUpgrade.sqf";
if (paramCounterMeasures) then {
	CM_Countermeasures = Compile preprocessFile "Client\Module\CM\CM_Countermeasures.sqf";
	CM_Flares = Compile preprocessFile "Client\Module\CM\CM_Flares.sqf";
	CM_Spoofing = Compile preprocessFile "Client\Module\CM\CM_Spoofing.sqf";
};
DebugHint = Compile preprocessFile "Client\Functions\Client_DebugHint.sqf";
DisplayInventory = Compile preprocessFile "Client\Functions\Client_DisplayInventory.sqf";
FX = Compile preprocessFile "Client\Functions\Client_FX.sqf";
GetIncome = Compile preprocessFile "Client\Functions\Client_GetIncome.sqf";
GetPlayerFunds = Compile preprocessFile "Client\Functions\Client_GetPlayerFunds.sqf";
GetStructureMarkerLabel = Compile preprocessFile "Client\Functions\Client_GetStructureMarkerLabel.sqf";
GroupChatMessage = Compile preprocessFile "Client\Functions\Client_GroupChatMessage.sqf";
HandleHQAction = Compile preprocessFile "Client\Functions\Client_HandleHQAction.sqf";
HandlePVF = Compile preprocessFile "Client\Functions\Client_HandlePVF.sqf";
if (paramISIS) then {ISIS_Effects = Compile preProcessFile "Client\Module\ISIS\ISIS_Clientfx.sqf"};
MarkerAnim = Compile preprocessFile "Client\Functions\Client_MarkerAnim.sqf";
PlayerKilled = Compile preprocessFile "Client\Client_Killed.sqf";
ReplaceArray = Compile preprocessFile "Client\Functions\Client_ReplaceArray.sqf";
ReplaceInventoryAmmo = Compile preprocessFile "Client\Functions\Client_ReplaceInventoryAmmo.sqf";

EHKeyboardButtonDown = Compile preprocessFile "Client\Functions\Client_EHKeyboardButtonDown.sqf";
EHMouseButtonDown = Compile preprocessFile "Client\Functions\Client_EHMouseButtonDown.sqf";
EHJoystickButtonDown = Compile preprocessFile "Client\Functions\Client_EHJoystickButtonDown.sqf";

Action_MissleCam = Compile preprocessFile "Module\CamMissle\action_misslecam.sqf";

if !(WF_A2_Vanilla) then {
	RespawningBag = Compile preprocessFile "Client\Functions\Client_RespawnBag.sqf";
	RemoveFlares = Compile preprocessFile "Client\Functions\Client_RemoveFlares.sqf";
} else {
	RespawningBag = {};
	RemoveFlares = {};
};
ReturnArraySortAsc = Compile preprocessFile "Client\Functions\Client_ReturnArraySortAsc.sqf";
TaskSystem = Compile preprocessFile "Client\Functions\Client_TaskSystem.sqf";
TitleTextMessage = Compile preprocessFile "Client\Functions\Client_TitleTextMessage.sqf";
UIAddItem = Compile preprocessFile "Client\Functions\Client_UIAddItem.sqf";
UIAddMagazine = Compile preprocessFile "Client\Functions\Client_UIAddMagazine.sqf";
UIGearFillList = Compile preprocessFile "Client\Functions\Client_UIGearFillList.sqf";
UIGearFillTemplateList = Compile preprocessFile "Client\Functions\Client_UIGearFillTemplateList.sqf";
if (paramICBM) then {
	Nuke = Compile preprocessFile "Client\Module\Nuke\nuke.sqf";
	NukeIncomming = Compile preprocessFile "Client\Module\Nuke\nukeincoming.sqf";
};
//--- Namespace related (GUI).
BIS_FNC_GUIset = {UInamespace setVariable [_this select 0, _this select 1]};
BIS_FNC_GUIget = {UInamespace getVariable (_this select 0)};

//--- Waiting for the common part to be executed.
waitUntil {commonInitComplete};

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
if (_idbl) exitWith {[] Spawn {_txt = "INFORMATION:\n\n You are currently blacklisted.";_txt Call DebugHint;sleep 5; disableUserInput true; sleep 60; disableUserInput false; failMission "END1"}};

//--- Global Client Variables.
sideJoined = side player;
sideJoinedText = str sideJoined;
sideID = sideJoined Call GetSideID;
clientID = player Call GetClientID;
clientTeam = group player;
clientTeams = (Format['WFBE_%1TEAMS',sideJoinedText] Call GetNamespace);
playerType = typeOf player;
playerDead = false;
paramBoundariesRunning = false;

commanderTeam = objNull;
isUpgrading = false;
upgradingTime = -1;
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
lastRepair = -200;
lastRearm = -200;
lastHeal = -200;
lastRefuel = -200;
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
townDefenceRange = false;

/* Airfields Init */
if (isNil "Airfields") then {Airfields = []};

/* Skill Module. */
[] Call Compile preprocessFile "Client\Module\Skill\Skill_Init.sqf";
[] Call WFBE_SK_FNC_Apply;

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
};
[] Spawn {
    private ['_lo','_commanderTeam'];
	_lo = false;
	while {!_lo} do {sleep 0.1;_commanderTeam = (sideJoined) Call GetCommanderTeam;if (!isNil '_commanderTeam') then {_lo = true}};
	/* Commander Handling */
	[] ExecFSM "Client\FSM\updateclient.fsm";
};
[] Call Compile preprocessFile "briefing.sqf";

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

_team = group player;
{ if (_x != player) then { deleteVehicle _x; } } forEach (units _team);

player setPos ([_base,20,30] Call GetRandomPositionEx);

/* HQ Building Init. */
waitUntil {!isNil Format ["%1MHQDeployed",sideJoinedText]};
_isDeployed = (sideJoinedText) Call GetSideHQDeployed;
if (_isDeployed) then {
	['WFBE_AREAHQDEPLOYED' Call GetNamespace,true,MCoin] Call Compile preprocessFile "Client\Init\Init_Coin.sqf";
} else {
	['WFBE_AREAHQUNDEPLOYED' Call GetNamespace,false,MCoin] Call Compile preprocessFile "Client\Init\Init_Coin.sqf";
};

/* Options menu. */
Options = player addAction ["<t color='#F8D664'>" + (localize "STR_WF_Options") + "</t>","Client\Action\Action_Menu.sqf", "", 1, false, true, "", ""];

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

/* Zeta Cargo Lifter. */
[] Call Compile preprocessFile "Client\Module\ZetaCargo\Zeta_Init.sqf";
/* Set Groups ID. */
[] Call Compile preprocessFile "Client\Functions\Client_SetGroupsID.sqf";

sleep 1;

/* Override player's Gear.*/
[player,Format ["WFBE_%1DEFAULTWEAPONS",sideJoinedText] Call GetNamespace,Format ["WFBE_%1DEFAULTAMMO",sideJoinedText] Call GetNamespace] Call EquipLoadout;
/* Default gear menu filler. */
WF_Logic setVariable ['filler','primary'];

//--- Handle Client keys: Disbale command Menu scanning, Factories Lock, etc.
EH_BTNUpdateTimeout = 0;
call compile preprocessFile "Client\Functions\Client_EHKeyboardLockWeaponInit.sqf";

(findDisplay 46) displayAddEventHandler ["KeyDown", "_this call EHKeyboardButtonDown"];
(findDisplay 46) displayAddEventHandler ["MouseButtonDown", "_this call EH_MouseButtonDown"];
(findDisplay 46) displayAddEventHandler ["JoystickButton", "_this call EHJoystickButtonDown"];


/* Vote System, define whether a vote is already running or not */
_voteTime = 0;
waitUntil {sleep 0.1;_voteTime = WF_Logic getVariable Format ["%1CommanderVoteTime",sideJoinedText];!(isNil '_voteTime')};
if (_voteTime > 0) then {createDialog "RscDisplayWFVoting"};

/* Debug System - Client */
if (WF_Debug) then {
	onMapSingleClick "if (_alt) then { vehicle player setpos _pos;(vehicle player) setVelocity [0,0,-0.1] };"; //--- Teleport
	//player addEventHandler ["HandleDamage", {false}];
	// player setCaptive true;
	player addEventHandler ["HandleDamage", {false;if (player != (_this select 3)) then {(_this select 3) setDammage 1}}]; //--- God-Slayer mode.
};

if (paramBuildDefencesInTown > 0) then {
	player addAction [localize 'STR_WF_BuildMenu_Repair','Client\Action\Action_BuildRepair.sqf', [], 99, false, true, '', 'townDefenceRange'];
};

Call Compile Format ["player addEventHandler ['Killed',{[_this select 0,_this select 1, %1] Spawn PlayerKilled;[_this select 0,_this select 1,%1,false] Spawn UnitKilled}]",sideJoined];
[player, side player] spawn ManagedUnitAdd;

/* ISIS Module */
if (paramISIS) then {player addEventHandler['handleDamage',{_this Call ISIS_Wound}]};

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

/* Towns Task System */
["TownAddComplete"] Spawn TaskSystem;

/* End Init */
finishMissionInit;

/* Client Init Done - Remove the blackout */
12452 cutText [(localize 'STR_WF_Loading')+"...","BLACK IN",5];