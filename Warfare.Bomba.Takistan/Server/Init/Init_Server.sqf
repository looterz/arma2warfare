#include "profiler.h"
PROFILER_BEGIN("Init_Server");

waitUntil { !isNil "initJIP" };

if (!isServer || time > 30) exitWith {
	"Init_Server: The server initialization cannot be called more than once." call LogError;
};

Format["Init_Server: Init Start"] call LogMedium;

	createCenter resistance; //--- Allow resistance group to be spawned without a placeholder.
	resistance setFriend [west,0];
	resistance setFriend [east,0];

if (paramTownsCivilians) then {createCenter civilian};

	if (paramAI) then {
		AIBuyUnit = Compile preprocessFile "Server\Functions\Server_BuyUnit.sqf";
	};
	
	AIMoveTo = Compile preprocessFile "Server\AI\Orders\AI_MoveTo.sqf";
	AIPatrol = Compile preprocessFile "Server\AI\Orders\AI_Patrol.sqf";
	AITownPatrol = Compile preprocessFile "Server\AI\Orders\AI_TownPatrol.sqf";
	AITownResitance = Compile preprocessFile "Server\AI\AI_Resistance.sqf";
	AIWPAdd = Compile preprocessFile "Server\AI\Orders\AI_WPAdd.sqf";
	AIWPRemove = Compile preprocessFile "Server\AI\Orders\AI_WPRemove.sqf";
	if (paramAllies) then {AlliesBuyUnit = Compile preprocessFile "Server\Functions\Server_AlliesBuyUnit.sqf"};
	BuildingDamaged = Compile preprocessFile "Server\Functions\Server_BuildingDamaged.sqf";
	if (paramHandleFF) then {BuildingHandleDamages = Compile preprocessFile "Server\Functions\Server_BuildingHandleDamages.sqf"};

	BuildingKilled = Compile preprocessFile "Server\Functions\Server_BuildingKilled.sqf";
	CanUpdateTeam = Compile preprocessFile "Server\Functions\Server_CanUpdateTeam.sqf";
	HandleDefense = Compile preprocessFile "Server\Functions\Server_HandleDefense.sqf";
	
	HandleRequest_LockVehicle = Compile preprocessFile "Server\Request\HandleRequest_LockVehicle.sqf";
	HandleRequest_CheatDetected = Compile preprocessFile "Server\Request\HandleRequest_CheatDetected.sqf";

HandleSPVF = Compile preprocessFile "Server\Functions\Server_HandleSPVF.sqf";
HandleSpecial = Compile preprocessFile "Server\Functions\Server_HandleSpecial.sqf";
HQKilled = Compile preprocessFile "Server\Functions\Server_HQKilled.sqf";
MHQRepair = Compile preprocessFile "Server\Functions\Server_MHQRepair.sqf";
SelectOccupTeam = Compile preprocessFile "Server\Functions\Server_SelectOccupTeam.sqf";
SetCampsToSide = Compile preprocessFile "Server\Functions\Server_SetCampsToSide.sqf";
SideMessage = Compile preprocessFile "Server\Functions\Server_SideMessage.sqf";
SVoteForCommander = Compile preprocessFile "Server\Server_VoteForCommander.sqf";

UpdateTeam = Compile preprocessFile "Server\Functions\Server_UpdateTeam.sqf";
UpdateSupplyTruck = Compile preprocessFile "Server\AI\AI_UpdateSupplyTruck.sqf";

KAT_ParaAmmo = Compile preProcessfile "Server\Support\Support_ParaAmmo.sqf";
KAT_Paratroopers = Compile preProcessfile "Server\Support\Support_Paratroopers.sqf";
KAT_ParaVehicles = Compile preProcessfile "Server\Support\Support_ParaVehicles.sqf";
KAT_UAV = Compile preProcessfile "Server\Support\Support_UAV.sqf";

"Init_Server: Functions - [Done]" call LogMedium;

