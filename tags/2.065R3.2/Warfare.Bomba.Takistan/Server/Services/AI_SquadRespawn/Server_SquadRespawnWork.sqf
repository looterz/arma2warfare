#include "profiler.h"
PROFILER_BEGIN("Server_AI_SquadRespawn");

Private ["_buildings","_closestRespawn","_deathLoc","_leader","_pos","_rd","_rmr","_rr","_respawn","_respawnLoc","_side","_sideText","_slot","_team","_upgrades"];

	_team 	  = _this select 0;
	_deathLoc = _this select 1;
	_unitType = _this select 2;	

	_side = side _team;	
	_sideText = str _side;
	_respawnLoc = objNull;

	_rr = 'WFBE_RESPAWNRANGE' Call GetNamespace;
	_rmr = 'WFBE_RESPAWNMINRANGE' Call GetNamespace;
	
	if (isNil "_team") exitWith {
		format["Server_SquadRespawnWork: Trying Respawn nil team", _this] call LogHigh;
	};
	
	if (isNull _team) exitWith {
		format["Server_SquadRespawnWork: Trying Respawn null team", _this] call LogHigh;
	};

	if (_side != west && _side != east) exitWith {
		format["Server_SquadRespawnWork: Trying Respawn guerilla team", _this] call LogHigh;
		WBE_AISQUAD_RESPAWN_QUEUE = WBE_AISQUAD_RESPAWN_QUEUE - [ _team ];
	};	
	
	_leader = leader _team;
	if (isPlayer _leader) exitWith {
	
		WBE_AISQUAD_RESPAWN_QUEUE = WBE_AISQUAD_RESPAWN_QUEUE - [ _team ];
	};

	format["AI_SquadRespawnWork: Unit: %1 alive:%2", leader _team, alive(leader _team)] call LogHigh;
	_respawn = (_team) Call GetTeamRespawn;

	_availableSpawn = [];
	//--- Towns.
	if (paramCampRespawn && _respawn != "forceRespawn") then {
		_town = [_deathLoc,_side] Call GetClosestLocation;
		if (!isNull _town) then {
			if (_town distance _deathLoc  < _rr) then {
				_camps = [_town,_side] Call GetFriendlyCamps;
				if (count _camps > 0) then {
					if (paramCampRespawnRule) then {
						_closestCamps = [_deathLoc,_camps] Call SortByDistance;
						_closestCamp = _closestCamps select 0;
						_objects = _closestCamp nearEntities[[eastSoldierBaseClass,westSoldierBaseClass,"Car","Motorcycle","Tank","Air"],_rmr];
						_objs = _objects;
						{if (!(_x isKindOf "Man")) then {if (count (crew _x) == 0) then {_objects = _objects - [_x]}}} forEach _objs;
						_hostiles = if (_side == west) then {East countSide _objects} else {West countSide _objects};
						if (_deathLoc distance _closestCamp < _rmr && _hostiles > 0) then {_camps = _camps - [_closestCamp]};
					};
					_availableSpawn = _availableSpawn + _camps;
				};
			};
		};
	};
	
	_upgrades = (_sideText) Call GetSideUpgrades;
	
	//--- Mobile Respawn.
	if (paramMobileRespawn && _respawn != "forceRespawn") then {
		_mobileRespawns = Format ["WFBE_%1AMBULANCES",_sideText] Call GetNamespace;
		_range = (Format["WFBE_RESPAWNMOBILERANGE%1",(_upgrades select 7)] Call GetNamespace);
		
		format["AI_SquadRespawn: mobileRespawns:%1 range:%2", _mobileRespawns, _range] call LogHigh;		
		_checks = _deathLoc nearEntities[_mobileRespawns,_range];
		
		format["AI_SquadRespawn: respawnPoints:%1", _checks] call LogHigh;
		
		{
			if (alive _x) then { _availableSpawn = _availableSpawn + [_x]; }
		} forEach _checks;
	};
	
	_hq = (_sideText) Call GetSideHQ;
	_buildings = (_sideText) Call GetSideStructures;

	//--- Check whether AI has a spawn set or not.
	_update = false;
	switch (typeName _respawn) do {
		case "STRING": {
			_update = true;
			if (_respawn == "forceRespawn") then {[_team,""] Call SetTeamRespawn};
		}; //--- Not defined.
		case "OBJECT": {
			_respawnLoc = _respawn;
			if (!alive _respawn || isNull _respawn) then {
				[_team, ""] Call SetTeamRespawn;
				_update = true;
			};	//--- Defined.
		};
	};
	
	//--- Default respawn.
	if (_update) then {
		_respawnLoc = _hq;
		if (count _buildings > 0) then {
			_closestRespawn = [_hq,_buildings] Call SortByDistance;
			_respawnLoc = _closestRespawn select 0;
		};
	};
	
	//--- Alternative spawn location.
	if (count _availableSpawn > 0) then {
		_respawnLoc = _availableSpawn select (round(random((count _availableSpawn)-1)));
	};

	_pos = [_respawnLoc,20,30] Call GetRandomPositionEx;
	_pos set [2,0];
	format["AI_SquadRespawnWork: Unit: %1 Respawn Location:", leader _team, _pos] call LogHigh;

	
	if ( !(isPlayer (leader _team)) ) then {
	
		_leader = leader _team;
		if (!isMultiplayer && !(alive (leader _team)) ) then {
		
			"AI_SquadRespawnWork: SP mode, and teamLeader is died, create TeamLeader" call LogHigh;
			_leader = [_unitType, _team, _pos, _side] Call CreateMan;	
		};

		format["AI_SquadRespawnWork: TeamLeader %1 SetPos=%2", leader _team, _pos] call LogHigh;
		_leader setPos _pos;		
		_built = WF_Logic getVariable Format ["%1UnitsCreated",_sideText];
		_built = _built + 1;
		WF_Logic setVariable [Format["%1UnitsCreated",_sideText],_built,true];

		//--- Equip the AI.
		_ran = 1 + round(random(2));
		[_leader, Format ["WFBE_%1LEADERWEAPONS%2%3",_sideText,_upgrades select 13,_ran] Call GetNamespace, Format ["WFBE_%1LEADERAMMO%2%3",_sideText,_upgrades select 13,_ran] Call GetNamespace] Call EquipLoadout;

		_leader removeAllEventHandlers "Killed";
		Call Compile Format ["_leader addEventHandler ['Killed',{[_this select 0,_this select 1,%1] Spawn UnitKilled}]",_side];
	};

	WBE_AISQUAD_RESPAWN_QUEUE = WBE_AISQUAD_RESPAWN_QUEUE - [ _team ];	
	
PROFILER_END();