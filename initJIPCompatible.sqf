//--- Global Init, first file called.

//--- Client Init.
if (!isServer) then {waitUntil {player == player}};

setViewDistance 4000;

commonInitComplete = false;
serverInitComplete = false;
gameOver = false;
townInit = false;
towns = [];

/* Hybrid */
//--- Define which 'part' of the game to run.
#include "version.sqf"

WF_A2_Vanilla = false;
#ifdef VANILLA
	WF_A2_Vanilla = true;
#endif

WF_A2_Arrowhead = false;
#ifdef ARROWHEAD
	WF_A2_Arrowhead = true;
#endif

WF_A2_CombinedOps = false;
#ifdef COMBINEDOPS
	WF_A2_CombinedOps = true;
#endif

WF_Debug = false;
#ifdef WF_DEBUG
	WF_Debug = true;
#endif

//--- Gameplay variables.
campRespawn = true;
mobileRespawn = true;
campRespawnRule = true;
balancing = false;
weather = true;
fastTime = false;
AI = true;
AIcom = true;
spacebar = true;
kamov = false;
showUID = true;
arty = true;
artyUI = true;
trackAI = true;
trackPlayer = true;
res = true;
resPatrol = false;
resStriker = false;
occup = true;
gearRespawn = true;
gearRestriction = false;
advancedAir = false;
hangars = true;
AARadar = false;
fastTravel = false;
counterMeasures = false;
autoDefense = true;
volumClouds = true;
icbm = true;
highcommand = true;
baseArea = true;
spawnSystemRestrict = true;
allies = false;
paramUpgradesEast = true;
paramUpgradesWest = true;
ISIS = false;
kickTeamswappers = true;
respawnMASH = true;
resReinf = false;
occReinf = false;
buyInfDepot = false;
handleFF = true;	// --- handle factory fire
paramBoundaries = true;
paramBasePatrols = false;
paramAlice = false;
paramEASA = true;
baseFrendlyFire = true;

missionNamespace setVariable ['WFBE_EASTSTARTINGMONEY',200000];
missionNamespace setVariable ['WFBE_WESTSTARTINGMONEY',200000];
EastSupplies = 100000;
WestSupplies = 100000;

//--- Special, require a clipboard handler on windows.
mysql = false;
#ifdef MYSQL
	mysql =	if (isMultiplayer) then {true} else {false};
#endif

