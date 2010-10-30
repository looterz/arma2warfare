//--- Global Init, first file called.

//--- Define which 'part' of the game to run.
#include "version.sqf"
#include "logging.sqf"

"Initialization begin" call LogMedium;

IsClientServer = if (!isMultiplayer || (isServer && local player)) then { true; } else { false };

//--- Client Init.
if (!isServer || local player) then {
	
	"Player initialization" call LogMedium;
	waitUntil {!isNull(player)};
	/* Client Init Done - Begin the blackout on Layer 1 */
	12452 cutText [(localize 'STR_WF_Loading')+"...","BLACK FADED",0];
	
	"Begin the blackout on Layer" call LogMedium;
};

setViewDistance 1500;

commonInitComplete = false;
serverInitComplete = false;
gameOver = false;
townInit = false;
towns = [];



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

WF_Camo = false;
#ifdef WF_CAMO
	WF_Camo = true;
#endif

//--- Gameplay variables.
paramCampRespawn = true;
paramMobileRespawn = true;
paramCampRespawnRule = true;
paramBalancing = false;
paramFastTime = false;
paramAI = true;
paramAIcom = true;
paramSpacebar = false;
paramTabLock = false;
paramTacView = false;
paramRestrictionKamov = false;
paramShowUID = true;
paramArty = true;
paramArtyUI = true;
paramTrackAI = true;
paramTrackPlayer = true;
paramRes = true;
paramOccup = true;
paramGearRespawn = true;
paramGearRestriction = false;
paramHangars = true;
paramAARadar = false;
paramFastTravel = false;
paramCounterMeasures = true;
paramAutoDefense = true;
paramVolumClouds = true;
paramICBM = true;
paramHighCommand = true;
paramBaseArea = true;
paramSpawnRestriction = true;
paramAllies = false;
paramUpgradesEast = true;
paramUpgradesWest = true;
paramISIS = false;
paramKickTeamswappers = true;
paramRespawnMASH = true;
paramResReinf = false;
paramOccReinf = false;
paramPurchaseInfDepot = true;
paramHandleFF = true;	// --- handle factory fire
paramBoundaries = true;
paramBasePatrols = false;
paramAlice = false;
paramEASA = true;
paramDLCBAF = true;
paramArtyComputer = true;
paramBounty = true;
paramResVehLock = false;

param3thView = false;

baseFrendlyFire = false;
paramEnabledHeadHunters = true;
paramBuildDefencesInTown = true;
paramSupplyExchange = true;
paramBuyVehiclesInTown = true;
paramBuyAircraftInAirportOnly = true;
paramStrictTankTargetLock = true;
paramVehicleComponents = true;
paramUnitCostWithGear = true;
paramTrade = true;

