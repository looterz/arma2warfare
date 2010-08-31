if (!isServer || time > 30) exitWith {};

createCenter resistance; //--- Allow resistance group to be spawned without a placeholder.
resistance setFriend [west,0];
resistance setFriend [east,0];

if (AI) then {
	AIBuyUnit = Compile preprocessFile "Server\Functions\Server_BuyUnit.sqf";
	AISquadRespawn = Compile preprocessFile "Server\AI\AI_SquadRespawn.sqf";
};
AIMoveTo = Compile preprocessFile "Server\AI\Orders\AI_MoveTo.sqf";
AIPatrol = Compile preprocessFile "Server\AI\Orders\AI_Patrol.sqf";
AITownResitance = Compile preprocessFile "Server\AI\AI_Resistance.sqf";
AIWPRemove = Compile preprocessFile "Server\AI\Orders\AI_WPRemove.sqf";
if (allies) then {AlliesBuyUnit = Compile preprocessFile "Server\Functions\Server_AlliesBuyUnit.sqf"};
BuildingDamaged = Compile preprocessFile "Server\Functions\Server_BuildingDamaged.sqf";
if (handleFF) then {BuildingHandleDamages = Compile preprocessFile "Server\Functions\Server_BuildingHandleDamages.sqf"};
BuildingKilled = Compile preprocessFile "Server\Functions\Server_BuildingKilled.sqf";
CommandsFromClients = Compile preprocessFile "Server\Server_CommandsFromClients.sqf";
HandleDefense = Compile preprocessFile "Server\Functions\Server_HandleDefense.sqf";
HandleSpecial = Compile preprocessFile "Server\Functions\Server_HandleSpecial.sqf";
HQKilled = Compile preprocessFile "Server\Functions\Server_HQKilled.sqf";
MHQRepair = Compile preprocessFile "Server\Functions\Server_MHQRepair.sqf";
SelectOccupTeam = Compile preprocessFile "Server\Functions\Server_SelectOccupTeam.sqf";
SetCampsToSide = Compile preprocessFile "Server\Functions\Server_SetCampsToSide.sqf";
SideMessage = Compile preprocessFile "Server\Functions\Server_SideMessage.sqf";
SVoteForCommander = Compile preprocessFile "Server\Server_VoteForCommander.sqf";
UpdateSupplyTruck = Compile preprocessFile "Server\AI\AI_UpdateSupplyTruck.sqf";

serverInitComplete = true;

if (mysql) then {
	WF_Logic setVariable ["WF_MYSQL_CLIENT",[],true];
	WF_Logic setVariable ["WF_MYSQL_SERVER",[Format ["MYSQLDATA§WFBE_Insert_Island§%1§%2",worldName,getText (configFile >> "CfgWorlds" >> worldName >> "description")]]];
	[] ExecFSM "Server\FSM\queryhandler.fsm";
	
	JIP_SQL_Time = [];
};

//--- All players connects, even at the very begining & d/c later on.
onPlayerConnected "[_uid,_name] ExecVM 'Server\Server_PlayerConnected.sqf'";
onPlayerDisconnected "[_uid,_name] ExecVM 'Server\Server_PlayerDisconnected.sqf'";

JIPArrayUID = [];
JIPArrayIndex = [];
JIPArrayCash = [];
JIPArraySide = [];
JIPArrayCurSide = [];

startingLocations = [];
_total = 0;

//--- Getting all locations.
while {!isNil Format["StartingLocation%1",_total]} do {
	startingLocations = startingLocations + [Call Compile Format["StartingLocation%1",_total]];
	_total = _total + 1;
};

if (fastTime) then {[] ExecFSM "Server\FSM\fasttime.fsm"};
if (weather) then {[] ExecFSM "Server\FSM\weather.fsm"};

//--- Waiting for the common part to be executed.
waitUntil {commonInitComplete && townInit};
//--- Static defenses in town main group, they share their knowledge.
WF_ResistanceDefenseTeam = createGroup resistance;