if (mysql) then {
	WF_Logic setVariable ["WF_MYSQL_CLIENT",[],true];
	WF_Logic setVariable ["WF_MYSQL_SERVER",[Format ["MYSQLDATA§WFBE_Insert_Island§%1§%2",worldName,getText (configFile >> "CfgWorlds" >> worldName >> "description")]]];
	[] ExecFSM "Server\FSM\queryhandler.fsm";
	
	"Init_Server: MySQL Module - [Done]"  call LogMedium;
};

//--- JIP Handling.
onPlayerConnected "[_uid,_name] ExecVM 'Server\Server_PlayerConnected.sqf'";
onPlayerDisconnected "[_uid,_name] ExecVM 'Server\Server_PlayerDisconnected.sqf'";

"Init_Server: JIP - [Done]" call LogMedium;

startingLocations = [];
_total = 0;

//--- Getting all locations.
while {!isNil Format["StartingLocation%1",_total]} do {
	startingLocations = startingLocations + [Call Compile Format["StartingLocation%1",_total]];
	_total = _total + 1;
};

"Init_Server: Starting Locations - [Done]"  call LogMedium;

//--- Waiting for the common part to be executed.
waitUntil {commonInitComplete && townInit};

if (paramFastTime) then {
	[] ExecFSM "Server\FSM\fasttime.fsm";
	"Init_Server: Fast Time Module - [Done]"  call LogMedium;;
};

//--- Weather.
_weat = 'WFBE_WEATHER' Call GetNamespace;
if (_weat == 3) then {
	[] ExecFSM "Server\FSM\weather.fsm";
} else {
	if (isDedicated) then {
		_oc = 0.05;
		switch (_weat) do {
			case 0: {_oc = 0};
			case 1: {_oc = 0.5};
			case 2: {_oc = 1};
		};
		60 setOvercast _oc;
	};
};

"Init_Server: Weather Module - [Done]"  call LogMedium;;

//--- Static defenses in town main group, they share their knowledge.
WF_ResistanceDefenseTeam = createGroup resistance;

"Init_Server: Common and Towns - [Done]" call LogMedium;

_locationLogics = [];
if (paramSpawnRestriction) then {
	{
		_nearLogics = _x nearEntities[["LocationLogic"],2000];
		if (count _nearLogics > 0) then {{if !(_x in _locationLogics) then {_locationLogics = _locationLogics + [_x]}} forEach _nearLogics};
	} forEach towns;
	if (count _locationLogics < 3) then {{if !(_x in _locationLogics) then {_locationLogics = _locationLogics + [_x]}} forEach [StartingLocation0,StartingLocation1]};
	"Init_Server: Spawn Restriction - [Done]"  call LogMedium;
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
			if (paramSpawnRestriction) then {
				_westLocation = _locationLogics select 0;
				_eastLocation = _locationLogics select ((count _locationLogics)-1);
			} else {
				_westLocation = StartingLocation0;
				_eastLocation = StartingLocation1;
			};
		};
	};
};

Format ["Init_Server: Starting Location Mode (%1) - [Done]",'WFBE_STARTINGLOCATIONMODE' Call GetNamespace]  call LogMedium;

//--- Moving each non-owner objects to the location.
EastMHQ setPos getPos _eastLocation;
WestMHQ setPos getPos _westLocation;

"Init_Server: HQ Positioned - [Done]" call LogMedium;

if (paramHandleFF) then {
	EastMHQ addEventHandler ['handleDamage',{[_this select 0,_this select 2,_this select 3, east] Call BuildingHandleDamages}];
	WestMHQ addEventHandler ['handleDamage',{[_this select 0,_this select 2,_this select 3, west] Call BuildingHandleDamages}];
	"Init_Server: Friendly Fire Handling - [Done]" call LogMedium;
};

eastStartingLocation = _eastLocation;
westStartingLocation = _westLocation;

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

BIS_WF_HQEAST_TI = ('WFBE_ANNOUNCERSEAST' Call GetNamespace) select round(random((count ('WFBE_ANNOUNCERSEAST' Call GetNamespace))-1));
BIS_WF_HQWEST_TI = ('WFBE_ANNOUNCERSWEST' Call GetNamespace) select round(random((count ('WFBE_ANNOUNCERSWEST' Call GetNamespace))-1));