missionNamespace setVariable ['WFBE_EASTSTARTINGMONEY',200000];
missionNamespace setVariable ['WFBE_WESTSTARTINGMONEY',200000];
missionNamespace setVariable ['WFBE_SUPPLYSYSTEM', 1]; // time
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
	if ((paramsArray select _u) == 0) then {paramKeepAI = false} else {paramKeepAI = true};_u = _u + 1; //--- Keep AI Units over JIP.
	if ((paramsArray select _u) == 0) then {paramAI = false} else {paramAI = true};_u = _u + 1; //--- AI Enabled.
	if ((paramsArray select _u) == 0) then {paramArty = false} else {paramArty = true};_u = _u + 1; //--- Enable Artillery.
	if !(WF_A2_Vanilla) then {if ((paramsArray select _u) == 0) then {paramArtyComputer = false} else {paramArtyComputer = true};_u = _u + 1};
	if ((paramsArray select _u) == 0) then {paramArtyUI = false} else {paramArtyUI = true};_u = _u + 1; //--- Enable Artillery Interface (Artillery Module).
	missionNamespace setVariable ['WFBE_ARTILLERYMAXRANGE',(paramsArray select _u)];_u = _u + 1;
	if ((paramsArray select _u) == 0) then {paramAIcom = false} else {paramAIcom = true};_u = _u + 1; //--- AI Commander Enabled.
	if !(WF_A2_Arrowhead) then {if ((paramsArray select _u) == 0) then {paramAllies = false} else {paramAllies = true};_u = _u + 1}; //--- Allies.
	if ((paramsArray select _u) == 0) then {paramAARadar = false} else {paramAARadar = true};_u = _u + 1; //--- Anti Air Radar.
	if ((paramsArray select _u) == 0) then {paramBaseArea = false} else {paramBaseArea = true};_u = _u + 1; //--- Base Area.
	missionNamespace setVariable ['WFBE_BASEAREAMAX',(paramsArray select _u)];_u = _u + 1;
	if ((paramsArray select _u) == 0) then {paramAutoDefense = false} else {paramAutoDefense = true};_u = _u + 1; //--- Auto Defenses Manning.
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
	if ((paramsArray select _u) == 0) then {paramSpawnRestriction = false} else {paramSpawnRestriction = true};_u = _u + 1; //--- Restrict the Spawn logic to 2km within a town.
	missionNamespace setVariable ['WFBE_SIDESTARTINGDISTANCE',(paramsArray select _u)];_u = _u + 1;
	missionNamespace setVariable ['WFBE_STARTINGLOCATIONMODE',(paramsArray select _u)];_u = _u + 1;
	missionNamespace setVariable ['WFBE_INCOMEINTERVAL',(paramsArray select _u)];_u = _u + 1;
	missionNamespace setVariable ['WFBE_INCOMESYSTEM',(paramsArray select _u)];_u = _u + 1;
	//--- Funds.
	missionNamespace setVariable ['WFBE_EASTSTARTINGMONEY',(paramsArray select _u)];_u = _u + 1;
	missionNamespace setVariable ['WFBE_WESTSTARTINGMONEY',(paramsArray select _u)];_u = _u + 1;
	//--- Supply.
	EastSupplies = (paramsArray select _u);_u = _u + 1;
	WestSupplies = (paramsArray select _u);_u = _u + 1;
	missionNamespace setVariable ['WFBE_SUPPLYSYSTEM',(paramsArray select _u)];_u = _u + 1;
	if ((paramsArray select _u) == 0) then {paramFastTime = false} else {paramFastTime = true};_u = _u + 1; //--- Fast time's enabled.
	if (time < 2) then {setDate [(date select 0),(date select 1),(date select 2),(paramsArray select _u),(date select 3)]};_u = _u + 1; //--- Time of Day.
	missionNamespace setVariable ['WFBE_WEATHER',(paramsArray select _u)];_u = _u + 1;
	if !(WF_A2_Vanilla) then {if ((paramsArray select _u) == 0) then {paramDLCBAF = false} else {paramDLCBAF = true};_u = _u + 1};
	if ((paramsArray select _u) == 0) then {paramAlice = false} else {paramAlice = true};_u = _u + 1; //--- Ambient Civilians.
	if ((paramsArray select _u) == 0) then {paramHangars = false} else {paramHangars = true};_u = _u + 1; //--- Airport Hangars.
	missionNamespace setVariable ['WFBE_UNITREMOVEDLAY',(paramsArray select _u)];_u = _u + 1;
	missionNamespace setVariable ['WFBE_ABANDONVEHICLETIMER', paramsArray select _u];_u = _u + 1;
	if ((paramsArray select _u) == 0) then {paramFastTravel = false} else {paramFastTravel = true};_u = _u + 1; //--- Fast Travel.
	if ((paramsArray select _u) == 0) then {baseFrendlyFire = false} else {baseFrendlyFire = true};_u = _u + 1; //--- Base Friendly Fire.
	missionNamespace setVariable ['WFBE_MAXCLUTTERDISTANCE',(paramsArray select _u)];_u = _u + 1;
	if ((paramsArray select _u) == 0) then {paramKickTeamswappers = false} else {paramKickTeamswappers = true};_u = _u + 1; //--- Kick teamswappers.
	if ((paramsArray select _u) == 0) then {paramBoundaries = false} else {paramBoundaries = true};_u = _u + 1; //--- Prevent players from going outside of the map, they're killed after x seconds.
	if ((paramsArray select _u) == 0) then {paramShowUID = false} else {paramShowUID = true};_u = _u + 1; //--- Show User ID.
	if ((paramsArray select _u) == 0) then {paramTrackAI = false} else {paramTrackAI = true};_u = _u + 1; //--- Track AI (Yellow dots) on map.
	if ((paramsArray select _u) == 0) then {paramTrackPlayer = false} else {paramTrackPlayer = true};_u = _u + 1; //--- Track players.
	if ((paramsArray select _u) == 0) then {paramBalancing = false} else {paramBalancing = true};_u = _u + 1; //--- Balance the given units weapon loadout.
	if ((paramsArray select _u) == 0) then {paramBounty = false} else {paramBounty = true};_u = _u + 1;
	if ((paramsArray select _u) == 0) then {paramUpgradesEast = false} else {paramUpgradesEast = true};_u = _u + 1; //--- Upgrades.
	if ((paramsArray select _u) == 0) then {paramUpgradesWest = false} else {paramUpgradesWest = true};_u = _u + 1; //--- Upgrades.
	missionNamespace setVariable ['WFBE_VICTORYCONDITION',(paramsArray select _u)];_u = _u + 1;
	missionNamespace setVariable ['WFBE_MAXVIEWDISTANCE',(paramsArray select _u)];_u = _u + 1;
	if ((paramsArray select _u) == 0) then {paramTabLock = false} else {paramTabLock = true};_u = _u + 1; //--- Lock Targets
	if ((paramsArray select _u) == 0) then {paramSpacebar = false} else {paramSpacebar = true};_u = _u + 1; //--- Spacebar Scanning.
	if ((paramsArray select _u) == 0) then {paramTacView = false} else {paramTacView = true};_u = _u + 1; //--- Tactical View.
	if (WF_A2_Vanilla) then {if ((paramsArray select _u) == 0) then {paramCounterMeasures = false} else {paramCounterMeasures = true};_u = _u + 1}; //--- Countermeasures.
	if ((paramsArray select _u) == 0) then {paramEASA = false} else {paramEASA = true};_u = _u + 1; //--- EASA.
	if ((paramsArray select _u) == 0) then {paramHighCommand = false} else {paramHighCommand = true};_u = _u + 1; //--- High Command.
	if ((paramsArray select _u) == 0) then {paramICBM = false} else {paramICBM = true};_u = _u + 1; //--- ICBM.
	if ((paramsArray select _u) == 0) then {paramISIS = false} else {paramISIS = true};_u = _u + 1; //--- Injury/Wound system.
	if ((paramsArray select _u) == 0) then {paramVolumClouds = false} else {paramVolumClouds = true};_u = _u + 1; //--- Volumetric Clouds.
	if ((paramsArray select _u) == 0) then {paramCampRespawn = false} else {paramCampRespawn = true};_u = _u + 1; //--- Camp respawn's enabled.
	if ((paramsArray select _u) == 0) then {paramCampRespawnRule = false} else {paramCampRespawnRule = true};_u = _u + 1; //--- Player cannot respawn if he dies to close of a camp.
	missionNamespace setVariable ['WFBE_RESPAWNDELAY',(paramsArray select _u)];_u = _u + 1;
	if ((paramsArray select _u) == 0) then {paramRespawnMASH = false} else {paramRespawnMASH = true};_u = _u + 1; //--- MASH respawn's enabled.
	if ((paramsArray select _u) == 0) then {paramMobileRespawn = false} else {paramMobileRespawn = true};_u = _u + 1; //--- Mobile respawn's enabled.
	missionNamespace setVariable ['WFBE_RESPAWNPENALTY',(paramsArray select _u)];_u = _u + 1;
	missionNamespace setVariable ['WFBE_RESPAWNRANGE',(paramsArray select _u)];_u = _u + 1;
	missionNamespace setVariable ['WFBE_RESTRICTIONADVAIR',(paramsArray select _u)];_u = _u + 1;
	if ((paramsArray select _u) == 0) then {paramGearRestriction = false} else {paramGearRestriction = true};_u = _u + 1; //--- Player have a gear restriction in camps.
	if !(WF_A2_Arrowhead) then {if ((paramsArray select _u) == 0) then {paramRestrictionKamov = false} else {paramRestrictionKamov = true};_u = _u + 1}; //--- Kamov enabled.
	_u = _u + 1; //--- Town Amount System, leave blank.
	missionNamespace setVariable ['WFBE_RESSTRIKER',(paramsArray select _u)];_u = _u + 1;
	if ((paramsArray select _u) == 0) then {paramOccup = false} else {paramOccup = true};_u = _u + 1; //--- Town Occupation.
	missionNamespace setVariable ['WFBE_TOWNOCCUPATIONDIFFICULTY',(paramsArray select _u)];_u = _u + 1;
	if ((paramsArray select _u) == 0) then {paramOccReinf = false} else {paramOccReinf = true};_u = _u + 1; //--- Town Occupation Reinforcement.
	missionNamespace setVariable ['WFBE_RESPATROL',(paramsArray select _u)];_u = _u + 1;
	missionNamespace setVariable ['WFBE_TOWNBUILDPROTECTIONRANGE',(paramsArray select _u)];_u = _u + 1;
	if ((paramsArray select _u) == 0) then {paramPurchaseInfDepot = false} else {paramPurchaseInfDepot = true};_u = _u + 1; //--- Town Milita Purchase.
	if ((paramsArray select _u) == 0) then {paramRes = false} else {paramRes = true};_u = _u + 1; //--- Town Resistance.
	missionNamespace setVariable ['WFBE_TOWNRESISTANCEDIFFICULTY',(paramsArray select _u)];_u = _u + 1;
	if ((paramsArray select _u) == 0) then {paramResReinf = false} else {paramResReinf = true};_u = _u + 1; //--- Town Resistance Reinforcement.
	if ((paramsArray select _u) == 0) then {paramResVehLock = false} else {paramResVehLock = true};_u = _u + 1; //--- Town Resistance Vehicles Lock.
	if (WF_A2_CombinedOps) then {missionNamespace setVariable ['WFBE_RESISTANCEFACTION',(paramsArray select _u)];_u = _u + 1};
	missionNamespace setVariable ['WFBE_TOWNSTARTINGMODE',(paramsArray select _u)];_u = _u + 1;
	
	if ((paramsArray select _u) == 0) then {paramEnabledHeadHunters = false} else {paramEnabledHeadHunters = true};_u = _u + 1; //--- Head Hunters - money loss for die from enemy player / money give for kill enemy player
	if ((paramsArray select _u) == 0) then {paramBuildDefencesInTown = false} else {paramBuildDefencesInTown = true};_u = _u + 1; //--- Build Defences in Town for everybody
	if ((paramsArray select _u) == 0) then {paramSupplyExchange = false} else {paramSupplyExchange = true};_u = _u + 1; //--- Supply Exchange in town depot
	if ((paramsArray select _u) == 0) then {paramBuyVehiclesInTown = false} else {paramBuyVehiclesInTown = true};_u = _u + 1; //--- Supply Exchange in town depot
	if ((paramsArray select _u) == 0) then {paramBuyAircraftInAirportOnly = false} else {paramBuyAircraftInAirportOnly = true};_u = _u + 1; //--- Buy aircrafts only in airport
	if ((paramsArray select _u) == 0) then {paramVehicleComponents = false} else {paramVehicleComponents = true};_u = _u + 1; //--- Vehicle component requirements
	if ((paramsArray select _u) == 0) then {paramUnitCostWithGear = false} else {paramUnitCostWithGear = true};_u = _u + 1; //---  Unit Cost with Gear
	if ((paramsArray select _u) == 0) then {paramTrade = false} else {paramTrade = true};_u = _u + 1; //---  Unit Cost with Gear

	if ((paramsArray select _u) == 0) then {param3thView = false} else {param3thView = true}; _u = _u + 1;
};

