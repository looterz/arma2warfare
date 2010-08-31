disableSerialization;

MenuAction = -1;
mouseButtonUp = -1;
_display = _this select 0;
_map = _display DisplayCtrl 15001;

waitUntil {alive player};

player setPos ([getMarkerPos Format["%1TempRespawnMarker",sideJoinedText],1,10] Call GetRandomPosition);
if (leader(group player) != player) then {(group player) selectLeader player};

Options = player addAction ["<t color='#F8D664'>" + (localize "STR_WF_Options") + "</t>","Client\Action\Action_Menu.sqf", "", 1, false, true, "", ""];
[] ExecFSM "Client\FSM\updateactions.fsm";
//--- Skill Module.
[] Call Compile PreprocessFile "Client\Module\Skill\Skill_Init.sqf";

if (!isNull commanderTeam) then {
	_hq = WF_Logic getVariable Format ["%1MHQ",sideJoinedText];
	if (commanderTeam == group player) then {HQAction = player addAction [localize "STR_WF_BuildMenu","Client\Action\Action_Build.sqf", [_hq], 100, false, true, "", "hqInRange"]};
};

_built = WF_Logic getVariable Format ["%1UnitsCreated",sideJoinedText];
_built = _built + 1;
WF_Logic setVariable [Format["%1UnitsCreated",sideJoinedText],_built,true];

//--- Base.
_hq = WF_Logic getVariable Format ["%1MHQ",sideJoinedText];
_availableSpawn = [_hq];
_buildings = WF_Logic getVariable Format ["%1BaseStructures",sideJoinedText];
_checks = [sideJoined,Format ["WFBE_%1BARRACKSTYPE",sideJoinedText] Call GetNamespace,_buildings] Call GetFactories;
if (count _checks > 0) then {_availableSpawn = _availableSpawn + _checks};
_checks = [sideJoined,Format ["WFBE_%1LIGHTTYPE",sideJoinedText] Call GetNamespace,_buildings] Call GetFactories;
if (count _checks > 0) then {_availableSpawn = _availableSpawn + _checks};
_checks = [sideJoined,Format ["WFBE_%1COMMANDCENTERTYPE",sideJoinedText] Call GetNamespace,_buildings] Call GetFactories;
if (count _checks > 0) then {_availableSpawn = _availableSpawn + _checks};
_checks = [sideJoined,Format ["WFBE_%1HEAVYTYPE",sideJoinedText] Call GetNamespace,_buildings] Call GetFactories;
if (count _checks > 0) then {_availableSpawn = _availableSpawn + _checks};
_checks = [sideJoined,Format ["WFBE_%1AIRCRAFTTYPE",sideJoinedText] Call GetNamespace,_buildings] Call GetFactories;
if (count _checks > 0) then {_availableSpawn = _availableSpawn + _checks};
_checks = [sideJoined,Format ["WFBE_%1SERVICEPOINTTYPE",sideJoinedText] Call GetNamespace,_buildings] Call GetFactories;
if (count _checks > 0) then {_availableSpawn = _availableSpawn + _checks};

//--- HQ is dead, but we can spawn at other buildings.
if (!alive _hq && count _availableSpawn > 1) then {_availableSpawn = _availableSpawn - [_hq]};

//--- Mobile respawn.
if (mobileRespawn) then {
	_mobileRespawns = Format ["WFBE_%1AMBULANCES",sideJoinedText] Call GetNamespace;
	_upgrades = WF_Logic getVariable Format ["%1Upgrades",sideJoinedText];
	_range = (Format["WFBE_RESPAWNMOBILERANGE%1",(_upgrades select 7)] Call GetNamespace);
	_checks = deathLocation nearEntities[_mobileRespawns,_range];
	if (count _checks > 0) then {
		{if (alive _x) then {_availableSpawn = _availableSpawn + [_x]}} forEach _checks;
	};
};

//--- MASH.
if (respawnMASH) then {
	_farps = Format ["WFBE_%1FARP",sideJoinedText] Call GetNamespace;
	_upgrades = WF_Logic getVariable Format ["%1Upgrades",sideJoinedText];
	_range = (Format["WFBE_RESPAWNMOBILERANGE%1",(_upgrades select 7)] Call GetNamespace);
	_checks = nearestObjects [deathLocation, [_farps], _range];
	if (count _checks > 0) then {
		{if (alive _x) then {_availableSpawn = _availableSpawn + [_x]}} forEach _checks;
	};
};

