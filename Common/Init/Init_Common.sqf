if (balancing) then {BalanceInit = Compile PreprocessFile "Common\Functions\Common_BalanceInit.sqf"};
BuildingInRange = Compile preprocessFile "Common\Functions\Common_BuildingInRange.sqf";
ChangeTeamFunds = Compile PreprocessFile "Common\Functions\Common_ChangeTeamFunds.sqf";
ChangeClientFunds = Compile PreprocessFile "Common\Functions\Common_ChangeClientFunds.sqf";
CommandToClient = Compile PreprocessFile "Server\Server_CommandToClient.sqf";
CommandToClients = Compile PreprocessFile "Server\Server_CommandToClients.sqf";
CommandToSide = Compile PreprocessFile "Server\Server_CommandToSide.sqf";
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
if (ISIS) then {
	ISIS_Heal = Compile preProcessFile "Client\Module\ISIS\ISIS_Heal.sqf";
	ISIS_Wound = Compile preProcessFile "Client\Module\ISIS\ISIS_Wound.sqf";
	ISIS_Wounded = Compile preProcessFile "Client\Module\ISIS\ISIS_Wounded.sqf";
};
MarkerUpdate = Compile PreprocessFile "Common\Common_MarkerUpdate.sqf";
PlaceNear = Compile PreprocessFile "Common\Functions\Common_PlaceNear.sqf";
PlaceSafe = Compile PreprocessFile "Common\Functions\Common_PlaceSafe.sqf";
RearmVehicle = Compile PreprocessFile "Common\Functions\Common_RearmVehicle.sqf";
SetCommanderVotes = Compile PreprocessFile "Common\Functions\Common_SetCommanderVotes.sqf";
SetNamespace = Compile PreprocessFile "Common\Functions\Common_SetNamespace.sqf";
SetTeamAutonomous = Compile PreprocessFile "Common\Functions\Common_SetTeamAutonomous.sqf";
SetTeamRespawn = Compile PreprocessFile "Common\Functions\Common_SetTeamRespawn.sqf";
SetTeamType = Compile PreprocessFile "Common\Functions\Common_SetTeamType.sqf";
SpawnTurrets = Compile PreprocessFile "Common\Functions\Common_SpawnTurrets.sqf";
SortByDistance = Compile PreprocessFile "Common\Functions\Common_SortByDistance.sqf";
UnitKilled = Compile PreprocessFile "Common\Functions\Common_UnitKilled.sqf";
UseStationaryDefense = Compile PreprocessFile "Common\Functions\Common_UseStationaryDefense.sqf";
if (icbm) then {
	NukeDammage = Compile PreprocessFile "Client\Module\Nuke\damage.sqf";
	NukeRadiation = Compile PreprocessFile "Client\Module\Nuke\radzone.sqf";
};

executed = 0;
varQueu = random(10)+random(100)+random(1000);

EastBaseStructures = [];
WestBaseStructures = [];

EastCommanderTeam = ObjNull;
WestCommanderTeam = ObjNull;

if (isNil "EastSupplies") then {EastSupplies = 1200};
if (isNil "WestSupplies") then {WestSupplies = 1200};

['WFBE_EASTSTARTINGMONEY',800,false] Call SetNamespace;
['WFBE_WESTSTARTINGMONEY',800,false] Call SetNamespace;

if (allies) then {
	westAlliesFunds = ('WFBE_WESTSTARTINGMONEY' Call GetNamespace)*5;
	eastAlliesFunds = ('WFBE_EASTSTARTINGMONEY' Call GetNamespace)*5;
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
//--- Boundaries, use setPos to find the perfect spot on other islands and worldName to determine the island name (editor: diag_log worldName; player setPos [0,5120,0]; ).
if (paramBoundaries) then {[] Call Compile preprocessFile "Common\Init\Init_Boundaries.sqf"};

['WFBE_UNITBOUNTYNAMES',('WFBE_SOLDIERUNITS' Call GetNamespace) + ('WFBE_LIGHTUNITS' Call GetNamespace) + ('WFBE_HEAVYUNITS' Call GetNamespace) + ('WFBE_AIRCRAFTUNITS' Call GetNamespace) + ('WFBE_EASTDEFENSENAMES' Call GetNamespace) + ('WFBE_WESTDEFENSENAMES' Call GetNamespace) + ('WFBE_RESISTANCEDEFENSENAMES' Call GetNamespace),true] Call SetNamespace;
['WFBE_UNITBOUNTIES',('WFBE_SOLDIERUNITCOSTS' Call GetNamespace) + ('WFBE_LIGHTUNITCOSTS' Call GetNamespace) + ('WFBE_HEAVYUNITCOSTS' Call GetNamespace) + ('WFBE_AIRCRAFTUNITCOSTS' Call GetNamespace) + ('WFBE_EASTDEFENSECOSTS' Call GetNamespace) + ('WFBE_WESTDEFENSECOSTS' Call GetNamespace) + ('WFBE_RESISTANCEDEFENSECOSTS' Call GetNamespace),true] Call SetNamespace;
['WFBE_UNITBOUNTYDESCRIPTIONS',('WFBE_SOLDIERUNITDESCRIPTIONS' Call GetNamespace) + ('WFBE_LIGHTUNITDESCRIPTIONS' Call GetNamespace) + ('WFBE_HEAVYUNITDESCRIPTIONS' Call GetNamespace) + ('WFBE_AIRCRAFTUNITDESCRIPTIONS' Call GetNamespace) + ('WFBE_EASTDEFENSEDESCRIPTIONS' Call GetNamespace) + ('WFBE_WESTDEFENSEDESCRIPTIONS' Call GetNamespace) + ('WFBE_RESISTANCEDEFENSEDESCRIPTIONS' Call GetNamespace),true] Call SetNamespace;

commonInitComplete = true;