BIS_WF_HQEAST setIdentity BIS_WF_HQEAST_TI;
BIS_WF_HQEAST setRank 'COLONEL';
BIS_WF_HQEAST setGroupId ["HQ"];
BIS_WF_HQEAST kbAddTopic [BIS_WF_HQEAST_TI,"Client\kb\hq.bikb","Client\kb\hq.fsm",{call compile preprocessFileLineNumbers "Client\kb\hq.sqf"}];

BIS_WF_HQWEST setIdentity BIS_WF_HQWEST_TI;
BIS_WF_HQWEST setRank 'COLONEL';
BIS_WF_HQWEST setGroupId ["HQ"];
BIS_WF_HQWEST kbAddTopic [BIS_WF_HQWEST_TI,"Client\kb\hq.bikb","Client\kb\hq.fsm",{call compile preprocessFileLineNumbers "Client\kb\hq.sqf"}];

publicVariable 'BIS_WF_HQEAST';
publicVariable 'BIS_WF_HQEAST_TI';
publicVariable 'BIS_WF_HQWEST';
publicVariable 'BIS_WF_HQWEST_TI';

Format["Init_Server: Registered Radio Announcers (West: %1 East: %2) - [Done]",BIS_WF_HQWEST_TI,BIS_WF_HQEAST_TI] call LogMedium;

['WFBE_West_TimeUnderAttack',0,true] Call SetNamespace;
['WFBE_East_TimeUnderAttack',0,true] Call SetNamespace;

['WFBE_West_LastCommander',objNull,true] Call SetNamespace;
['WFBE_East_LastCommander',objNull,true] Call SetNamespace;

['WFBE_West_AIBase',false,true] Call SetNamespace;
['WFBE_East_AIBase',false,true] Call SetNamespace;

['WFBE_West_Upgrading',false,true] Call SetNamespace;
['WFBE_East_Upgrading',false,true] Call SetNamespace;

['WFBE_West_AISupplyTrucks',[],true] Call SetNamespace;
['WFBE_East_AISupplyTrucks',[],true] Call SetNamespace;

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

"Init_Server: Stats Variable - [Done]" call LogMedium;

EastBaseStructures = [];
WestBaseStructures = [];
publicVariable "EastBaseStructures";
publicVariable "WestBaseStructures";

