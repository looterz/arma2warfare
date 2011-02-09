private['_count'];

waitUntil { !isNil "initJIP" };
CompileFile = Compile preprocessFile "Common\Functions\Common_CompileFile.sqf";
 
Format["Init_Common: Init Start at %1",time] call LogMedium;

if (paramBalancing) then {
	if ( (WF_A2_Arrowhead || WF_A2_CombinedOps) ) then { 
		BalanceInit = compile preprocessFile "Common\Functions\Common_BalanceInit.sqf";
	} else {
		BalanceInit = compile preprocessFile "Common\Functions\Common_BalanceInitA2.sqf";
	};	
};
if !(WF_A2_Vanilla) then {
	BackpackHasSpace = Compile preprocessFile "Common\Functions\Common_BackpackHasSpace.sqf";
	EquipBackpack = Compile preprocessFile "Common\Functions\Common_EquipBackpack.sqf";
};

GetTeamVote = compile preprocessFile "Common\Functions\Common_GetTeamVote.sqf";
SetTeamVote = compile preprocessFile "Common\Functions\Common_SetTeamVote.sqf";

GetUnitEquipmentPrice = Compile preprocessFile "Common\Functions\Common_GetUnitEquipmentPrice.sqf";
BuildingInRange = Compile preprocessFile "Common\Functions\Common_BuildingInRange.sqf";
ChangeTeamFunds = Compile preprocessFile "Common\Functions\Common_ChangeTeamFunds.sqf";
ChangeClientFunds = Compile preprocessFile "Common\Functions\Common_ChangeClientFunds.sqf";
CreateMan = Compile preprocessFile "Common\Functions\Common_CreateUnit.sqf";
CreateVehi = Compile preprocessFile "Common\Functions\Common_CreateVehicle.sqf";
EquipArtillery = Compile preprocessFile "Common\Functions\Common_EquipArtillery.sqf";
EquipLoadout = Compile preprocessFile "Common\Functions\Common_EquipLoadout.sqf";
GetEquipLoadout = Compile preprocessFile "Common\Functions\Common_GetEquipLoadout.sqf";
GetEquipDogTags = Compile preprocessFile "Common\Functions\Common_GetEquipDogTags.sqf";

GetIsFlatPosition = Compile preprocessFile "Common\Functions\Common_GetIsFlatPosition.sqf";
GetGridPosition = Compile preprocessFile "Common\Functions\Common_GetGridPosition.sqf";

FireArtillery = Compile preprocessFile "Common\Functions\Common_FireArtillery.sqf";
FireArtilleryTraceTraectory = Compile preprocessFile "Common\Functions\Common_FireArtilleryTraceTraectory.sqf";

GetTeamVariable = Compile preprocessFile "Common\Functions\Common_GetTeamVariable.sqf";
SetTeamVariable = Compile preprocessFile "Common\Functions\Common_SetTeamVariable.sqf";

GetClientID = Compile preprocessFile "Common\Functions\Common_GetClientID.sqf";
GetClientIDFromTeam = Compile preprocessFile "Common\Functions\Common_GetClientIDFromTeam.sqf";
GetClientTeam = Compile preprocessFile "Common\Functions\Common_GetClientTeam.sqf";

GetClientFunds = Compile preprocessFile "Common\Functions\Common_GetClientFunds.sqf";
SetClientFunds = Compile preprocessFile "Common\Functions\Common_SetClientFunds.sqf";