//--- Camps.
if (campRespawn) then {
	_town = [deathLocation,sideJoined] Call GetClosestLocation;
	if (!isNull _town) then {
		if (_town distance deathLocation  < ('WFBE_RESPAWNRANGE' Call GetNamespace)) then {
			_camps = [_town,sideJoined] Call GetFriendlyCamps;
			if (count _camps > 0) then {
				if (campRespawnRule) then {
					_closestCamps = [deathLocation,_camps] Call SortByDistance;
					_closestCamp = _closestCamps select 0;
					_objects = _closestCamp nearEntities[[eastSoldierBaseClass,westSoldierBaseClass,"Car","Motorcycle","Tank","Air"],('WFBE_RESPAWNMINRANGE' Call GetNamespace)];
					_objs = _objects;
					{if (!(_x isKindOf "Man")) then {if (count (crew _x) == 0) then {_objects = _objects - [_x]}}} forEach _objs;
					_hostiles = if (sideJoined == West) then {East countSide _objects} else {West countSide _objects};
					if (deathLocation distance _closestCamp < ('WFBE_RESPAWNMINRANGE' Call GetNamespace) && _hostiles > 0) then {_camps = _camps - [_closestCamp]};
				};
				_availableSpawn = _availableSpawn + _camps;
			};
		};
	};
};

_markers = [];
_markerIndex = 0;
{
	_markerName = Format ["respawnMarker%1",_markerIndex];
	_markers = _markers + [_markerName];
	CreateMarkerLocal [_markerName,getPos _x];
	_markerName setMarkerTypeLocal "selector_selectedFriendly";
	_markerName setMarkerColorLocal "ColorYellow";
	_markerName setMarkerSizeLocal [1,1];
	_markerIndex = _markerIndex + 1;
} forEach _availableSpawn;

_spawn = _availableSpawn select 0;
activeAnimMarker = false;
_ta = ["TempAnim",getPos _spawn,"selector_selectedMission",1.4,"ColorYellow"] Spawn MarkerAnim;
respawnName = getText (configFile >> "CfgVehicles" >> typeOf _spawn >> "displayName");

respawnDone = false;
[] Spawn {
	respawnStatus = 'WFBE_RESPAWNDELAY' Call GetNamespace;
	while {respawnStatus >= 0} do {
		sleep 1;
		respawnStatus = respawnStatus - 1;
	};
	respawnDone = true;
};

while {!respawnDone} do {
	ctrlSetText [15003,Format [localize "STR_WF_RespawnStatus",respawnStatus,respawnName]];
	sleep 0.1;
	if !(alive player) exitWith {};
	if (mouseButtonUp == 0) then {
		mouseButtonUp = -1;
		if (count _availableSpawn > 1) then {
			_position = _map PosScreenToWorld[mouseX,mouseY];
			_sorted = [_position,_availableSpawn] Call SortByDistance;
			if ((_sorted select 0) distance _position < 500) then {
				_spawn = _sorted select 0;
				activeAnimMarker = false;
				terminate _ta;
				deleteMarkerLocal "TempAnim";
				_ta = ["TempAnim",getPos _spawn,"selector_selectedMission",1.4,"ColorYellow"] Spawn MarkerAnim;
				respawnName = getText (configFile >> "CfgVehicles" >> typeOf _spawn >> "displayName");
			};
		};
	};
};

if (isNull _spawn) then {
	_hq = WF_Logic getVariable Format ["%1MHQ",sideJoinedText];
	_spawn = _hq;
};
player setPos ([GetPos _spawn,10,20] Call GetRandomPosition);

if (!isNil "respawnWeapons" && gearRespawn) then {
	[player,respawnWeapons,respawnAmmo] Call EquipLoadout;
} else {
	_defaultWeap = Format ["WFBE_%1DEFAULTWEAPONS",sideJoinedText] Call GetNamespace;
	_defaultAmmo = Format ["WFBE_%1DEFAULTAMMO",sideJoinedText] Call GetNamespace;
	[player,_defaultWeap,_defaultAmmo] Call EquipLoadout;
};

{deleteMarkerLocal _x} forEach _markers;
if (!isNil "DeathCamera") then {
	DeathCamera cameraEffect["TERMINATE","BACK"];
	camDestroy DeathCamera;
};

"dynamicBlur" ppEffectEnable false;
"colorCorrections" ppEffectEnable false;
[currentFX] Spawn FX;
terminate _ta;
deleteMarkerLocal "TempAnim";
activeAnimMarker = false;
playerDead = false;
respawnDone = nil;
respawnName = nil;
respawnStatus = nil;
closeDialog 0;

hint (localize "STR_WF_RespawnInfo");