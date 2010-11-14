waitUntil { !isNil "LogInited" };
 
Format["Init_Common: Init Start at %1",time] call LogMedium;

if (paramBalancing) then {BalanceInit = Compile PreprocessFile "Common\Functions\Common_BalanceInit.sqf"};
if !(WF_A2_Vanilla) then {
	BackpackHasSpace = Compile preprocessFile "Common\Functions\Common_BackpackHasSpace.sqf";
	EquipBackpack = Compile PreprocessFile "Common\Functions\Common_EquipBackpack.sqf";
};


GetUnitEquipmentPrice = Compile preprocessFile "Common\Functions\Common_GetUnitEquipmentPrice.sqf";
BuildingInRange = Compile preprocessFile "Common\Functions\Common_BuildingInRange.sqf";
ChangeTeamFunds = Compile PreprocessFile "Common\Functions\Common_ChangeTeamFunds.sqf";
ChangeClientFunds = Compile PreprocessFile "Common\Functions\Common_ChangeClientFunds.sqf";
CreateMan = Compile PreprocessFile "Common\Functions\Common_CreateUnit.sqf";
CreateVehi = Compile PreprocessFile "Common\Functions\Common_CreateVehicle.sqf";
EquipLoadout = Compile PreprocessFile "Common\Functions\Common_EquipLoadout.sqf";
GetEquipLoadout = Compile PreprocessFile "Common\Functions\Common_GetEquipLoadout.sqf";
GetEquipDogTags = Compile PreprocessFile "Common\Functions\Common_GetEquipDogTags.sqf";

FireArtillery = Compile PreprocessFile "Common\Functions\Common_FireArtillery.sqf";
FireArtilleryTraceTraectory = Compile PreprocessFile "Common\Functions\Common_FireArtilleryTraceTraectory.sqf";