GetClosestLocation = Compile preprocessFile "Common\Functions\Common_GetClosestLocation.sqf";
GetClosestLocationBySide = Compile preprocessFile "Common\Functions\Common_GetClosestLocationBySide.sqf";
GetCommanderFromVotes = Compile preprocessFile "Common\Functions\Common_GetCommanderFromVotes.sqf";
GetCommanderTeam = Compile preprocessFile "Common\Functions\Common_GetCommanderTeam.sqf";
GetCommanderVotes = Compile preprocessFile "Common\Functions\Common_GetCommanderVotes.sqf";
GetConfigInfo = Compile preprocessFile "Common\Functions\Common_GetConfigInfo.sqf";
GetFactories = Compile preprocessFile "Common\Functions\Common_GetFactories.sqf";
GetFriendlyCamps = Compile preprocessFile "Common\Functions\Common_GetFriendlyCamps.sqf";
GetHostilesInArea = Compile preprocessFile "Common\Functions\Common_GetHostilesInArea.sqf";
GetLiveUnits = Compile preprocessFile "Common\Functions\Common_GetLiveUnits.sqf";
GetNamespace = Compile preprocessFile "Common\Functions\Common_GetNamespace.sqf";
GetPositionFrom = Compile preprocessFile "Common\Functions\Common_GetPositionFrom.sqf";
GetGridTarget  = Compile preprocessFile "Common\Functions\Common_GetGridTarget.sqf";
GetRandomPositionEx = Compile preprocessFile "Common\Functions\Common_GetRandomPositionEx.sqf";
GetSideFromID = Compile preprocessFile "Common\Functions\Common_GetSideFromID.sqf";
GetRandomPosition = Compile preprocessFile "Common\Functions\Common_GetRandomPosition.sqf";
GetRespawnCamps = Compile preprocessFile "Common\Functions\Common_GetRespawnCamps.sqf";
GetSafePlace = Compile preprocessFile "Common\Functions\Common_GetSafePlace.sqf";
GetSideFromID = Compile preprocessFile "Common\Functions\Common_GetSideFromID.sqf";
GetSideHQ = Compile preprocessFile "Common\Functions\Common_GetSideHQ.sqf";
GetSideHQDeployed = Compile preprocessFile "Common\Functions\Common_GetSideHQDeployed.sqf";
GetSideID = Compile preprocessFile "Common\Functions\Common_GetSideID.sqf";
GetSideStructures = Compile preprocessFile "Common\Functions\Common_GetSideStructures.sqf";

GetSideUpgrades = Compile preprocessFile "Common\Functions\Common_GetSideUpgrades.sqf";
SetSideUpgrades = Compile preprocessFile "Common\Functions\Common_SetSideUpgrades.sqf";

GetTeamArtillery = Compile preprocessFile "Common\Functions\Common_GetTeamArtillery.sqf";
GetTeamAutonomous = Compile preprocessFile "Common\Functions\Common_GetTeamAutonomous.sqf";
GetTeamFunds = Compile preprocessFile "Common\Functions\Common_GetTeamFunds.sqf";
GetTeamMoveMode = Compile preprocessFile "Common\Functions\Common_GetTeamMoveMode.sqf";
GetTeamMovePos = Compile preprocessFile "Common\Functions\Common_GetTeamMovePos.sqf";
GetTeamRespawn = Compile preprocessFile "Common\Functions\Common_GetTeamRespawn.sqf";
GetTeamType = Compile preprocessFile "Common\Functions\Common_GetTeamType.sqf";
GetTeamVehicles = Compile preprocessFile "Common\Functions\Common_GetTeamVehicles.sqf";
GetTotalCamps = Compile preprocessFile "Common\Functions\Common_GetTotalCamps.sqf";
GetTotalCampsOnSide = Compile preprocessFile "Common\Functions\Common_GetTotalCampsOnSide.sqf";
GetTotalSupplyValue = Compile preprocessFile "Common\Functions\Common_GetTotalSupplyValue.sqf";
GetTownsHeld = Compile preprocessFile "Common\Functions\Common_GetTownsHeld.sqf";
GetUnitsBelowHeight = Compile preprocessFile "Common\Functions\Common_GetUnitsBelowHeight.sqf";
GetUnitVehicle = Compile preprocessFile "Common\Functions\Common_GetUnitVehicle.sqf";
HandleArtillery = Compile preprocessFile "Common\Functions\Common_HandleArtillery.sqf";
IsArtillery = Compile preprocessFile "Common\Functions\Common_IsArtillery.sqf";
if (paramISIS) then {
	ISIS_Heal = Compile preprocessFile "Client\Module\ISIS\ISIS_Heal.sqf";
	ISIS_Wound = Compile preprocessFile "Client\Module\ISIS\ISIS_Wound.sqf";
	ISIS_Wounded = Compile preprocessFile "Client\Module\ISIS\ISIS_Wounded.sqf";
};
MarkerUpdate = Compile preprocessFile "Common\Common_MarkerUpdate.sqf";
PlaceNear = Compile preprocessFile "Common\Functions\Common_PlaceNear.sqf";
PlaceSafe = Compile preprocessFile "Common\Functions\Common_PlaceSafe.sqf";
if !(WF_A2_Vanilla) then {
	GetTurretsMags = Compile preprocessFile "Common\Functions\Common_GetTurretsMags.sqf";
	GetVehicleMags = Compile preprocessFile "Common\Functions\Common_GetVehicleMags.sqf";
	RearmVehicle = Compile preprocessFile "Common\Functions\Common_RearmVehicleOA.sqf";
	SetTurretsMags = Compile preprocessFile "Common\Functions\Common_SetTurretsMags.sqf";
} else {
	RearmVehicle = Compile preprocessFile "Common\Functions\Common_RearmVehicle.sqf";
};
SetCommanderVotes = Compile preprocessFile "Common\Functions\Common_SetCommanderVotes.sqf";
SetNamespace = Compile preprocessFile "Common\Functions\Common_SetNamespace.sqf";
SetTeamAutonomous = Compile preprocessFile "Common\Functions\Common_SetTeamAutonomous.sqf";
SetTeamRespawn = Compile preprocessFile "Common\Functions\Common_SetTeamRespawn.sqf";
SetTeamMoveMode = Compile preprocessFile "Common\Functions\Common_SetTeamMoveMode.sqf";
SetTeamMovePos = Compile preprocessFile "Common\Functions\Common_SetTeamMovePos.sqf";
SetTeamType = Compile preprocessFile "Common\Functions\Common_SetTeamType.sqf";
SpawnTurrets = Compile preprocessFile "Common\Functions\Common_SpawnTurrets.sqf";