_locationLogics = [];
if (spawnSystemRestrict) then {
	{
		_nearLogics = _x nearEntities[["LocationLogic"],2000];
		if (count _nearLogics > 0) then {{if !(_x in _locationLogics) then {_locationLogics = _locationLogics + [_x]}} forEach _nearLogics};
	} forEach towns;
	if (count _locationLogics < 3) then {{if !(_x in _locationLogics) then {_locationLogics = _locationLogics + [_x]}} forEach [StartingLocation0,StartingLocation1]};
} else {
	_locationLogics = startingLocations;
};

_total = count _locationLogics;

//--- Getting locations that have a distance above the SIDESTARTINGDISTANCE variable.
_westLocation = StartingLocation0;
_eastLocation = StartingLocation0;
switch ('WFBE_STARTINGLOCATIONMODE' Call GetNamespace) do {
	case 0: {_westLocation = StartingLocation0; _eastLocation = StartingLocation1};//--- West North, East South.
	case 1: {_westLocation = StartingLocation1; _eastLocation = StartingLocation0};//--- West South, East North.
	case 2: {
		//--- Random. Attempt to get a location above the given range.
		_attempts = 0;
		_ssd = 'WFBE_SIDESTARTINGDISTANCE' Call GetNamespace;
		while {_eastLocation distance _westLocation < _ssd && _attempts <= 500} do {
			_eastLocation = _locationLogics select (random (_total - 1));
			_westLocation = _locationLogics select (random (_total - 1));
			_attempts = _attempts + 1;
		};

		//--- Couldn't find a starting location in range.
		if (_attempts >= 500) then {
			if (spawnSystemRestrict) then {
				_westLocation = _locationLogics select 0;
				_eastLocation = _locationLogics select ((count _locationLogics)-1);
			} else {
				_westLocation = StartingLocation0;
				_eastLocation = StartingLocation1;
			};
		};
	};
};

//--- Moving each non-owner objects to the location.
EastMHQ setPos getPos _eastLocation;
WestMHQ setPos getPos _westLocation;

if (handleFF) then {
	EastMHQ addEventHandler ['handleDamage',{[_this select 0,_this select 2,_this select 3, east] Call BuildingHandleDamages}];
	WestMHQ addEventHandler ['handleDamage',{[_this select 0,_this select 2,_this select 3, west] Call BuildingHandleDamages}];
};

eastStartingLocation = _eastLocation;
westStartingLocation = _westLocation;

//--- Store HQ in the global var.
WF_Logic setVariable ["WestMHQ",WestMHQ,true];
WF_Logic setVariable ["EastMHQ",EastMHQ,true];

Call Compile Format ["EastMHQ AddEventHandler ['killed',{[_this select 0,_this select 1,%1,'%2'] Spawn HQKilled}];",east,typeOf EastMHQ];
Call Compile Format ["WestMHQ AddEventHandler ['killed',{[_this select 0,_this select 1,%1,'%2'] Spawn HQKilled}];",west,typeOf WestMHQ];

//--- Voice System (bikb).
_WF_GroupLogic = createGroup sideLogic;
_WF_GroupLogic2 = createGroup sideLogic;
_WF_GroupLogic3 = createGroup sideLogic;
_WF_GroupLogic4 = createGroup sideLogic;

_BIS_WF_HQEASTgrp = createGroup east;
_BIS_WF_HQWESTgrp = createGroup west;
_BIS_WF_HQEASTgrp2 = createGroup east;
_BIS_WF_HQWESTgrp2 = createGroup west;

BIS_WF_HQEAST = _WF_GroupLogic createUnit ["Logic",[0,0,0],[],0,"NONE"]; [BIS_WF_HQEAST] joinSilent _BIS_WF_HQEASTgrp;
BIS_WF_HQWEST = _WF_GroupLogic2 createUnit ["Logic",[0,0,0],[],0,"NONE"]; [BIS_WF_HQWEST] joinSilent _BIS_WF_HQWESTgrp;
BIS_WF_HQEAST2 = _WF_GroupLogic3 createUnit ["Logic",[0,0,0],[],0,"NONE"]; [BIS_WF_HQEAST2] joinSilent _BIS_WF_HQEASTgrp2;
BIS_WF_HQWEST2 = _WF_GroupLogic4 createUnit ["Logic",[0,0,0],[],0,"NONE"]; [BIS_WF_HQWEST2] joinSilent _BIS_WF_HQWESTgrp2;