GetClientID = Compile PreprocessFile "Common\Functions\Common_GetClientID.sqf";
GetClientIDFromTeam = Compile PreprocessFile "Common\Functions\Common_GetClientIDFromTeam.sqf";
GetClientTeam = Compile PreprocessFile "Common\Functions\Common_GetClientTeam.sqf";
GetClosestLocation = Compile PreprocessFile "Common\Functions\Common_GetClosestLocation.sqf";
GetClosestLocationBySide = Compile PreprocessFile "Common\Functions\Common_GetClosestLocationBySide.sqf";
GetCommanderFromVotes = Compile PreprocessFile "Common\Functions\Common_GetCommanderFromVotes.sqf";
GetCommanderTeam = Compile PreprocessFile "Common\Functions\Common_GetCommanderTeam.sqf";
GetCommanderVotes = Compile PreprocessFile "Common\Functions\Common_GetCommanderVotes.sqf";
GetConfigInfo = Compile PreprocessFile "Common\Functions\Common_GetConfigInfo.sqf";
GetFactories = Compile PreprocessFile "Common\Functions\Common_GetFactories.sqf";
GetFriendlyCamps = Compile PreprocessFile "Common\Functions\Common_GetFriendlyCamps.sqf";
GetLiveUnits = Compile PreprocessFile "Common\Functions\Common_GetLiveUnits.sqf";
GetNamespace = Compile PreprocessFile "Common\Functions\Common_GetNamespace.sqf";
GetPositionFrom = Compile PreprocessFile "Common\Functions\Common_GetPositionFrom.sqf";
GetRandomPosition = Compile PreprocessFile "Common\Functions\Common_GetRandomPosition.sqf";
GetSideFromID = Compile PreprocessFile "Common\Functions\Common_GetSideFromID.sqf";
GetSideHQ = Compile PreprocessFile "Common\Functions\Common_GetSideHQ.sqf";
GetSideHQDeployed = Compile PreprocessFile "Common\Functions\Common_GetSideHQDeployed.sqf";
GetSideID = Compile PreprocessFile "Common\Functions\Common_GetSideID.sqf";
GetSideStructures = Compile PreprocessFile "Common\Functions\Common_GetSideStructures.sqf";
GetSideUpgrades = Compile PreprocessFile "Common\Functions\Common_GetSideUpgrades.sqf";
GetTeamArtillery = Compile PreprocessFile "Common\Functions\Common_GetTeamArtillery.sqf";
GetTeamAutonomous = Compile PreprocessFile "Common\Functions\Common_GetTeamAutonomous.sqf";
GetTeamFunds = Compile PreprocessFile "Common\Functions\Common_GetTeamFunds.sqf";
GetTeamMoveMode = Compile PreprocessFile "Common\Functions\Common_GetTeamMoveMode.sqf";
GetTeamMovePos = Compile PreprocessFile "Common\Functions\Common_GetTeamMovePos.sqf";
GetTeamRespawn = Compile PreprocessFile "Common\Functions\Common_GetTeamRespawn.sqf";
GetTeamType = Compile PreprocessFile "Common\Functions\Common_GetTeamType.sqf";
GetTeamVehicles = Compile PreprocessFile "Common\Functions\Common_GetTeamVehicles.sqf";
GetTotalCamps = Compile PreprocessFile "Common\Functions\Common_GetTotalCamps.sqf";
GetTotalCampsOnSide = Compile PreprocessFile "Common\Functions\Common_GetTotalCampsOnSide.sqf";
GetTotalSupplyValue = Compile PreprocessFile "Common\Functions\Common_GetTotalSupplyValue.sqf";
GetTownsHeld = Compile PreprocessFile "Common\Functions\Common_GetTownsHeld.sqf";
GetUnitsBelowHeight = Compile PreprocessFile "Common\Functions\Common_GetUnitsBelowHeight.sqf";
GetUnitVehicle = Compile PreprocessFile "Common\Functions\Common_GetUnitVehicle.sqf";
if (paramISIS) then {
	ISIS_Heal = Compile preProcessFile "Client\Module\ISIS\ISIS_Heal.sqf";
	ISIS_Wound = Compile preProcessFile "Client\Module\ISIS\ISIS_Wound.sqf";
	ISIS_Wounded = Compile preProcessFile "Client\Module\ISIS\ISIS_Wounded.sqf";
};
MarkerUpdate = Compile PreprocessFile "Common\Common_MarkerUpdate.sqf";
PlaceNear = Compile PreprocessFile "Common\Functions\Common_PlaceNear.sqf";
PlaceSafe = Compile PreprocessFile "Common\Functions\Common_PlaceSafe.sqf";
if !(WF_A2_Vanilla) then {
	GetTurretsMags = Compile PreprocessFile "Common\Functions\Common_GetTurretsMags.sqf";
	GetVehicleMags = Compile PreprocessFile "Common\Functions\Common_GetVehicleMags.sqf";
	RearmVehicle = Compile PreprocessFile "Common\Functions\Common_RearmVehicleOA.sqf";
	SetTurretsMags = Compile PreprocessFile "Common\Functions\Common_SetTurretsMags.sqf";
} else {
	RearmVehicle = Compile PreprocessFile "Common\Functions\Common_RearmVehicle.sqf";
};
SetCommanderVotes = Compile PreprocessFile "Common\Functions\Common_SetCommanderVotes.sqf";
SetNamespace = Compile PreprocessFile "Common\Functions\Common_SetNamespace.sqf";
SetTeamAutonomous = Compile PreprocessFile "Common\Functions\Common_SetTeamAutonomous.sqf";
SetTeamRespawn = Compile PreprocessFile "Common\Functions\Common_SetTeamRespawn.sqf";
SetTeamMoveMode = Compile PreprocessFile "Common\Functions\Common_SetTeamMoveMode.sqf";
SetTeamMovePos = Compile PreprocessFile "Common\Functions\Common_SetTeamMovePos.sqf";
SetTeamType = Compile PreprocessFile "Common\Functions\Common_SetTeamType.sqf";
SpawnTurrets = Compile PreprocessFile "Common\Functions\Common_SpawnTurrets.sqf";

QuickSort = Compile PreprocessFile "Common\Functions\Common_QuickSort.sqf";
SortByDistance = Compile PreprocessFile "Common\Functions\Common_SortByDistance.sqf";
UnitKilled = Compile PreprocessFile "Common\Functions\Common_UnitKilled.sqf";
HeadHunters = Compile PreprocessFile "Common\Functions\Common_HeadHunters.sqf";