QuickSort = Compile preprocessFile "Common\Functions\Common_QuickSort.sqf";
QuickSortSwap = Compile preprocessFile "Common\Functions\Common_QuickSortSwap.sqf";
QuickSortIterator = Compile preprocessFile "Common\Functions\Common_QuickSortIterator.sqf";
QuickSortInsertion = Compile preprocessFile "Common\Functions\Common_QuickSortInsertion.sqf";

SortByDistance = Compile preprocessFile "Common\Functions\Common_SortByDistance.sqf";
UnitKilled = Compile preprocessFile "Common\Functions\Common_UnitKilled.sqf";
//UpdateStatistics = Compile preprocessFile "Common\Functions\Common_UpdateStatistics.sqf";
UpdateSideStats = Compile preprocessFile "Common\Functions\Common_UpdateSideStats.sqf";

HeadHunters = Compile preprocessFile "Common\Functions\Common_HeadHunters.sqf";

GetTownCaptureAward = Compile preprocessFile "Common\Functions\Common_GetTownCaptureAward.sqf";
SelectCamo = Compile preprocessFile "Common\Functions\Common_SelectCamo.sqf";

UseStationaryDefense = Compile preprocessFile "Common\Functions\Common_UseStationaryDefense.sqf";
if (paramICBM) then {
	NukeDammage = Compile preprocessFile "Client\Module\Nuke\damage.sqf";
	NukeRadiation = Compile preprocessFile "Client\Module\Nuke\radzone.sqf";
};

call compile preprocessFile "Common\Functions\Common_SetKilledEventHandler.sqf";

"Init_Common: Functions - [Done]" call LogMedium;

executed = 0;
varQueu = random(10)+random(100)+random(1000);

EastCommanderTeam = ObjNull;
WestCommanderTeam = ObjNull;

/* Starting Supply */
if (isNil "EastSupplies") then {EastSupplies = if (WF_Debug) then {1000000} else {1200}};
if (isNil "WestSupplies") then {WestSupplies = if (WF_Debug) then {1000000} else {1200}};

Format["Init_Common: Starting Supply (West: %1 East: %2) - [Done]",WestSupplies,EastSupplies] call LogMedium;