//--- Debug.
if (WF_Debug) then {
	paramUpgradesEast = false;
	paramUpgradesWest = false;
	paramRes = false;
	paramOccup = false;
};

//--- All parameters are set and ready.
initJIP = true;

//--- Prevent Choppy Clouds.
if (fastTime) then {weather = false};

//--- Advanced squads
missionNamespace setVariable ['WFBE_EASTSLOTNAMES',[vehicleVarName EastSlot1,vehicleVarName EastSlot2,vehicleVarName EastSlot3,vehicleVarName EastSlot4,vehicleVarName EastSlot5,vehicleVarName EastSlot6,vehicleVarName EastSlot7,vehicleVarName EastSlot8,vehicleVarName EastSlot9,vehicleVarName EastSlot10,vehicleVarName EastSlot11,vehicleVarName EastSlot12,vehicleVarName EastSlot13,vehicleVarName EastSlot14,vehicleVarName EastSlot15,vehicleVarName EastSlot16,vehicleVarName EastSlot17,vehicleVarName EastSlot18,vehicleVarName EastSlot19,vehicleVarName EastSlot20]];
missionNamespace setVariable ['WFBE_WESTSLOTNAMES',[vehicleVarName WestSlot1,vehicleVarName WestSlot2,vehicleVarName WestSlot3,vehicleVarName WestSlot4,vehicleVarName WestSlot5,vehicleVarName WestSlot6,vehicleVarName WestSlot7,vehicleVarName WestSlot8,vehicleVarName WestSlot9,vehicleVarName WestSlot10,vehicleVarName WestSlot11,vehicleVarName WestSlot12,vehicleVarName WestSlot13,vehicleVarName WestSlot14,vehicleVarName WestSlot15,vehicleVarName WestSlot16,vehicleVarName WestSlot17,vehicleVarName WestSlot18,vehicleVarName WestSlot19,vehicleVarName WestSlot20]];

