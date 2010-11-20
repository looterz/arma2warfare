#include "profiler.h"
PROFILER_BEGIN("Server_AI_SquadRespawn");

Private ["_buildings","_closestRespawn","_deathLoc","_leader","_pos","_rd","_rmr","_rr","_respawn","_respawnLoc","_side","_sideText","_slot","_team","_upgrades"];

	_team = _this;

	_side = side _team;	
	_sideText = str _side;
	_deathLoc = objNull;
	_respawnLoc = objNull;

	_rd = 'WFBE_RESPAWNDELAY' Call GetNamespace;
	_rr = 'WFBE_RESPAWNRANGE' Call GetNamespace;
	_rmr = 'WFBE_RESPAWNMINRANGE' Call GetNamespace;
	
	if (isNil "_team") exitWith {
		format["Server_SquadRespawn: Trying Respawn nil team", _this] call LogHigh;
		PROFILER_END();
	};
	
	if (isNull _team) exitWith {
		format["Server_SquadRespawn: Trying Respawn null team", _this] call LogHigh;
		PROFILER_END();
	};

	if (_side != west && _side != east) exitWith {
		PROFILER_END();
	};	
	
	if (_team in WBE_AISQUAD_RESPAWN_QUEUE) exitWith {
		PROFILER_END();
	};
	
	_leader = leader _team;
	if (isNil "_leader") then { _leader = objNull; };

	
	if ( (!(isNull _leader)) && (isPlayer _leader || alive (_leader)) ) exitWith {
		PROFILER_END();
	};
	
	WBE_AISQUAD_RESPAWN_QUEUE = WBE_AISQUAD_RESPAWN_QUEUE + [ _team ];

	format["AI_SquadRespawn Initialized: %1", _this] call LogHigh;
	
	_deathLoc = getPos (leader _team);
	_unitType = typeof _leader;
	
	//--- Place the AI.
	_leader removeAllEventHandlers "Killed";
	Call Compile Format ["_leader addEventHandler ['Killed',{[_this select 0,_this select 1,%1] Spawn UnitKilled}]",_side];
	
	if (isMultiplayer) then {
		_leader setPos getMarkerPos Format["%1TempRespawnMarker",_sideText];
	};

	if (WF_DEBUG) then {
		_rd = 5;
	};
	
	_squad = [_team, _deathLoc, _unitType];

	WBE_AISQUAD_RESPAWN = WBE_AISQUAD_RESPAWN + [ [_squad, time + _rd] ];
	
PROFILER_END();