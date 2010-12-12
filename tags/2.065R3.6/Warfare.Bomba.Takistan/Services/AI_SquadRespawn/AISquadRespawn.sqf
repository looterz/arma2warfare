#include "profiler.h"
PROFILER_BEGIN("Service_AI_SquadRespawn");

Private ["_buildings","_closestRespawn","_deathLoc","_leader","_pos","_rd","_rmr","_rr","_respawn","_respawnLoc","_side","_sideText","_slot","_team","_upgrades"];

	_team = _this;

	if (isNil "_team") exitWith {
		format["Service_SquadRespawn: Trying Respawn nil team: %1", _this] call LogHigh;
		PROFILER_END();
	};
	
	if (isNull _team) exitWith {
		format["Service_SquadRespawn: Trying Respawn null team: %1", _this] call LogHigh;
		PROFILER_END();
	};

	if ( (_team call GetClientIDFromTeam) == -1) exitWith {
		format["Service_SquadRespawn: Trying Respawn non-playable team: %1", _this] call LogHigh;
		PROFILER_END();
	};
	
	if (_team in WBE_AISQUAD_RESPAWN_QUEUE) exitWith {
		PROFILER_END();
	};
	WBE_AISQUAD_RESPAWN_QUEUE = WBE_AISQUAD_RESPAWN_QUEUE + [ _team ];

	_leader = leader _team;
	if (isNil "_leader") then { _leader = objNull; };

	if ( (!(isNull _leader)) && (isPlayer _leader || alive (_leader)) ) exitWith {
		PROFILER_END();
	};

	_side = side _team;	
	_sideText = str _side;
	_deathLoc = objNull;
	_respawnLoc = objNull;

	_rd = 'WFBE_RESPAWNDELAY' Call GetNamespace;
	_rr = 'WFBE_RESPAWNRANGE' Call GetNamespace;
	_rmr = 'WFBE_RESPAWNMINRANGE' Call GetNamespace;
	
	format["AI_SquadRespawn Initialized: %1", _this] call LogHigh;
	
	_deathLoc = getPos _leader;
	_unitType = typeof _leader;
	
	if (isMultiplayer) then {
	
		format["AI_SquadRespawn: Multiplayer wait respawn Unit: %1 alive:%2", leader _team, alive(leader _team)] call LogHigh;
		while { !alive (leader _team) } do {
			sleep 0.5;
		};	// waitUntil unit respawn;
		
		_leader = leader _team;
		format["AI_SquadRespawn: Multiplayer respawned Unit: %1 alive:%2", leader _team, alive(leader _team)] call LogHigh;
		
		if ( !(isPlayer(leader _team) ) ) then {
		
			[_leader, _side] spawn SetAITeamKilledEventHandler;
		
			_pos = getMarkerPos Format["%1TempRespawnMarker",_sideText];
			_leader setPos [ _pos select 0, _pos select 1, -0.25];
			
			format["AI_SquadRespawn: Multiplayer Move Unit to lobbyPos due timeout penalty: %1 alive:%2", leader _team, alive(leader _team)] call LogHigh;
		};
	} else {
	
		"AI_SquadRespawn: SP mode dont wait respawn unit" call LogHigh;
	};

	if ( !(isPlayer _leader) ) then {
		if (WF_DEBUG) then { _rd = 5; };	
		_squad = [_team, _deathLoc, _unitType];
		WBE_AISQUAD_RESPAWN = WBE_AISQUAD_RESPAWN + [ [_squad, time + _rd] ];
	} else {
	
		WBE_AISQUAD_RESPAWN_QUEUE = WBE_AISQUAD_RESPAWN_QUEUE - [ _team ];	// remove AITeam from queue because player now team leader;
	};
	
PROFILER_END();