if (paramAI) then {
	//--- Loadout replacement & positioning & variables.
	_i = 1;
	{
		if !(isNil "_x") then {
			if (!isPlayer (leader _x) && alive (leader _x)) then {
				_ran = 1 + round(random(2));
				(leader _x) setPos ([_eastLocation, 20, 30] Call GetRandomPositionEx);
				[(leader _x),Format ["WFBE_EASTLEADERWEAPONS0%1",_ran] Call GetNamespace,Format ["WFBE_EASTLEADERAMMO0%1",_ran] Call GetNamespace] Call EquipLoadout;
			};
			_x setVariable ["queue",[]];
			Call Compile Format ["EASTFunds%1 = %2; publicVariable 'EASTFunds%1';",_i,'WFBE_EASTSTARTINGMONEY' Call GetNamespace];
			[_x, false] 	Call SetTeamAutonomous;
			[_x, ""] 		Call SetTeamRespawn;
			[_x, -1] 		Call SetTeamType;
			[_x, "towns"]	Call SetTeamMoveMode;
			[_x, [0,0,0]]	Call SetTeamMovePos;
			if (paramISIS) then {(leader _x) addEventHandler['handleDamage',{_this Call ISIS_Wound}]};
			Format ["Init_Server: East AI Team (%1) Full Init - [Done]",_x] call LogHigh;
		};
		_i = _i + 1;
	} forEach ('WFBE_EASTTEAMS' Call GetNamespace);
	_i = 1;
	{
		if !(isNil "_x") then {
			if (!isPlayer (leader _x) && alive (leader _x)) then {
				_ran = 1 + round(random(2));
				(leader _x) setPos ([_westLocation, 20, 30] Call GetRandomPositionEx);
				[(leader _x),Format ["WFBE_WESTLEADERWEAPONS0%1",_ran] Call GetNamespace,Format ["WFBE_WESTLEADERAMMO0%1",_ran] Call GetNamespace] Call EquipLoadout;
			};
			_x setVariable ["queue",[]];
			Call Compile Format ["WESTFunds%1 = %2; publicVariable 'WESTFunds%1';",_i,'WFBE_WESTSTARTINGMONEY' Call GetNamespace];
			[_x, false] 	Call SetTeamAutonomous;
			[_x, ""] 		Call SetTeamRespawn;
			[_x, -1] 		Call SetTeamType;
			[_x, "towns"]	Call SetTeamMoveMode;
			[_x, [0,0,0]]	Call SetTeamMovePos;
			if (paramISIS) then {(leader _x) addEventHandler['handleDamage',{_this Call ISIS_Wound}]};
			Format ["Init_Server: West AI Team (%1) Full Init - [Done]",_x] call LogHigh;
		};
		_i = _i + 1;
	} forEach ('WFBE_WESTTEAMS' Call GetNamespace);
	
	//--- AI Supply Trucks.
	if (('WFBE_SUPPLYSYSTEM' Call GetNamespace) == 0) then {
		[east] Spawn UpdateSupplyTruck;
		[west] Spawn UpdateSupplyTruck;
		"Init_Server: Truck Supply System - [Done]" call LogHigh;
	};
	
	//--- AI Teams (Don't pause the server initialization process).
	[] Spawn {
		waitUntil{townInit};
		{if (!isNil "_x") then {[_x] ExecFSM "Server\FSM\aiteam.fsm"}} forEach ('WFBE_EASTTEAMS' Call GetNamespace);
		{if (!isNil "_x") then {[_x] ExecFSM "Server\FSM\aiteam.fsm"}} forEach ('WFBE_WESTTEAMS' Call GetNamespace);
		"Init_Server: AI Teams FSM - [Done]" call LogHigh;
	};
} else {
	_i = 1;
	{
		if !(isNil "_x") then {
			Call Compile Format ["EASTFunds%1 = %2; publicVariable 'EASTFunds%1';",_i,'WFBE_EASTSTARTINGMONEY' Call GetNamespace];
			[_x, false] 	Call SetTeamAutonomous;
			[_x, ""] 		Call SetTeamRespawn;
			[_x, -1] 		Call SetTeamType;
			Format ["Init_Server: West AI Team (%1) Partial Init - [Done]",_x] call LogHigh;
		};
		_i = _i + 1;
	} forEach ('WFBE_EASTTEAMS' Call GetNamespace);
	_i = 1;
	{
		if !(isNil "_x") then {
			Call Compile Format ["WESTFunds%1 = %2; publicVariable 'WESTFunds%1';",_i,'WFBE_WESTSTARTINGMONEY' Call GetNamespace];
			[_x, false] 	Call SetTeamAutonomous;
			[_x, ""] 		Call SetTeamRespawn;
			[_x, -1] 		Call SetTeamType;
			Format ["Init_Server: West AI Team (%1) Partial Init - [Done]",_x] call LogHigh;
		};
		_i = _i + 1;
	} forEach ('WFBE_WESTTEAMS' Call GetNamespace);
};

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

"Init_Server: Respawn Markers - [Done]" call LogHigh;

//--- Town starting mode.
if (('WFBE_TOWNSTARTINGMODE' Call GetNamespace) != 0 || ('WFBE_RESPATROL' Call GetNamespace) > 0 || ('WFBE_RESSTRIKER' Call GetNamespace) > 0) then {[] Call Compile preprocessFile "Server\Init\Init_Towns.sqf"};

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

//--- Clear the cargo.
{clearWeaponCargo _x; clearMagazineCargo _x} forEach _starterVehicle;

"Init_Server: Starting Vehicles - [Done]" call LogHigh;

//--- Pre-initialization of the Garbage Collector & Empty vehicle collector.
WF_Logic setVariable ["trash",[],true];
WF_Logic setVariable ["emptyVehicles",[],true];

