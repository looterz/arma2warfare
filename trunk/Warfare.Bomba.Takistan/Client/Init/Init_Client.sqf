waitUntil { !isNil "initJIP" };

Skills_Soldiers = ['FR_R','RUS_Soldier1','US_Delta_Force_EP1','TK_Special_Forces_EP1'];
Skills_Engineers = ['USMC_SoldierS_Engineer','MVD_Soldier_TL','US_Soldier_Engineer_EP1','TK_Soldier_Engineer_EP1'];
Skills_Lockpick = ['FR_TL','RUS_Soldier_TL','US_Delta_Force_TL_EP1','TK_Special_Forces_TL_EP1'];
Skills_Spot = ['USMC_SoldierS_Sniper','RU_Soldier_Sniper','US_Soldier_Sniper_EP1','TK_Soldier_Sniper_EP1'];
Skills_MASH = ['FR_Commander','RUS_Commander','US_Soldier_SL_EP1','TK_Soldier_SL_EP1'];
Skills_Medic = ['RU_Soldier_Medic', 'USMC_Soldier_Medic', 'US_Delta_Force_Medic_EP1'];

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

RemoveFlares = Compile preprocessFile "Client\Functions\Client_RemoveFlares.sqf";
Action_MissleCam = Compile preprocessFile "Module\CamMissle\action_misslecam.sqf";


if !(WF_A2_Vanilla) then {
	RespawningBag = Compile preprocessFile "Client\Functions\Client_RespawnBag.sqf";
} else {
	RespawningBag = {};
};
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

if (paramFastTime) then {[] ExecFSM "Client\FSM\fasttimecli.fsm"};

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
if (_idbl) exitWith {[] Spawn {_txt = "INFORMATION:\n\n You are currently blacklisted.";_txt Call DebugHint;sleep 5; disableUserInput true; sleep 60; failMission "END1"}};

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
currentMission = objNull;
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
lastSkillUse = -1200;
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

if (isNil "Airfields") then {Airfields = []};

//--- Exec SQF|FSM Misc stuff.
if (paramTrackPlayer) then {[] ExecFSM "Client\FSM\updateteamsmarkers.fsm"};
[] ExecFSM "Client\FSM\updateactions.fsm";
//--- Don't pause the client initialization process.
[] Spawn {
	waitUntil {townInit};
	[] ExecFSM "Client\FSM\updatecapture.fsm";
	[] ExecFSM "Client\FSM\updatetownmarkers.fsm";
	waitUntil {!isNil Format["%1BaseStructures",sideJoinedText]};
	[] ExecFSM "Client\FSM\updateavailableactions.fsm";
};
[] Spawn {
	_lo = false;
	while {!_lo} do {sleep 0.1;_commanderTeam = (sideJoined) Call GetCommanderTeam;if (!isNil '_commanderTeam') then {_lo = true}};
	[] ExecFSM "Client\FSM\updateclient.fsm";
};
[] Call Compile preprocessFile "briefing.sqf";

//--- Init Pos.
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

player setPos ([_base,20,30] Call GetRandomPositionEx);

//--- Building Init.
waitUntil {!isNil Format ["%1MHQDeployed",sideJoinedText]};
_isDeployed = (sideJoinedText) Call GetSideHQDeployed;
if (_isDeployed) then {
	['WFBE_AREAHQDEPLOYED' Call GetNamespace,true,MCoin] Call Compile preprocessFile "Client\Init\Init_Coin.sqf";
} else {
	['WFBE_AREAHQUNDEPLOYED' Call GetNamespace,false,MCoin] Call Compile preprocessFile "Client\Init\Init_Coin.sqf";
};

//--- Options menu.
Options = player addAction ["<t color='#F8D664'>" + (localize "STR_WF_Options") + "</t>","Client\Action\Action_Menu.sqf", "", 1, false, true, "", ""];

//--- Voice system.
waitUntil {!isNil Format ["BIS_WF_HQ%1",sideJoinedText]};
_HQRadio = Call Compile Format ["BIS_WF_HQ%1",sideJoinedText];
waitUntil {!isNil Format ["BIS_WF_HQ%1_TI",sideJoinedText]};
_topicIdentity = Call Compile Format ["BIS_WF_HQ%1_TI",sideJoinedText];
_HQRadio setIdentity _topicIdentity;
_HQRadio setRank "COLONEL";
_HQRadio setGroupId ["HQ"]; 
_HQRadio kbAddTopic [_topicIdentity,"Client\kb\hq.bikb","Client\kb\hq.fsm",{call compile preprocessFileLineNumbers "Client\kb\hq.sqf"}];
player kbAddTopic [_topicIdentity,"Client\kb\hq.bikb","Client\kb\hq.fsm",{call compile preprocessFileLineNumbers "Client\kb\hq.sqf"}];
sideHQ = _HQRadio;