BIS_WF_HQEAST setVariable ['_topic_identity',('WFBE_ANNOUNCERSEAST' Call GetNamespace) select round(random((count ('WFBE_ANNOUNCERSEAST' Call GetNamespace))-1)),true];
BIS_WF_HQWEST setVariable ['_topic_identity',('WFBE_ANNOUNCERSWEST' Call GetNamespace) select round(random((count ('WFBE_ANNOUNCERSWEST' Call GetNamespace))-1)),true];

{  
  _x setIdentity (_x getVariable "_topic_identity");
  _x setRank "COLONEL";
  _x setGroupId ["HQ"];
  _x kbAddTopic [(_x getVariable "_topic_identity"),"Client\kb\hq.bikb","Client\kb\hq.fsm",{call compile preprocessFileLineNumbers "Client\kb\hq.sqf"}]; 
} forEach [BIS_WF_HQEAST, BIS_WF_HQWEST];

WF_Logic setVariable ["BIS_WF_HQEAST",BIS_WF_HQEAST,true];
WF_Logic setVariable ["BIS_WF_HQWEST",BIS_WF_HQWEST,true];

westTimeUnderAttack = 0;
eastTimeUnderAttack = 0;

westLastCommander = objNull;
eastLastCommander = objNull;

westAIBase = false;
eastAIBase = false;

eastUpgrading = false;
westUpgrading = false;

eastAISupplyTrucks = [];
westAISupplyTrucks = [];

//--- MHQ Tracking.
EastMHQ setVehicleInit "['Headquarters','ColorGreen',[1,1],'','HQUndeployed',this,0.2,false,'','',false,East] ExecVM 'Common\Common_MarkerUpdate.sqf'";
processInitCommands;
WestMHQ setVehicleInit "['Headquarters','ColorGreen',[1,1],'','HQUndeployed',this,0.2,false,'','',false,West] ExecVM 'Common\Common_MarkerUpdate.sqf'";
processInitCommands;

WF_Logic setVariable ["eastUnitsCreated",0,true];
WF_Logic setVariable ["eastCasualties",0,true];
WF_Logic setVariable ["eastVehiclesCreated",0,true];
WF_Logic setVariable ["eastVehiclesLost",0,true];
WF_Logic setVariable ["westUnitsCreated",0,true];
WF_Logic setVariable ["westCasualties",0,true];
WF_Logic setVariable ["westVehiclesCreated",0,true];
WF_Logic setVariable ["westVehiclesLost",0,true];

WF_Logic setVariable ["WF_CHQInUse_West",false];
WF_Logic setVariable ["WF_CHQInUse_East",false];

