if (arty) then {
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
CommandToServer = Compile preprocessFile "Client\Client_CommandToServer.sqf";
CommanderUpgrade = Compile preprocessFile "Client\Functions\Client_CommanderUpgrade.sqf";
CommandsFromServer = Compile preprocessFile "Client\Client_CommandsFromServer.sqf";
if (counterMeasures) then {
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
InitTownsAndCamps = Compile preprocessFile "Client\Functions\Client_InitTownsAndCamps.sqf";
if (ISIS) then {ISIS_Effects = Compile preProcessFile "Client\Module\ISIS\ISIS_Clientfx.sqf"};
MarkerAnim = Compile preprocessFile "Client\Functions\Client_MarkerAnim.sqf";
PlayerKilled = Compile preprocessFile "Client\Client_Killed.sqf";
ReplaceInventoryAmmo = Compile preprocessFile "Client\Functions\Client_ReplaceInventoryAmmo.sqf";
TaskSystem = Compile preprocessFile "Client\Functions\Client_TaskSystem.sqf";
TitleTextMessage = Compile preprocessFile "Client\Functions\Client_TitleTextMessage.sqf";
if (icbm) then {
	Nuke = Compile preprocessFile "Client\Module\Nuke\nuke.sqf";
	NukeIncomming = Compile preprocessFile "Client\Module\Nuke\nukeincoming.sqf";
};
//--- Namespace related (GUI).
BIS_FNC_GUIset = {UInamespace setVariable [_this select 0, _this select 1]};
BIS_FNC_GUIget = {UInamespace getVariable (_this select 0)};

//--- Waiting for the common part to be executed.
waitUntil {commonInitComplete};

if (fastTime) then {[] ExecFSM "Client\FSM\fasttimecli.fsm"};
if (weather) then {[] ExecFSM "Client\FSM\overcast.fsm"};
if (volumClouds) then {[] Exec "CA\Modules\clouds\data\scripts\bis_cloudsystem.sqs"};

[] Spawn CommandsFromServer;
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

if (isNil "Airfields") then {Airfields = []};

//--- Exec SQF|FSM Misc stuff.
if (trackPlayer) then {[] ExecFSM "Client\FSM\updateteamsmarkers.fsm"};
[] ExecFSM "Client\FSM\updateactions.fsm";
//--- Don't pause the client initialization process.
[] Spawn {
	waitUntil {townInit};
	[] ExecFSM "Client\FSM\updatecapture.fsm";
	[] ExecFSM "Client\FSM\updatetownmarkers.fsm";
	waitUntil {_buildings = WF_Logic getVariable Format ["%1BaseStructures",sideJoinedText];!isNil "_buildings"};
	[] ExecFSM "Client\FSM\updateavailableactions.fsm";
};
[] Spawn {
	waitUntil{_commanderTeam = (sideJoined) Call GetCommanderTeam;!isNil "_commanderTeam"};
	[] ExecFSM "Client\FSM\updateclient.fsm";
};
[] Call Compile preprocessFile "briefing.sqf";

//--- Init Pos.
_base = objNull;
if (time < 30) then {
	waitUntil {_base = WF_Logic getVariable Format ["%1StartingLocation",sideJoinedText];!isNil "_base"};
} else {
	waitUntil {_base = WF_Logic getVariable Format ["%1MHQ",sideJoinedText];!isNil "_base"};
	if !(alive _base) then {
		_buildings = [];
		waitUntil {_buildings = WF_Logic getVariable Format ["%1BaseStructures",sideJoinedText];!isNil "_buildings"};
		if (count _buildings > 0) then {
			_base = _buildings select 0;
		} else {
			waitUntil {_base = WF_Logic getVariable Format ["%1StartingLocation",sideJoinedText];!isNil "_base"};
		};
	};
};

player setPos ([getPos _base,20,30] Call GetRandomPosition);

//--- Building Init.
_isDeployed = false;
waitUntil {_isDeployed = WF_Logic getVariable Format ["%1MHQDeployed",sideJoinedText];!isNil "_isDeployed"};
if (_isDeployed) then {
	['WFBE_AREAHQDEPLOYED' Call GetNamespace,true,MCoin] Call Compile preprocessFile "Client\Init\Init_Coin.sqf";
} else {
	['WFBE_AREAHQUNDEPLOYED' Call GetNamespace,false,MCoin] Call Compile preprocessFile "Client\Init\Init_Coin.sqf";
};

//--- Options menu.
Options = player addAction ["<t color='#F8D664'>" + (localize "STR_WF_Options") + "</t>","Client\Action\Action_Menu.sqf", "", 1, false, true, "", ""];

//--- Voice system.
_HQRadio = objNull;
waitUntil {_HQRadio = WF_Logic getVariable Format ["BIS_WF_HQ%1",sideJoinedText];!isNil "_HQRadio"};
_HQRadio setIdentity (_HQRadio getVariable "_topic_identity");
_HQRadio setRank "COLONEL";
_HQRadio setGroupId ["HQ"]; 
_HQRadio kbAddTopic [(_HQRadio getVariable "_topic_identity"),"Client\kb\hq.bikb","Client\kb\hq.fsm",{call compile preprocessFileLineNumbers "Client\kb\hq.sqf"}];
player kbAddTopic [(_HQRadio getVariable "_topic_identity"),"Client\kb\hq.bikb","Client\kb\hq.fsm",{call compile preprocessFileLineNumbers "Client\kb\hq.sqf"}];
sideHQ = _HQRadio;

//--- Define vehicles types that will have an 'Cargo Eject' function.
cargoHolder = ["MH60S","UH1Y","MV22","C130J","Mi17_Ins","Mi17_medevac_RU","Mi17_rockets_RU","Mi24_V","Mi24_P","MH6J_EP1",
"UH60M_EP1","UH60M_MEV_EP1","CH_47F_EP1","C130J_US_EP1","Mi17_TK_EP1","UH1H_TK_EP1","An2_TK_EP1","Mi24_D_TK_EP1"];
//--- Zeta Cargo Lifter.
[] Call Compile preprocessFile "Client\Module\ZetaCargo\Zeta_Init.sqf";
//--- Groups ID.
[] Call Compile preprocessFile "Client\Functions\Client_SetGroupsID.sqf";

sleep 1;

//--- Override player's Gear.
[player,Format ["WFBE_%1DEFAULTWEAPONS",sideJoinedText] Call GetNamespace,Format ["WFBE_%1DEFAULTAMMO",sideJoinedText] Call GetNamespace] Call EquipLoadout;
//--- Default gear menu filler.
WF_Logic setVariable ['filler','template'];

//--- Skill Module.
Skills_Soldiers = ['FR_R','RUS_Soldier1','US_Delta_Force_EP1','TK_Special_Forces_EP1'];
Skills_Engineers = ['USMC_SoldierS_Engineer','MVD_Soldier_TL','US_Soldier_Engineer_EP1','TK_Soldier_Engineer_EP1'];
Skills_Lockpick = ['FR_TL','RUS_Soldier_TL','US_Delta_Force_TL_EP1','TK_Special_Forces_TL_EP1'];
Skills_Spot = ['USMC_SoldierS_Sniper','RU_Soldier_Sniper','US_Soldier_Sniper_EP1','TK_Soldier_Sniper_EP1'];
Skills_MASH = ['FR_Commander','RUS_Commander','US_Soldier_SL_EP1','TK_Soldier_SL_EP1'];
[] Call Compile preprocessFile "Client\Module\Skill\Skill_Init.sqf";

//--- Spacebar scanning (HC Protection | ACE Safety | Proper Definition).
if !(spacebar) then {(findDisplay 46) displayAddEventHandler ["KeyDown", "if ((_this select 1) in (actionKeys 'ForceCommandingMode') && !(_this select 2) && !(_this select 3) && !hcShownBar) then {true} else {false}"]};

//--- Soldier Skill.
if (playerType in Skills_Soldiers) then {['WFBE_MAXGROUPSIZE',('WFBE_MAXGROUPSIZE' Call GetNameSpace) + ('WFBE_MAXGZBONUSSKILL' Call GetNamespace),true] Call SetNamespace};

//--- Init vote.
_voteTime = 0;
waitUntil {_voteTime = WF_Logic getVariable Format ["%1CommanderVoteTime",sideJoinedText];!isNil "_voteTime"};
if (_voteTime > 0) then {createDialog "RscDisplayWFVoting"};

//--- Debug
if (WF_Debug) then {
	onMapSingleClick "vehicle player setpos _pos"; //--- Teleport
	//player addEventHandler ["HandleDamage", {false}];
	player addEventHandler ["HandleDamage", {false;if (player != (_this select 3)) then {(_this select 3) setDammage 1}}]; //--- God-Slayer mode.
};

Call Compile Format ["player addEventHandler ['Killed',{[_this select 0,_this select 1] Spawn PlayerKilled;[_this select 0,_this select 1,%1,false] Spawn UnitKilled}]",sideJoined];

if (ISIS) then {player addEventHandler['handleDamage',{_this Call ISIS_Wound}]};

//--- Artillery UI.
if (artyUI) then {[] ExecVM "ca\modules\ARTY\data\scripts\init.sqf"};

//--- EASA.
if (paramEASA) then {[] Call Compile preProcessFile "Client\Module\EASA\EASA_Init.sqf"};

//--- JIP.
waitUntil {townInit};

sleep 3;
[] Call InitTownsAndCamps;

//--- Repair Truck builds.
['WFBE_AREAREPAIRTRUCK' Call GetNamespace,false,RCoin,"REPAIR"] Call Compile preprocessFile "Client\Init\Init_Coin.sqf";

_built = WF_Logic getVariable Format ["%1UnitsCreated",sideJoinedText];
_built = _built + 1;
WF_Logic setVariable [Format["%1UnitsCreated",sideJoinedText],_built,true];

["TownAddComplete"] Spawn TaskSystem;