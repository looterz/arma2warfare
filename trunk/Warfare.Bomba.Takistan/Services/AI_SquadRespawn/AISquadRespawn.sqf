#include "profiler.h"
PROFILER_BEGIN("Service_AISquadRespawn");

/* Enhanced Respawn Management via Multiplayer Event Handler - Experimental */
Private ["_buildings","_closestRespawn","_deathLoc","_leader","_pos","_rd","_rmr","_rr","_respawn","_respawnLoc","_side","_sideText","_slot","_team","_upgrades"];

	_respawnedUnit = _this select 0;
	format["AI_SquadRespawn Initialized: %1", _this] call LogHigh;

	if (isNil "_respawnedUnit") exitWith {
		format["AI_SquadRespawn: Trying Respawn Nil AIUnit"] call LogHigh;
		PROFILER_END();
	};	

	if (isNull _respawnedUnit) exitWith {
		format["AI_SquadRespawn: Trying Respawn Null AIUnit"] call LogHigh;
		PROFILER_END();
	};

	_team = group _respawnedUnit;
	
	if (isNil "_team") exitWith {
		format["AI_SquadRespawn: Trying Respawn nil team: %1", _this] call LogHigh;
		PROFILER_END();
	};
	
	if (isNull _team) exitWith {
		format["AI_SquadRespawn: Trying Respawn null team: %1", _this] call LogHigh;
		PROFILER_END();
	};

	if ( (_team call GetClientIDFromTeam) == -1) exitWith {
		format["AI_SquadRespawn: Trying Respawn non-playable team: %1", _this] call LogHigh;
		PROFILER_END();
	};
	
	_corpse = if (count _this > 1) then { _this select 1 } else { _respawnedUnit };
	
	if (_team in WBE_AISQUAD_RESPAWN_QUEUE) exitWith {
		format["AI_SquadRespawn: Team already in respawn queue %1", _team] call LogHigh;
		format["AI_SquadRespawn: WBE_AISQUAD_RESPAWN_QUEUE:%1", WBE_AISQUAD_RESPAWN_QUEUE] call LogHigh;
		PROFILER_END();
	};
	WBE_AISQUAD_RESPAWN_QUEUE = WBE_AISQUAD_RESPAWN_QUEUE + [ _team ];

	_leader = leader _team;
	if (isNil "_leader") then { _leader = objNull; };
	
	if (!isNull _leader && _respawnedUnit != _leader) then {
		format["AI_SquadRespawn: Trying Respawn Unit that is not Team Leader: Unit %1, Leader %2, Team %3", _respawnedUnit, _leader, _team] call LogHigh;
	};

	if ( !(isNull _leader) && (isPlayer _respawnedUnit) ) exitWith {
		format["AI_SquadRespawn: Respawned Unit currently is player"] call LogHigh;
		PROFILER_END();
	};

	_side = side _team;	
	_sideText = str _side;
	_deathLoc = objNull;
	_respawnLoc = objNull;

	_rd = 'WFBE_RESPAWNDELAY' Call GetNamespace;
	_rr = 'WFBE_RESPAWNRANGE' Call GetNamespace;
	_rmr = 'WFBE_RESPAWNMINRANGE' Call GetNamespace;
	
	_deathLoc = getPos _corpse;
	_unitType = typeof _corpse;
	
	if (isMultiplayer && !(isNull _respawnedUnit)) then {
	
		format["AI_SquadRespawn: Multiplayer wait respawn Unit: %1 alive:%2", leader _team, alive(leader _team)] call LogHigh;
		_timeout = time + 120;
		while { !alive _respawnedUnit && time < _timeout } do { sleep 0.100; };	// waitUntil unit respawn;		
		
		if (!alive _respawnedUnit) then {
			format["AI_SquadRespawn: Unit Is not respawned during 120sec: %1", _respawnedUnit] call LogError;
			deleteVehicle _respawnedUnit;
			_respawnedUnit = objNull;
		};
		
		_leader = leader _team;
		format["AI_SquadRespawn: Multiplayer respawned Unit: %1 alive:%2", leader _team, alive(leader _respawnedUnit)] call LogHigh;
		
		if ( !(isNull(_respawnedUnit)) && !(isPlayer(_respawnedUnit) ) ) then {
		
			[_respawnedUnit, _side] spawn SetAITeamKilledEventHandler;
		
			_pos = getMarkerPos Format["%1TempRespawnMarker",_sideText];
			_respawnedUnit setPos [ _pos select 0, _pos select 1, -0.25];
			
			format["AI_SquadRespawn: Multiplayer Move Unit to lobbyPos due timeout penalty: %1 alive:%2", leader _team, alive(leader _team)] call LogHigh;
		};
	} else {
		if (!isMultiplayer) then { 
			"AI_SquadRespawn: SP mode dont wait respawn unit" call LogHigh; 
		} else {
			format["AI_SquadRespawn: Bugged AI Slot try respawn team without leader: Team %1, Units:%2", _team, (units _team)] call LogHigh; 		
		};		
	};

	if ( !(isPlayer _respawnedUnit) ) then {
		if (WF_DEBUG) then { _rd = 5; };	
		_squad = [_team, _deathLoc, _unitType];
		WBE_AISQUAD_RESPAWN = WBE_AISQUAD_RESPAWN + [ [_squad, time + _rd] ];
	} else {
	
		WBE_AISQUAD_RESPAWN_QUEUE = WBE_AISQUAD_RESPAWN_QUEUE - [ _team ];	// remove AITeam from queue because player now team leader;
	};
	format["AI_SquadRespawn %1 - Processed", _this] call LogHigh;
PROFILER_END();