//--- 1.04 New Parameters system. Multiplayer.
if (!isNil "paramsArray") then {
	_u = 0;
	missionNamespace setVariable ['WFBE_MAXGROUPSIZEAI',(paramsArray select _u)];_u = _u + 1;
	missionNamespace setVariable ['WFBE_MAXGROUPSIZE',(paramsArray select _u)];_u = _u + 1;
	if ((paramsArray select _u) == 0) then {keepAI = false} else {keepAI = true};_u = _u + 1; //--- Keep AI Units over JIP.
	if ((paramsArray select _u) == 0) then {AI = false} else {AI = true};_u = _u + 1; //--- AI Enabled.
	if ((paramsArray select _u) == 0) then {arty = false} else {arty = true};_u = _u + 1; //--- Enable Artillery.
	if ((paramsArray select _u) == 0) then {artyUI = false} else {artyUI = true};_u = _u + 1; //--- Enable Artillery Interface (Artillery Module).
	missionNamespace setVariable ['WFBE_ARTILLERYMAXRANGE',(paramsArray select _u)];_u = _u + 1;
	if ((paramsArray select _u) == 0) then {AIcom = false} else {AIcom = true};_u = _u + 1; //--- AI Commander Enabled.
	if !(WF_A2_Arrowhead) then {if ((paramsArray select _u) == 0) then {allies = false} else {allies = true};_u = _u + 1}; //--- Allies.
	if ((paramsArray select _u) == 0) then {AARadar = false} else {AARadar = true};_u = _u + 1; //--- Anti Air Radar.
	if ((paramsArray select _u) == 0) then {baseArea = false} else {baseArea = true};_u = _u + 1; //--- Base Area.
	missionNamespace setVariable ['WFBE_BASEAREAMAX',(paramsArray select _u)];_u = _u + 1;
	if ((paramsArray select _u) == 0) then {autoDefense = false} else {autoDefense = true};_u = _u + 1; //--- Auto Defenses Manning.
	missionNamespace setVariable ['WFBE_DEFENSEMANRANGE',(paramsArray select _u)];_u = _u + 1;
	//--- Building Limits.
	missionNamespace setVariable ['WFBE_BUILDINGMAXBARRACKS',(paramsArray select _u)];
	missionNamespace setVariable ['WFBE_BUILDINGMAXLIGHT',(paramsArray select _u)];
	missionNamespace setVariable ['WFBE_BUILDINGMAXCOMMANDCENTER',(paramsArray select _u)];
	missionNamespace setVariable ['WFBE_BUILDINGMAXHEAVY',(paramsArray select _u)];
	missionNamespace setVariable ['WFBE_BUILDINGMAXAIRCRAFT',(paramsArray select _u)];
	missionNamespace setVariable ['WFBE_BUILDINGMAXSERVICEPOINT',(paramsArray select _u)*2];_u = _u + 1;
	missionNamespace setVariable ['WFBE_HQDEPLOYPRICE',(paramsArray select _u)];_u = _u + 1;
	if ((paramsArray select _u) == 0) then {paramBasePatrols = false} else {paramBasePatrols = true};_u = _u + 1; //--- Base patrols.
	if ((paramsArray select _u) == 0) then {spawnSystemRestrict = false} else {spawnSystemRestrict = true};_u = _u + 1; //--- Restrict the Spawn logic to 2km within a town.
	missionNamespace setVariable ['WFBE_SIDESTARTINGDISTANCE',(paramsArray select _u)];_u = _u + 1;
	missionNamespace setVariable ['WFBE_STARTINGLOCATIONMODE',(paramsArray select _u)];_u = _u + 1;
	missionNamespace setVariable ['WFBE_INCOMESYSTEM',(paramsArray select _u)];_u = _u + 1;
	//--- Funds.
	missionNamespace setVariable ['WFBE_EASTSTARTINGMONEY',(paramsArray select _u)];_u = _u + 1;
	missionNamespace setVariable ['WFBE_WESTSTARTINGMONEY',(paramsArray select _u)];_u = _u + 1;
	//--- Supply.
	EastSupplies = (paramsArray select _u);_u = _u + 1;
	WestSupplies = (paramsArray select _u);_u = _u + 1;
	missionNamespace setVariable ['WFBE_SUPPLYSYSTEM',(paramsArray select _u)];_u = _u + 1;
	if ((paramsArray select _u) == 0) then {fastTime = false} else {fastTime = true};_u = _u + 1; //--- Fast time's enabled.
	if (time < 2) then {setDate [(date select 0),(date select 1),(date select 2),(paramsArray select _u),(date select 3)]};_u = _u + 1; //--- Time of Day.
	if ((paramsArray select _u) == 0) then {weather = false} else {weather = true};_u = _u + 1; //--- Weather's enabled.
	if ((paramsArray select _u) == 0) then {paramAlice = false} else {paramAlice = true};_u = _u + 1; //--- Ambient Civilians.
	if ((paramsArray select _u) == 0) then {hangars = false} else {hangars = true};_u = _u + 1; //--- Airport Hangars.
	missionNamespace setVariable ['WFBE_UNITREMOVEDLAY',(paramsArray select _u)];_u = _u + 1;
	missionNamespace setVariable ['WFBE_ABANDONVEHICLETIMER', paramsArray select _u];_u = _u + 1;
	if ((paramsArray select _u) == 0) then {fastTravel = false} else {fastTravel = true};_u = _u + 1; //--- Fast Travel.
	if ((paramsArray select _u) == 0) then {baseFrendlyFire = false} else {baseFrendlyFire = true};_u = _u + 1; //--- Base Friendly Fire.
	missionNamespace setVariable ['WFBE_MAXCLUTTERDISTANCE',(paramsArray select _u)];_u = _u + 1;
	if ((paramsArray select _u) == 0) then {kickTeamswappers = false} else {kickTeamswappers = true};_u = _u + 1; //--- Kick teamswappers.
	if ((paramsArray select _u) == 0) then {paramBoundaries = false} else {paramBoundaries = true};_u = _u + 1; //--- Prevent players from going outside of the map, they're killed after x seconds.
	if ((paramsArray select _u) == 0) then {showUID = false} else {showUID = true};_u = _u + 1; //--- Show User ID.
	if ((paramsArray select _u) == 0) then {spacebar = false} else {spacebar = true};_u = _u + 1; //--- Spacebar Scanning.
	if ((paramsArray select _u) == 0) then {trackAI = false} else {trackAI = true};_u = _u + 1; //--- Track AI (Yellow dots) on map.
	if ((paramsArray select _u) == 0) then {trackPlayer = false} else {trackPlayer = true};_u = _u + 1; //--- Track players.
	if ((paramsArray select _u) == 0) then {balancing = false} else {balancing = true};_u = _u + 1; //--- Balance the given units weapon loadout.
	if ((paramsArray select _u) == 0) then {paramUpgradesEast = false} else {paramUpgradesEast = true};_u = _u + 1; //--- Upgrades.
	if ((paramsArray select _u) == 0) then {paramUpgradesWest = false} else {paramUpgradesWest = true};_u = _u + 1; //--- Upgrades.
	missionNamespace setVariable ['WFBE_VICTORYCONDITION',(paramsArray select _u)];_u = _u + 1;
	missionNamespace setVariable ['WFBE_MAXVIEWDISTANCE',(paramsArray select _u)];_u = _u + 1;
	if (WF_A2_Vanilla) then {if ((paramsArray select _u) == 0) then {counterMeasures = false} else {counterMeasures = true};_u = _u + 1}; //--- Countermeasures.
	if ((paramsArray select _u) == 0) then {paramEASA = false} else {paramEASA = true};_u = _u + 1; //--- EASA.
	if ((paramsArray select _u) == 0) then {highcommand = false} else {highcommand = true};_u = _u + 1; //--- High Command.
	if ((paramsArray select _u) == 0) then {icbm = false} else {icbm = true};_u = _u + 1; //--- ICBM.
	if ((paramsArray select _u) == 0) then {ISIS = false} else {ISIS = true};_u = _u + 1; //--- Injury/Wound system.
	if ((paramsArray select _u) == 0) then {volumClouds = false} else {volumClouds = true};_u = _u + 1; //--- Volumetric Clouds.
	if ((paramsArray select _u) == 0) then {campRespawn = false} else {campRespawn = true};_u = _u + 1; //--- Camp respawn's enabled.
	if ((paramsArray select _u) == 0) then {campRespawnRule = false} else {campRespawnRule = true};_u = _u + 1; //--- Player cannot respawn if he dies to close of a camp.
	missionNamespace setVariable ['WFBE_RESPAWNDELAY',(paramsArray select _u)];_u = _u + 1;
	if ((paramsArray select _u) == 0) then {gearRespawn = false} else {gearRespawn = true};_u = _u + 1; //--- Player respawn with it's purchased gear.
	if ((paramsArray select _u) == 0) then {respawnMASH = false} else {respawnMASH = true};_u = _u + 1; //--- MASH respawn's enabled.
	if ((paramsArray select _u) == 0) then {mobileRespawn = false} else {mobileRespawn = true};_u = _u + 1; //--- Mobile respawn's enabled.
	missionNamespace setVariable ['WFBE_RESPAWNRANGE',(paramsArray select _u)];_u = _u + 1;
	if ((paramsArray select _u) == 0) then {advancedAir = false} else {advancedAir = true};_u = _u + 1; //--- Advanced Air (Attack).
	if ((paramsArray select _u) == 0) then {gearRestriction = false} else {gearRestriction = true};_u = _u + 1; //--- Player have a gear restriction in camps.
	if !(WF_A2_Arrowhead) then {if ((paramsArray select _u) == 0) then {kamov = false} else {kamov = true};_u = _u + 1}; //--- Kamov enabled.
	_u = _u + 1; //--- Town Amount System, leave blank.
	if ((paramsArray select _u) == 0) then {resStriker = false} else {resStriker = true};_u = _u + 1; //--- Resistance Assault Teams.
	missionNamespace setVariable ['WFBE_RESSTRIKERMAX',(paramsArray select _u)];_u = _u + 1;
	if ((paramsArray select _u) == 0) then {occup = false} else {occup = true};_u = _u + 1; //--- Town Occupation.
	missionNamespace setVariable ['WFBE_TOWNOCCUPATIONDIFFICULTY',(paramsArray select _u)];_u = _u + 1;
	if ((paramsArray select _u) == 0) then {occReinf = false} else {occReinf = true};_u = _u + 1; //--- Town Occupation Reinforcement.
	if ((paramsArray select _u) == 0) then {resPatrol = false} else {resPatrol = true};_u = _u + 1; //--- Resistance Patrols.
	missionNamespace setVariable ['WFBE_RESPATROLMAX',(paramsArray select _u)];_u = _u + 1;
	missionNamespace setVariable ['WFBE_TOWNBUILDPROTECTIONRANGE',(paramsArray select _u)];_u = _u + 1;
	if ((paramsArray select _u) == 0) then {buyInfDepot = false} else {buyInfDepot = true};_u = _u + 1; //--- Town Milita Purchase.
	if ((paramsArray select _u) == 0) then {res = false} else {res = true};_u = _u + 1; //--- Town Resistance.
	missionNamespace setVariable ['WFBE_TOWNRESISTANCEDIFFICULTY',(paramsArray select _u)];_u = _u + 1;
	if ((paramsArray select _u) == 0) then {resReinf = false} else {resReinf = true};_u = _u + 1; //--- Town Resistance Reinforcement.
	if (WF_A2_CombinedOps) then {missionNamespace setVariable ['WFBE_RESISTANCEFACTION',(paramsArray select _u)];_u = _u + 1};
	missionNamespace setVariable ['WFBE_TOWNSTARTINGMODE',(paramsArray select _u)];_u = _u + 1;
};

