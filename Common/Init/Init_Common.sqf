diag_log Format["[WFBE (INIT)] Init_Common: Init Start at %1",time];

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
FireArtillery = Compile PreprocessFile "Common\Functions\Common_FireArtillery.sqf";
GetClientID = Compile PreprocessFile "Common\Functions\Common_GetClientID.sqf";
GetClientTeam = Compile PreprocessFile "Common\Functions\Common_GetClientTeam.sqf";
GetClosestLocation = Compile PreprocessFile "Common\Functions\Common_GetClosestLocation.sqf";
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
GetSideID = Compile PreprocessFile "Common\Functions\Common_GetSideID.sqf";
GetTeamArtillery = Compile PreprocessFile "Common\Functions\Common_GetTeamArtillery.sqf";
GetTeamAutonomous = Compile PreprocessFile "Common\Functions\Common_GetTeamAutonomous.sqf";
GetTeamFunds = Compile PreprocessFile "Common\Functions\Common_GetTeamFunds.sqf";
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
SetTeamType = Compile PreprocessFile "Common\Functions\Common_SetTeamType.sqf";
SpawnTurrets = Compile PreprocessFile "Common\Functions\Common_SpawnTurrets.sqf";
SortByDistance = Compile PreprocessFile "Common\Functions\Common_SortByDistance.sqf";
UnitKilled = Compile PreprocessFile "Common\Functions\Common_UnitKilled.sqf";
UseStationaryDefense = Compile PreprocessFile "Common\Functions\Common_UseStationaryDefense.sqf";
if (paramICBM) then {
	NukeDammage = Compile PreprocessFile "Client\Module\Nuke\damage.sqf";
	NukeRadiation = Compile PreprocessFile "Client\Module\Nuke\radzone.sqf";
};

diag_log "[WFBE (INIT)] Init_Common: Functions - [Done]";

executed = 0;
varQueu = random(10)+random(100)+random(1000);

EastBaseStructures = [];
WestBaseStructures = [];

EastCommanderTeam = ObjNull;
WestCommanderTeam = ObjNull;

if (isNil "EastSupplies") then {EastSupplies = 1200};
if (isNil "WestSupplies") then {WestSupplies = 1200};

diag_log Format["[WFBE (INIT)] Init_Common: Starting Supply (West: %1 East: %2) - [Done]",WestSupplies,EastSupplies];

['WFBE_EASTSTARTINGMONEY',800,false] Call SetNamespace;
['WFBE_WESTSTARTINGMONEY',800,false] Call SetNamespace;

diag_log Format["[WFBE (INIT)] Init_Common: Starting Funds (West: %1 East: %2) - [Done]",'WFBE_WESTSTARTINGMONEY' Call GetNamespace,'WFBE_EASTSTARTINGMONEY' Call GetNamespace];

if (paramAllies) then {
	westAlliesFunds = ('WFBE_WESTSTARTINGMONEY' Call GetNamespace)*5;
	eastAlliesFunds = ('WFBE_EASTSTARTINGMONEY' Call GetNamespace)*5;
	
	diag_log Format["[WFBE (INIT)] Init_Common: Allies Starting Funds (West: %1 East: %2) - [Done]",('WFBE_WESTSTARTINGMONEY' Call GetNamespace)*5,('WFBE_EASTSTARTINGMONEY' Call GetNamespace)*5];
};

unitMarker = 0;

for [{_count = 0},{_count < maxPlayers},{_count = _count + 1}] do {
	Call Compile Format["if (IsNil 'EastTeam%1Vote') then {EastTeam%1Vote = -1}",_count + 1];
	Call Compile Format["if (IsNil 'WestTeam%1Vote') then {WestTeam%1Vote = -1}",_count + 1];

	Call Compile Format ["if (IsNil 'WestAITeam%1Order') then {WestAITeam%1Order = 'TAKETOWNS'}",_count + 1];
	Call Compile Format ["if (IsNil 'EastAITeam%1Order') then {EastAITeam%1Order = 'TAKETOWNS'}",_count + 1];

	Call Compile Format ["if (IsNil 'WestAITeam%1Coord') then {WestAITeam%1Coord = []}",_count + 1];
	Call Compile Format ["if (IsNil 'EastAITeam%1Coord') then {EastAITeam%1Coord = []}",_count + 1];
};

/* CORE SYSTEM - Start
	Different Core are added depending on the current ArmA Version running, add yours bellow.
*/
if (WF_A2_Vanilla) then {
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

diag_log "[WFBE (INIT)] Init_Common: Core Loading - [Done]";

[] Call Compile PreprocessFile "Common\Init\Init_CommonConstants.sqf";
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

diag_log "[WFBE (INIT)] Init_Common: Config Loading - [Done]";

//--- Boundaries, use setPos to find the perfect spot on other islands and worldName to determine the island name (editor: diag_log worldName; player setPos [0,5120,0]; ).
if (paramBoundaries) then {
	[] Call Compile preprocessFile "Common\Init\Init_Boundaries.sqf";
	diag_log "[WFBE (INIT)] Init_Common: Boundaries Loading - [Done]";
};

//--- Disable Artillery Computer.
if (!paramArtyComputer && !WF_A2_Vanilla) then {[] Call Compile preprocessFile 'Common\Common_DisableAC.sqf'};

diag_log Format["[WFBE (INIT)] Init_Common: Init End at %1",time];
commonInitComplete = true;