if (AI) then {
	//--- Loadout replacement & positioning & variables.
	{
		if !(isNil "_x") then {
			if (!isPlayer (leader _x) && alive (leader _x)) then {
				_ran = 1 + round(random(2));
				(leader _x) setPos ([getPos _eastLocation,20,30] Call GetRandomPosition);
				[(leader _x),Format ["WFBE_EASTLEADERWEAPONS0%1",_ran] Call GetNamespace,Format ["WFBE_EASTLEADERAMMO0%1",_ran] Call GetNamespace] Call EquipLoadout;
			};
			_x setVariable ["queue",[]];
			_x setVariable ["funds",'WFBE_EASTSTARTINGMONEY' Call GetNamespace,true];
			[_x, false] 	Call SetTeamAutonomous;
			[_x, ""] 		Call SetTeamRespawn;
			[_x, -1] 		Call SetTeamType;
			if (ISIS) then {(leader _x) addEventHandler['handleDamage',{_this Call ISIS_Wound}]};
		};
	} forEach ('WFBE_EASTTEAMS' Call GetNamespace);
	{
		if !(isNil "_x") then {
			if (!isPlayer (leader _x) && alive (leader _x)) then {
				_ran = 1 + round(random(2));
				(leader _x) setPos ([getPos _westLocation,20,30] Call GetRandomPosition);
				[(leader _x),Format ["WFBE_WESTLEADERWEAPONS0%1",_ran] Call GetNamespace,Format ["WFBE_WESTLEADERAMMO0%1",_ran] Call GetNamespace] Call EquipLoadout;
			};
			_x setVariable ["queue",[]];
			_x setVariable ["funds",'WFBE_WESTSTARTINGMONEY' Call GetNamespace,true];
			[_x, false] 	Call SetTeamAutonomous;
			[_x, ""] 		Call SetTeamRespawn;
			[_x, -1] 		Call SetTeamType;
			if (ISIS) then {(leader _x) addEventHandler['handleDamage',{_this Call ISIS_Wound}]};
		};
	} forEach ('WFBE_WESTTEAMS' Call GetNamespace);
	
	//--- AI Supply Trucks.
	if (('WFBE_SUPPLYSYSTEM' Call GetNamespace) == 0) then {
		[east] Spawn UpdateSupplyTruck;
		[west] Spawn UpdateSupplyTruck;
	};
	
	//--- AI Teams (Don't pause the server initialization process).
	[] Spawn {
		waitUntil{townInit};
		{if (!isNil "_x") then {[_x] ExecFSM "Server\FSM\aiteam.fsm"}} forEach ('WFBE_EASTTEAMS' Call GetNamespace);
		{if (!isNil "_x") then {[_x] ExecFSM "Server\FSM\aiteam.fsm"}} forEach ('WFBE_WESTTEAMS' Call GetNamespace);
	};
} else {
	{
		if !(isNil "_x") then {
			_x setVariable ["funds",'WFBE_EASTSTARTINGMONEY' Call GetNamespace,true];
			[_x, false] 	Call SetTeamAutonomous;
			[_x, ""] 		Call SetTeamRespawn;
			[_x, -1] 		Call SetTeamType;
		};
	} forEach ('WFBE_EASTTEAMS' Call GetNamespace);
	{
		if !(isNil "_x") then {
			_x setVariable ["funds",'WFBE_WESTSTARTINGMONEY' Call GetNamespace,true];
			[_x, false] 	Call SetTeamAutonomous;
			[_x, ""] 		Call SetTeamRespawn;
			[_x, -1] 		Call SetTeamType;
		};
	} forEach ('WFBE_WESTTEAMS' Call GetNamespace);
};

WF_Logic setVariable ["EastBaseStructures",EastBaseStructures,true];
WF_Logic setVariable ["WestBaseStructures",WestBaseStructures,true];

//--- Create the respawn markers for both side.
createMarkerLocal ["Respawn_east",getPos EastMHQ];
"Respawn_east" setMarkerTypeLocal "Empty";
"Respawn_east" setMarkerColorLocal "ColorGreen";
createMarkerLocal ["Respawn_west",getPos WestMHQ];
"Respawn_west" setMarkerTypeLocal "Empty";
"Respawn_west" setMarkerColorLocal "ColorGreen";

//--- Setposing for accuracy.
"Respawn_east" setMarkerPosLocal getPos EastMHQ;
"Respawn_west" setMarkerPosLocal getPos WestMHQ;

//--- Town starting mode.
if (('WFBE_TOWNSTARTINGMODE' Call GetNamespace) != 0 || resPatrol || resStriker) then {[] Call Compile preprocessFile "Server\Init\Init_Towns.sqf"};

//--- Network execution.
[] Spawn CommandsFromClients;

//--- Starter Vehicles:
_starterVehicle = [];
_vehicle = if (WF_A2_Vanilla || WF_A2_CombinedOps) then {["Kamaz",(getPos EastMHQ),east,false] Call CreateVehi} else {["V3S_TK_EP1",(getPos EastMHQ),east,false] Call CreateVehi};
[_vehicle,getPos EastMHQ,45,60,true,false,true] Call PlaceNear;
_starterVehicle = _starterVehicle + [_vehicle];
_vehicle = if (WF_A2_Vanilla || WF_A2_CombinedOps) then {["GAZ_Vodnik_MedEvac",(getPos EastMHQ),east,false] Call CreateVehi} else {["M113Ambul_TK_EP1",(getPos EastMHQ),east,false] Call CreateVehi};
[_vehicle,getPos EastMHQ,45,60,true,false,true] Call PlaceNear;
_starterVehicle = _starterVehicle + [_vehicle];