/* Starting Money */
['WFBE_EASTSTARTINGMONEY',if (WF_Debug) then {900000} else {800},false] Call SetNamespace;
['WFBE_WESTSTARTINGMONEY',if (WF_Debug) then {900000} else {800},false] Call SetNamespace;

Format["Init_Common: Starting Funds (West: %1 East: %2) - [Done]",'WFBE_WESTSTARTINGMONEY' Call GetNamespace,'WFBE_EASTSTARTINGMONEY' Call GetNamespace] call LogMedium;

/* Allies */
if (('WFBE_ALLIES' Call GetNamespace) > 0) then {
	westAlliesFunds = ('WFBE_WESTSTARTINGMONEY' Call GetNamespace)*5;
	eastAlliesFunds = ('WFBE_EASTSTARTINGMONEY' Call GetNamespace)*5;
	
	Format["Init_Common: Allies Starting Funds (West: %1 East: %2) - [Done]",('WFBE_WESTSTARTINGMONEY' Call GetNamespace)*5,('WFBE_EASTSTARTINGMONEY' Call GetNamespace)*5] call LogMedium;
};

unitMarker = 0;

for [{_count = 0},{_count < maxPlayers},{_count = _count + 1}] do {
	Call Compile Format["if (IsNil 'EastTeam%1Vote') then {EastTeam%1Vote = -1}",_count + 1];
	Call Compile Format["if (IsNil 'WestTeam%1Vote') then {WestTeam%1Vote = -1}",_count + 1];
};

/* Prepare the constants */
[] Call Compile preprocessFile "Common\Init\Init_CommonConstants.sqf";