UseStationaryDefense = Compile PreprocessFile "Common\Functions\Common_UseStationaryDefense.sqf";
if (paramICBM) then {
	NukeDammage = Compile PreprocessFile "Client\Module\Nuke\damage.sqf";
	NukeRadiation = Compile PreprocessFile "Client\Module\Nuke\radzone.sqf";
};

"Init_Common: Functions - [Done]" call LogMedium;

executed = 0;
varQueu = random(10)+random(100)+random(1000);

EastCommanderTeam = ObjNull;
WestCommanderTeam = ObjNull;

if (isNil "EastSupplies") then {EastSupplies = 1200};
if (isNil "WestSupplies") then {WestSupplies = 1200};

Format["Init_Common: Starting Supply (West: %1 East: %2) - [Done]",WestSupplies,EastSupplies] call LogMedium;

['WFBE_EASTSTARTINGMONEY',800,false] Call SetNamespace;
['WFBE_WESTSTARTINGMONEY',800,false] Call SetNamespace;

Format["Init_Common: Starting Funds (West: %1 East: %2) - [Done]",'WFBE_WESTSTARTINGMONEY' Call GetNamespace,'WFBE_EASTSTARTINGMONEY' Call GetNamespace] call LogMedium;

if (paramAllies) then {
	westAlliesFunds = ('WFBE_WESTSTARTINGMONEY' Call GetNamespace)*5;
	eastAlliesFunds = ('WFBE_EASTSTARTINGMONEY' Call GetNamespace)*5;
	
	Format["Init_Common: Allies Starting Funds (West: %1 East: %2) - [Done]",('WFBE_WESTSTARTINGMONEY' Call GetNamespace)*5,('WFBE_EASTSTARTINGMONEY' Call GetNamespace)*5] call LogMedium;
};

unitMarker = 0;

for [{_count = 0},{_count < maxPlayers},{_count = _count + 1}] do {
	Call Compile Format["if (IsNil 'EastTeam%1Vote') then {EastTeam%1Vote = -1}",_count + 1];
	Call Compile Format["if (IsNil 'WestTeam%1Vote') then {WestTeam%1Vote = -1}",_count + 1];
};

[] Call Compile PreprocessFile "Common\Init\Init_CommonConstants.sqf";