_vehicle = if (WF_A2_Vanilla) then {["MTVR",(getPos WestMHQ),west,false] Call CreateVehi} else {["MTVR_DES_EP1",(getPos WestMHQ),west,false] Call CreateVehi};
[_vehicle,getPos WestMHQ,45,60,true,false,true] Call PlaceNear;
_starterVehicle = _starterVehicle + [_vehicle];
_vehicle = if (WF_A2_Vanilla) then {["HMMWV_Ambulance",(getPos WestMHQ),west,false] Call CreateVehi} else {["HMMWV_Ambulance_DES_EP1",(getPos WestMHQ),west,false] Call CreateVehi};
[_vehicle,getPos WestMHQ,45,60,true,false,true] Call PlaceNear;
_starterVehicle = _starterVehicle + [_vehicle];

//--- Pre-initialization of the Garbage Collector & Empty vehicle collector.
WF_Logic setVariable ["trash",[],true];
WF_Logic setVariable ["emptyVehicles",_starterVehicle,true];

//--- Misc SQF|FSM execution.
[] Call Compile preprocessFile "Server\Config\Config_Resistance.sqf";
[] Call Compile preprocessFile "Server\Config\Config_Occupation.sqf";
//--- Don't pause the server init script.
[] Spawn {
	waitUntil {townInit};
	[] ExecFSM "Server\FSM\updateserver.fsm";
	[] ExecFSM "Server\FSM\updateresources.fsm";
};
[] ExecFSM "Server\FSM\garbagecollector.fsm";
[] ExecFSM "Server\FSM\emptyvehiclescollector.fsm";

//--- Network System Part 2.
WF_Logic setVariable ["EastMHQDeployed",false,true];
WF_Logic setVariable ["WestMHQDeployed",false,true];

WF_Logic setVariable ["EastSupplies",EastSupplies,true];
WF_Logic setVariable ["WestSupplies",WestSupplies,true];

WF_Logic setVariable ["EastStartingLocation",_eastLocation,true];
WF_Logic setVariable ["WestStartingLocation",_westLocation,true];

WF_Logic setVariable ["EastCommanderVoteTime",60,true];
WF_Logic setVariable ["WestCommanderVoteTime",60,true];

WF_Logic setVariable ["EastCommanderTeam",EastCommanderTeam,true];
WF_Logic setVariable ["WestCommanderTeam",WestCommanderTeam,true];

WF_Logic setVariable ["EastMHQRepair",false,true];
WF_Logic setVariable ["WestMHQRepair",false,true];

_upArray = if (paramUpgradesEast) then {[0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0]} else {'WFBE_UPGRADELEVELS' Call GetNamespace};
WF_Logic setVariable ["EastUpgrades",_upArray,true];
_upArray = if (paramUpgradesWest) then {[0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0]} else {'WFBE_UPGRADELEVELS' Call GetNamespace};
WF_Logic setVariable ["WestUpgrades",_upArray,true];

if (respawnMASH) then {
	WF_Logic setVariable ["EastMASH",objNull,true];
	WF_Logic setVariable ["WestMASH",objNull,true];
};

//--- Base Area (grouped base)
if (baseArea) then {
	WF_Logic setVariable ["EastArea",[],true];
	WF_Logic setVariable ["WestArea",[],true];
	
	[] ExecFSM "Server\FSM\basearea.fsm";
};

//--- Allies base.
if (allies && (WF_A2_Vanilla || WF_A2_CombinedOps)) then {
	[] Call Compile preprocessFile "Server\Config\Config_Allies.sqf";
	[west] ExecFSM "Server\FSM\allies.fsm";
	[east] ExecFSM "Server\FSM\allies.fsm";
};

//--- Auto Defenses Manning.
if (autoDefense) then {
	WF_DefenseWestGrp = createGroup west;
	WF_DefenseEastGrp = createGroup east;
};

//--- ALICE Module.
if (paramAlice) then {
	_type = if (WF_A2_Vanilla) then {'AliceManager'} else {'Alice2Manager'};
	_alice = (createGroup sideLogic) createUnit [_type,[0,0,0],[],0,"NONE"];
};

//--- Waiting until the game is launched, common is intialized (ressources saver).
waitUntil {time > 0};

[East] Spawn SVoteForCommander;
[West] Spawn SVoteForCommander;