/* CORE SYSTEM - Start
	Different Core are added depending on the current ArmA Version running, add yours bellow.
	The faction is the same as the filename, like US = Units_Barracks_US.sqf (Units_Barracks_ + US + .sqf).
*/
WFBE_V_UnitsRoot = 'Common\Config\Core_Units\';
if (WF_A2_Vanilla) then {
	/* Gear Core */
	[] Call Compile preprocessFile 'Common\Config\Core_Gear\Core_Vanilla_G.sqf';
	/* Class Core */
	[] Call Compile preprocessFile 'Common\Config\Core\Core_CDF.sqf';
	[] Call Compile preprocessFile 'Common\Config\Core\Core_CIV.sqf';
	[] Call Compile preprocessFile 'Common\Config\Core\Core_FR.sqf';
	[] Call Compile preprocessFile 'Common\Config\Core\Core_GUE.sqf';
	[] Call Compile preprocessFile 'Common\Config\Core\Core_INS.sqf';
	[] Call Compile preprocessFile 'Common\Config\Core\Core_MVD.sqf';
	[] Call Compile preprocessFile 'Common\Config\Core\Core_RU.sqf';
	[] Call Compile preprocessFile 'Common\Config\Core\Core_Spetsnaz.sqf';
	[] Call Compile preprocessFile 'Common\Config\Core\Core_USMC.sqf';
	/* Units Core */
	WFBE_V_West_UnitsRootVersion = 'Vanilla\';
	WFBE_V_West_Faction = 'USMC';
	WFBE_V_East_UnitsRootVersion = 'Vanilla\';
	WFBE_V_East_Faction = 'RU';
	WFBE_V_Resistance_UnitsRootVersion = 'Vanilla\';
	WFBE_V_Resistance_Faction = 'GUE';
	/* Squads Core */
	WFBE_V_West_SquadsRootVersion = 'Vanilla';
	WFBE_V_West_SquadsFaction = 'USMC';
	WFBE_V_East_SquadsRootVersion = 'Vanilla';
	WFBE_V_East_SquadsFaction = 'RU';
};
if (WF_A2_Arrowhead) then {
	/* Gear Core */
	[] Call Compile preprocessFile 'Common\Config\Core_Gear\Core_Arrowhead_G.sqf';
	[] Call Compile preprocessFile 'Common\Config\Core_Gear\Core_BAF_G.sqf';
	[] Call Compile preprocessFile 'Common\Config\Core_Gear\Core_PMC_G.sqf';
	/* Class Core */
	[] Call Compile preprocessFile 'Common\Config\Core\Core_ACR.sqf';
	[] Call Compile preprocessFile 'Common\Config\Core\Core_BAF.sqf';
	[] Call Compile preprocessFile 'Common\Config\Core\Core_BAFD.sqf';
	[] Call Compile preprocessFile 'Common\Config\Core\Core_BAFW.sqf';
	[] Call Compile preprocessFile 'Common\Config\Core\Core_DeltaForce.sqf';
	[] Call Compile preprocessFile 'Common\Config\Core\Core_KSK.sqf';
	[] Call Compile preprocessFile 'Common\Config\Core\Core_PMC.sqf';
	[] Call Compile preprocessFile 'Common\Config\Core\Core_TK.sqf';
	[] Call Compile preprocessFile 'Common\Config\Core\Core_TKCIV.sqf';
	[] Call Compile preprocessFile 'Common\Config\Core\Core_TKGUE.sqf';
	[] Call Compile preprocessFile 'Common\Config\Core\Core_TKSF.sqf';
	[] Call Compile preprocessFile 'Common\Config\Core\Core_US.sqf';
	/* Units Core */
	WFBE_V_West_UnitsRootVersion = 'Arrowhead\';
	WFBE_V_West_Faction = 'US';
	WFBE_V_East_UnitsRootVersion = 'Arrowhead\';
	WFBE_V_East_Faction = 'TK';
	WFBE_V_Resistance_UnitsRootVersion = 'Arrowhead\';
	WFBE_V_Resistance_Faction = 'TKGUE';
	/* Squads Core */
	WFBE_V_West_SquadsRootVersion = 'Arrowhead';
	WFBE_V_West_SquadsFaction = 'US';
	WFBE_V_East_SquadsRootVersion = 'Arrowhead';
	WFBE_V_East_SquadsFaction = 'TK';
};
if (WF_A2_CombinedOps) then {
	/* Gear Core */
	[] Call Compile preprocessFile 'Common\Config\Core_Gear\Core_Vanilla_G.sqf';
	[] Call Compile preprocessFile 'Common\Config\Core_Gear\Core_Arrowhead_G.sqf';
	[] Call Compile preprocessFile 'Common\Config\Core_Gear\Core_BAF_G.sqf';
	[] Call Compile preprocessFile 'Common\Config\Core_Gear\Core_PMC_G.sqf';
	/* Class Core */
	[] Call Compile preprocessFile 'Common\Config\Core\Core_ACR.sqf';
	[] Call Compile preprocessFile 'Common\Config\Core\Core_BAF.sqf';
	[] Call Compile preprocessFile 'Common\Config\Core\Core_BAFD.sqf';
	[] Call Compile preprocessFile 'Common\Config\Core\Core_BAFW.sqf';
	[] Call Compile preprocessFile 'Common\Config\Core\Core_CDF.sqf';
	[] Call Compile preprocessFile 'Common\Config\Core\Core_CIV.sqf';
	[] Call Compile preprocessFile 'Common\Config\Core\Core_DeltaForce.sqf';
	[] Call Compile preprocessFile 'Common\Config\Core\Core_FR.sqf';
	[] Call Compile preprocessFile 'Common\Config\Core\Core_GUE.sqf';
	[] Call Compile preprocessFile 'Common\Config\Core\Core_INS.sqf';
	[] Call Compile preprocessFile 'Common\Config\Core\Core_KSK.sqf';
	[] Call Compile preprocessFile 'Common\Config\Core\Core_MVD.sqf';
	[] Call Compile preprocessFile 'Common\Config\Core\Core_PMC.sqf';
	[] Call Compile preprocessFile 'Common\Config\Core\Core_RU.sqf';
	[] Call Compile preprocessFile 'Common\Config\Core\Core_Spetsnaz.sqf';
	[] Call Compile preprocessFile 'Common\Config\Core\Core_TK.sqf';
	[] Call Compile preprocessFile 'Common\Config\Core\Core_TKCIV.sqf';
	[] Call Compile preprocessFile 'Common\Config\Core\Core_TKGUE.sqf';
	[] Call Compile preprocessFile 'Common\Config\Core\Core_TKSF.sqf';
	[] Call Compile preprocessFile 'Common\Config\Core\Core_US.sqf';
	[] Call Compile preprocessFile 'Common\Config\Core\Core_USMC.sqf';
        /* Units Core */
	WFBE_V_West_UnitsRootVersion = 'CombinedOps\';
	WFBE_V_West_Faction = 'US';
	WFBE_V_East_UnitsRootVersion = 'CombinedOps\';
	WFBE_V_East_Faction = 'RU';
	WFBE_V_Resistance_UnitsRootVersion = 'CombinedOps\';
	WFBE_V_Resistance_Faction = 'GUE';
	/* Squads Core */
	if (WF_Camo) then {
		WFBE_V_West_SquadsRootVersion = 'CombinedOps';
		WFBE_V_West_SquadsFaction = 'US_Camo';
	} else {
		WFBE_V_West_SquadsRootVersion = 'Arrowhead';
		WFBE_V_West_SquadsFaction = 'US';
	};
	WFBE_V_East_SquadsRootVersion = 'Vanilla';
	WFBE_V_East_SquadsFaction = 'RU';
};
/* CORE SYSTEM - End */