missionNamespace setVariable ['WFBE_EASTTEAMS',[Group EastSlot1,Group EastSlot2,Group EastSlot3,Group EastSlot4,Group EastSlot5,Group EastSlot6,Group EastSlot7,Group EastSlot8,Group EastSlot9,Group EastSlot10,Group EastSlot11,Group EastSlot12,Group EastSlot13,Group EastSlot14,Group EastSlot15,Group EastSlot16,Group EastSlot17,Group EastSlot18,Group EastSlot19,Group EastSlot20]];
missionNamespace setVariable ['WFBE_WESTTEAMS',[Group WestSlot1,Group WestSlot2,Group WestSlot3,Group WestSlot4,Group WestSlot5,Group WestSlot6,Group WestSlot7,Group WestSlot8,Group WestSlot9,Group WestSlot10,Group WestSlot11,Group WestSlot12,Group WestSlot13,Group WestSlot14,Group WestSlot15,Group WestSlot16,Group WestSlot17,Group WestSlot18,Group WestSlot19,Group WestSlot20]];

maxPlayers = count (missionNamespace getVariable 'WFBE_EASTTEAMS');

ExecVM "Common\Init\Init_Common.sqf";
ExecVM "Common\Init\Init_Towns.sqf";

if (local player) then {ExecVM "Client\Init\Init_Client.sqf"; [] execVM "limitThirdPersonView.sqf"; };
if (isServer) then {ExecVM "Server\Init\Init_Server.sqf"};

execVM "Module\Market\Init_Market.sqf";