//--- Misc SQF|FSM execution.
[] Call Compile preprocessFile "Server\Config\Config_Resistance.sqf";
"Init_Server: Resistance Config - [Done]"  call LogHigh;
[] Call Compile preprocessFile "Server\Config\Config_Occupation.sqf";
"Init_Server: Occupation Config - [Done]" call LogHigh;

//--- Don't pause the server init script.
[] Spawn {
	waitUntil {townInit};
	[] ExecFSM "Server\FSM\updateserver.fsm";
	"Init_Server (Delayed): Server Module - [Done]" call LogHigh;
	[] ExecFSM "Server\FSM\updateresources.fsm";
	"Init_Server (Delayed): Ressources Module - [Done]" call LogHigh;
};
//--- [] ExecFSM "Server\FSM\garbagecollector.fsm";
//--- "Init_Server: Garbage Collector Module - [Done]" call LogHigh;
//--- [] ExecFSM "Server\FSM\emptyvehiclescollector.fsm";
//--- "Init_Server: Empty Vehicles Collector - [Done]" call LogHigh;

//--- Network System Part 2.
EastMHQDeployed = false; publicVariable 'EastMHQDeployed';
WestMHQDeployed = false; publicVariable 'WestMHQDeployed';

WF_Logic setVariable ["EastSupplies",EastSupplies,true];
WF_Logic setVariable ["WestSupplies",WestSupplies,true];

WF_Logic setVariable ["EastCommanderVoteTime",60,true];
WF_Logic setVariable ["WestCommanderVoteTime",60,true];

WF_Logic setVariable ["EastCommanderTeam",EastCommanderTeam,true];
WF_Logic setVariable ["WestCommanderTeam",WestCommanderTeam,true];

WF_Logic setVariable ["EastMHQRepair",false,true];
WF_Logic setVariable ["WestMHQRepair",false,true];

publicVariable 'EastStartingLocation';
publicVariable 'WestStartingLocation';

_upArray = if (paramUpgradesEast) then {[0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0]} else {'WFBE_UPGRADELEVELS' Call GetNamespace};
EASTUpgrades = _upArray;
PublicVariable 'EASTUpgrades';
_upArray = if (paramUpgradesWest) then {[0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0]} else {'WFBE_UPGRADELEVELS' Call GetNamespace};
WESTUpgrades = _upArray;
PublicVariable 'WESTUpgrades';

if (paramRespawnMASH) then {
	WF_Logic setVariable ["EastMASH",objNull,true];
	WF_Logic setVariable ["WestMASH",objNull,true];
};

//--- Base Area (grouped base)
if (paramBaseArea) then {
	WF_Logic setVariable ["EastArea",[],true];
	WF_Logic setVariable ["WestArea",[],true];
	
	[] ExecFSM "Server\FSM\basearea.fsm";
};

"Init_Server: NetVar - [Done]" call LogHigh;

//--- Allies base.
if (paramAllies && (WF_A2_Vanilla || WF_A2_CombinedOps)) then {
	[] Call Compile preprocessFile "Server\Config\Config_Allies.sqf";
	[west] ExecFSM "Server\FSM\allies.fsm";
	[east] ExecFSM "Server\FSM\allies.fsm";
	
	"Init_Server: Allies Module - [Done]" call LogHigh;
};

//--- Auto Defenses Manning.
if (paramAutoDefense) then {
	WF_DefenseWestGrp = createGroup west;
	WF_DefenseEastGrp = createGroup east;
	
	"Init_Server: Auto Defenses - [Done]" call LogHigh;
};

//--- ALICE Module.
if (paramAlice) then {
	_type = if (WF_A2_Vanilla) then {'AliceManager'} else {'Alice2Manager'};
	_alice = (createGroup sideLogic) createUnit [_type,[0,0,0],[],0,"NONE"];
	
	"Init_Server: ALICE Module - [Done]" call LogHigh;
};

"Init_Server: Init Server [Done]" call LogMedium;



//--- Waiting until that the game is launched.
waitUntil {time > 0};
serverInitComplete = true;

[East] Spawn SVoteForCommander;
[West] Spawn SVoteForCommander;

PROFILER_END();