"Init_Common: Core Loading - [Done]" call LogMedium;

//--- Common Exec.
[] Call Compile preprocessFile "Common\Init\Init_PublicVariables.sqf";
[] Call Compile preprocessFile "Common\Config\Config_Artillery.sqf";
[] Call Compile preprocessFile "Common\Config\Config_Barracks.sqf";
[] Call Compile preprocessFile "Common\Config\Config_LightFactory.sqf";
[] Call Compile preprocessFile "Common\Config\Config_HeavyFactory.sqf";
[] Call Compile preprocessFile "Common\Config\Config_AircraftFactory.sqf";
[] Call Compile preprocessFile "Common\Config\Config_Airport.sqf";
[] Call Compile preprocessFile "Common\Config\Config_Depot.sqf";
[] Call Compile preprocessFile "Common\Config\Config_Structures.sqf";
[] Call Compile preprocessFile "Common\Config\Config_Squads.sqf";
[] Call Compile preprocessFile "Common\Config\Config_Loadouts.sqf";

//--- Server Exec.
if (isServer) then {
	[] Call Compile preprocessFile "Common\Config\Config_Resistance.sqf";
	[] Call Compile preprocessFile "Common\Config\Config_Occupation.sqf";
};
"Init_Common: Config Loading - [Done]" call LogMedium;

//--- Boundaries, use setPos to find the perfect spot on other islands and worldName to determine the island name (editor: diag_log worldName; player setPos [0,5120,0]; ).
if (paramBoundaries) then {
	[] Call Compile preprocessFile "Common\Init\Init_Boundaries.sqf";
	"Init_Common: Boundaries Loading - [Done]" call LogMedium;;
};

//--- Disable Artillery Computer.
if (!paramArtyComputer && !WF_A2_Vanilla) then {[] Call Compile preprocessFile 'Common\Common_DisableAC.sqf'};

if (local player) then {
	initUnitEquipmentPrice = false;
	[] Call Compile preprocessFile "Common\Init\Init_UnitEquipmentPrice.sqf";
};

"Init_Common: Init End" call LogMedium;

//--- Variable Destruction.
WFBE_V_UnitsRoot = nil;
WFBE_V_West_UnitsRootVersion = nil;
WFBE_V_East_UnitsRootVersion = nil;
WFBE_V_Resistance_UnitsRootVersion = nil;
WFBE_V_West_Faction = nil;
WFBE_V_East_Faction = nil;
WFBE_V_Resistance_Faction = nil;
WFBE_V_East_SquadsFaction = nil;
WFBE_V_West_SquadsFaction = nil;
WFBE_V_East_SquadsRootVersion = nil;
WFBE_V_West_SquadsRootVersion = nil;
commonInitComplete = true;