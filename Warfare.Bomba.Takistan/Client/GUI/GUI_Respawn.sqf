private['_availablespawn','_checks','_spawn','_hq','_buildings','_markername','_price','_upgrades','_range','_markers','_markerindex','_ta','_mode','_temp','_position','_sorted','_loaddefault','_skip','_display','_map','_mobilerespawns','_farps','_funds','_listbp','_weaps','_defaultweap','_defaultammo'];
disableSerialization;

MenuAction = -1;
mouseButtonUp = -1;
_display = _this select 0;
_map = _display displayCtrl 15001;

waitUntil {alive player};

[player, side player] spawn ManagedUnitAdd;

player setPos ([getMarkerPos Format["%1TempRespawnMarker",sideJoinedText],1,10] Call GetRandomPosition);
if (leader(group player) != player) then {(group player) selectLeader player};

Options = player addAction ["<t color='#F8D664'>" + (localize "STR_WF_Options") + "</t>","Client\Action\Action_Menu.sqf", "", 1, false, true, "", ""];
[] ExecFSM "Client\FSM\updateactions.fsm";

if (!isNull commanderTeam) then {
	_hq = (sideJoinedText) Call GetSideHQ;
	if (commanderTeam == group player) then {HQAction = player addAction [localize "STR_WF_BuildMenu","Client\Action\Action_Build.sqf", [_hq], 100, false, true, "", "hqInRange && canBuildWHQ"]};
};

if (paramBuildDefencesInTown > 0) then {
	player addAction [localize 'STR_WF_BuildMenu_Repair','Client\Action\Action_BuildRepair.sqf', [], 99, false, true, '', 'townDefenceRange'];
};

//--- Base.
_hq = (sideJoinedText) Call GetSideHQ;
_availableSpawn = [_hq];
_buildings = (sideJoinedText) Call GetSideStructures;
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
if (paramMobileRespawn) then {
	_mobileRespawns = Format ["WFBE_%1AMBULANCES",sideJoinedText] Call GetNamespace;
	_upgrades = (sideJoinedText) Call GetSideUpgrades;
	_range = (Format["WFBE_RESPAWNMOBILERANGE%1",(_upgrades select 7)] Call GetNamespace);
	_checks = deathLocation nearEntities[_mobileRespawns,_range];
	if (count _checks > 0) then {
		{if (alive _x) then {_availableSpawn = _availableSpawn + [_x]}} forEach _checks;
	};
};

//--- MASH.
if (paramRespawnMASH) then {
	_farps = Format ["WFBE_%1FARP",sideJoinedText] Call GetNamespace;
	_upgrades = (sideJoinedText) Call GetSideUpgrades;
	_range = (Format["WFBE_RESPAWNMOBILERANGE%1",(_upgrades select 7)] Call GetNamespace);
	_checks = nearestObjects [deathLocation, [_farps], _range];
	if (count _checks > 0) then {
		{if (alive _x) then {_availableSpawn = _availableSpawn + [_x]}} forEach _checks;
	};
};

if (('WFBE_RESPAWNCAMPSMODE' Call GetNamespace) > 0) then {
	_availableSpawn = _availableSpawn + ([deathLocation, sideJoined] Call GetRespawnCamps);
};

_markers = [];
_markerIndex = 0;
{
	_markerName = Format ["respawnMarker%1",_markerIndex];
	_markers = _markers + [_markerName];
	createMarkerLocal [_markerName,getPos _x];
	_markerName setMarkerTypeLocal "selector_selectedFriendly";
	_markerName setMarkerColorLocal "ColorYellow";
	_markerName setMarkerSizeLocal [1,1];
	_markerIndex = _markerIndex + 1;
} forEach _availableSpawn;

_spawn = _availableSpawn select 0;
activeAnimMarker = false;
_ta = ["TempAnim",getPos _spawn,"selector_selectedMission",1.4,"ColorYellow"] Spawn MarkerAnim;
respawnName = [typeOf _spawn, 'displayName'] Call GetConfigInfo;

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
				respawnName = [typeOf _spawn, 'displayName'] Call GetConfigInfo;
			};
		};
	};
};

if (isNull _spawn) then {
	_hq = (sideJoinedText) Call GetSideHQ;
	_spawn = _hq;
};
player setPos ([_spawn, 10, 20] Call GetRandomPositionEx);

_loadDefault = true;
if !(isNil "respawnWeapons") then {
	_mode = 'WFBE_RESPAWNPENALTY' Call GetNamespace;

	if (_mode in [0,2,3,4]) then {
		//--- Calculate the price/funds.
		_skip = false;
		if (_mode != 0) then {
			_price = 0;
			switch (_mode) do {
				case 2: {_price = respawnGearCost};
				case 3: {_price = round(respawnGearCost/2)};
				case 4: {_price = round(respawnGearCost/4)};
			};
			_funds = Call GetPlayerFunds;
			if (_funds >= _price) then {
				(-_price) Call ChangePlayerFunds;
			} else {_skip = true};
		};

		if !(_skip) then {
			_temp = +(respawnWeapons);
			_listbp = 'WFBE_BACKPACKS' Call GetNamespace;
			{if (_x in _listbp) then {_temp = _temp - [_x]}} forEach respawnWeapons;
			_weaps = _temp;
	
			if !(WF_A2_Vanilla) then {
			    call RespawningBag;
			};
			[player,_weaps,respawnAmmo] Call EquipLoadout;
			_loadDefault = false;
		};
	};
};

if (_loadDefault) then {
	_defaultWeap = Format ["WFBE_%1DEFAULTWEAPONS",sideJoinedText] Call GetNamespace;
	_defaultAmmo = Format ["WFBE_%1DEFAULTAMMO",sideJoinedText] Call GetNamespace;
	[player,_defaultWeap,_defaultAmmo] Call EquipLoadout;
};

//--- Skill Module.
[] spawn WFBE_SK_FNC_Apply;

if (paramTrade) then {
	[] call marketClearPlayerCargo;
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