/* CORE SYSTEM - Start
	Different Core are added depending on the current ArmA Version running, add yours bellow.
*/
if (WF_A2_Vanilla) then {
	/* Gear Core */
	[] Call Compile PreProcessFile 'Common\Config\Core_Gear\Core_Vanilla_G.sqf';
	/* Units Core */
	[] Call Compile PreProcessFile 'Common\Config\Core\Core_CDF.sqf';
	[] Call Compile PreProcessFile 'Common\Config\Core\Core_CIV.sqf';
	[] Call Compile PreProcessFile 'Common\Config\Core\Core_FR.sqf';
	[] Call Compile PreProcessFile 'Common\Config\Core\Core_GUE.sqf';
	[] Call Compile PreProcessFile 'Common\Config\Core\Core_INS.sqf';
	[] Call Compile PreProcessFile 'Common\Config\Core\Core_MVD.sqf';
	[] Call Compile PreProcessFile 'Common\Config\Core\Core_RU.sqf';
	[] Call Compile PreProcessFile 'Common\Config\Core\Core_Spetsnaz.sqf';
	[] Call Compile PreProcessFile 'Common\Config\Core\Core_USMC.sqf';
};
if (WF_A2_Arrowhead) then {
	/* Gear Core */
	[] Call Compile PreProcessFile 'Common\Config\Core_Gear\Core_Arrowhead_G.sqf';
	[] Call Compile PreProcessFile 'Common\Config\Core_Gear\Core_BAF_G.sqf';
	/* Units Core */
	[] Call Compile PreProcessFile 'Common\Config\Core\Core_BAF.sqf';
	[] Call Compile PreProcessFile 'Common\Config\Core\Core_BAFD.sqf';
	[] Call Compile PreProcessFile 'Common\Config\Core\Core_BAFW.sqf';
	[] Call Compile PreProcessFile 'Common\Config\Core\Core_DeltaForce.sqf';
	[] Call Compile PreProcessFile 'Common\Config\Core\Core_TK.sqf';
	[] Call Compile PreProcessFile 'Common\Config\Core\Core_TKCIV.sqf';
	[] Call Compile PreProcessFile 'Common\Config\Core\Core_TKGUE.sqf';
	[] Call Compile PreProcessFile 'Common\Config\Core\Core_TKSF.sqf';
	[] Call Compile PreProcessFile 'Common\Config\Core\Core_US.sqf';
};
if (WF_A2_CombinedOps) then {
	/* Gear Core */
	[] Call Compile PreProcessFile 'Common\Config\Core_Gear\Core_Vanilla_G.sqf';
	[] Call Compile PreProcessFile 'Common\Config\Core_Gear\Core_Arrowhead_G.sqf';
	[] Call Compile PreProcessFile 'Common\Config\Core_Gear\Core_BAF_G.sqf';
	/* Units Core */
	[] Call Compile PreProcessFile 'Common\Config\Core\Core_BAF.sqf';
	[] Call Compile PreProcessFile 'Common\Config\Core\Core_BAFD.sqf';
	[] Call Compile PreProcessFile 'Common\Config\Core\Core_BAFW.sqf';
	[] Call Compile PreProcessFile 'Common\Config\Core\Core_CDF.sqf';
	[] Call Compile PreProcessFile 'Common\Config\Core\Core_CIV.sqf';
	[] Call Compile PreProcessFile 'Common\Config\Core\Core_DeltaForce.sqf';
	[] Call Compile PreProcessFile 'Common\Config\Core\Core_FR.sqf';
	[] Call Compile PreProcessFile 'Common\Config\Core\Core_GUE.sqf';
	[] Call Compile PreProcessFile 'Common\Config\Core\Core_INS.sqf';
	[] Call Compile PreProcessFile 'Common\Config\Core\Core_MVD.sqf';
	[] Call Compile PreProcessFile 'Common\Config\Core\Core_RU.sqf';
	[] Call Compile PreProcessFile 'Common\Config\Core\Core_Spetsnaz.sqf';
	[] Call Compile PreProcessFile 'Common\Config\Core\Core_TK.sqf';
	[] Call Compile PreProcessFile 'Common\Config\Core\Core_TKCIV.sqf';
	[] Call Compile PreProcessFile 'Common\Config\Core\Core_TKGUE.sqf';
	[] Call Compile PreProcessFile 'Common\Config\Core\Core_TKSF.sqf';
	[] Call Compile PreProcessFile 'Common\Config\Core\Core_US.sqf';
	[] Call Compile PreProcessFile 'Common\Config\Core\Core_USMC.sqf';
};
/* CORE SYSTEM - End */

"Init_Common: Core Loading - [Done]" call LogMedium;

[] Call Compile PreprocessFile "Common\Init\Init_PublicVariables.sqf";
[] Call Compile PreprocessFile "Common\Config\Config_Artillery.sqf";
[] Call Compile PreprocessFile "Common\Config\Config_Barracks.sqf";
[] Call Compile PreprocessFile "Common\Config\Config_LightFactory.sqf";
[] Call Compile PreprocessFile "Common\Config\Config_HeavyFactory.sqf";
[] Call Compile PreprocessFile "Common\Config\Config_AircraftFactory.sqf";
[] Call Compile PreprocessFile "Common\Config\Config_Airport.sqf";
[] Call Compile PreprocessFile "Common\Config\Config_Depot.sqf";
[] Call Compile PreprocessFile "Common\Config\Config_Structures.sqf";
[] Call Compile PreprocessFile "Common\Config\Config_Squads.sqf";
[] Call Compile PreprocessFile "Common\Config\Config_Loadouts.sqf";

"Init_Common: Config Loading - [Done]" call LogMedium;

//--- Boundaries, use setPos to find the perfect spot on other islands and worldName to determine the island name (editor: LogInform worldName; player setPos [0,5120,0]; ).
if (paramBoundaries) then {
	[] Call Compile preprocessFile "Common\Init\Init_Boundaries.sqf";
	"Init_Common: Boundaries Loading - [Done]" call LogMedium;;
};

execVM "Common\Init\Init_UnitEquipmentPrice.sqf";

//--- Disable Artillery Computer.
if (!paramArtyComputer && !WF_A2_Vanilla) then {[] Call Compile preprocessFile 'Common\Common_DisableAC.sqf'};

"Init_Common: Init End" call LogMedium;
commonInitComplete = true;