//--- Define vehicles types that will have an 'Cargo Eject' function.
cargoHolder = ["MH60S","UH1Y","MV22","C130J","Mi17_Ins","Mi17_medevac_RU","Mi17_rockets_RU","Mi24_V","Mi24_P","MH6J_EP1",
"UH60M_EP1","UH60M_MEV_EP1","CH_47F_EP1","C130J_US_EP1","Mi17_TK_EP1","UH1H_TK_EP1","An2_TK_EP1","Mi24_D_TK_EP1","BAF_Merlin_HC3_D","CH_47F_BAF"];
//--- Zeta Cargo Lifter.
[] Call Compile preprocessFile "Client\Module\ZetaCargo\Zeta_Init.sqf";
//--- Groups ID.
[] Call Compile preprocessFile "Client\Functions\Client_SetGroupsID.sqf";

sleep 1;

//--- Override player's Gear.
[player,Format ["WFBE_%1DEFAULTWEAPONS",sideJoinedText] Call GetNamespace,Format ["WFBE_%1DEFAULTAMMO",sideJoinedText] Call GetNamespace] Call EquipLoadout;
//--- Default gear menu filler.
WF_Logic setVariable ['filler','primary'];

//--- Skill Module.
[] Call Compile preprocessFile "Client\Module\Skill\Skill_Init.sqf";

//--- Handle Client keys: Disbale command Menu scanning, Factories Lock, etc.
EH_BTNUpdateTimeout = 0;
call compile preprocessFile "Client\Functions\Client_EHKeyboardLockWeaponInit.sqf";

(findDisplay 46) displayAddEventHandler ["KeyDown", "_this call EHKeyboardButtonDown"];
(findDisplay 46) displayAddEventHandler ["MouseButtonDown", "_this call EH_MouseButtonDown"];
(findDisplay 46) displayAddEventHandler ["JoystickButton", "_this call EHJoystickButtonDown"];

//--- Soldier Skill.
if (playerType in Skills_Soldiers) then {['WFBE_MAXGROUPSIZE',('WFBE_MAXGROUPSIZE' Call GetNameSpace) + ('WFBE_MAXGZBONUSSKILL' Call GetNamespace),true] Call SetNamespace};

//--- Init vote.
_voteTime = 0;
_lo = false;
while {!_lo} do {sleep 0.1;_voteTime = WF_Logic getVariable Format ["%1CommanderVoteTime",sideJoinedText];if !(isNil '_voteTime') then {_lo = true}};
if (_voteTime > 0) then {createDialog "RscDisplayWFVoting"};

//--- Debug
if (WF_Debug) then {
	onMapSingleClick "if (_alt) then { vehicle player setpos _pos };"; //--- Teleport
	//player addEventHandler ["HandleDamage", {false}];
	player addEventHandler ["HandleDamage", {false;if (player != (_this select 3)) then {(_this select 3) setDammage 1}}]; //--- God-Slayer mode.
} else {
};

if (paramBuildDefencesInTown > 0) then {
	player addAction [localize 'STR_WF_BuildMenu_Repair','Client\Action\Action_BuildRepair.sqf', [], 99, false, true, '', 'townDefenceRange'];
};

Call Compile Format ["player addEventHandler ['Killed',{[_this select 0,_this select 1] Spawn PlayerKilled;}]",sideJoined];

if (paramISIS) then {player addEventHandler['handleDamage',{_this Call ISIS_Wound}]};

//--- Artillery UI.
if (paramArtyUI) then {[] ExecVM "ca\modules\ARTY\data\scripts\init.sqf"};

//--- EASA.
if (paramEASA) then {[] Call Compile preProcessFile "Client\Module\EASA\EASA_Init.sqf"};

//--- JIP.
waitUntil {townInit};

sleep 3;
[] Spawn {
	sleep 2;
	[] ExecVM "Client\Functions\Client_InitTownsAndCamps.sqf";
};

//--- Repair Truck builds.
['WFBE_AREAREPAIRTRUCK' Call GetNamespace,false,RCoin,"REPAIR"] Call Compile preprocessFile "Client\Init\Init_Coin.sqf";

["TownAddComplete"] Spawn TaskSystem;

/* Client Init Done - Remove the blackout */
12452 cutText [(localize 'STR_WF_Loading')+"...","BLACK IN",5];