//--- All parameters are set and ready.
initJIP = true;

//--- Prevent Choppy Clouds.
if (fastTime) then {weather = false};

//--- Advanced squads
missionNamespace setVariable ['WFBE_EASTSLOTNAMES',[vehicleVarName EastSlot1,vehicleVarName EastSlot2,vehicleVarName EastSlot3,vehicleVarName EastSlot4,vehicleVarName EastSlot5,vehicleVarName EastSlot6,vehicleVarName EastSlot7,vehicleVarName EastSlot8,vehicleVarName EastSlot9,vehicleVarName EastSlot10,vehicleVarName EastSlot11,vehicleVarName EastSlot12,vehicleVarName EastSlot13,vehicleVarName EastSlot14,vehicleVarName EastSlot15,vehicleVarName EastSlot16]];
missionNamespace setVariable ['WFBE_WESTSLOTNAMES',[vehicleVarName WestSlot1,vehicleVarName WestSlot2,vehicleVarName WestSlot3,vehicleVarName WestSlot4,vehicleVarName WestSlot5,vehicleVarName WestSlot6,vehicleVarName WestSlot7,vehicleVarName WestSlot8,vehicleVarName WestSlot9,vehicleVarName WestSlot10,vehicleVarName WestSlot11,vehicleVarName WestSlot12,vehicleVarName WestSlot13,vehicleVarName WestSlot14,vehicleVarName WestSlot15,vehicleVarName WestSlot16]];

missionNamespace setVariable ['WFBE_EASTTEAMS',[Group EastSlot1,Group EastSlot2,Group EastSlot3,Group EastSlot4,Group EastSlot5,Group EastSlot6,Group EastSlot7,Group EastSlot8,Group EastSlot9,Group EastSlot10,Group EastSlot11,Group EastSlot12,Group EastSlot13,Group EastSlot14,Group EastSlot15,Group EastSlot16]];
missionNamespace setVariable ['WFBE_WESTTEAMS',[Group WestSlot1,Group WestSlot2,Group WestSlot3,Group WestSlot4,Group WestSlot5,Group WestSlot6,Group WestSlot7,Group WestSlot8,Group WestSlot9,Group WestSlot10,Group WestSlot11,Group WestSlot12,Group WestSlot13,Group WestSlot14,Group WestSlot15,Group WestSlot16]];

maxPlayers = count (missionNamespace getVariable 'WFBE_EASTTEAMS');

ExecVM "Common\Init\Init_Common.sqf";
ExecVM "Common\Init\Init_Towns.sqf";

if (local player) then {ExecVM "Client\Init\Init_Client.sqf"};
if (isServer) then {ExecVM "Server\Init\Init_Server.sqf"};