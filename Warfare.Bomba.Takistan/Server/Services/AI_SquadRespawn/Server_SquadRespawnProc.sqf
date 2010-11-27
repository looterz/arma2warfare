#include "profiler.h"
private['_dirty', '_u', '_respawnSquad', '_squad', '_timeout'];
PROFILER_BEGIN("Server_SquadRespawnProc");

	_dirty = false;
	_u = count WBE_AISQUAD_RESPAWN;
	format["Server_SquadRespawnProc WBE_AISQUAD_RESPAWN=%1", _u] call LogHigh;
	while { !(_u == 0) } do {
		_u = _u - 1;
		
		_respawnSquad = WBE_AISQUAD_RESPAWN select _u;
		_timeout = _respawnSquad select 1;
		
		format["Server_SquadRespawnProc Squad:=%1", _respawnSquad] call LogHigh;
		
		if (_timeout < time) then {
		
			_squad   = _respawnSquad select 0;
			_squad spawn SquadRespawnWork;
		
			WBE_AISQUAD_RESPAWN set [_u, objNull ];	
			_dirty = true;
		};
	};
	
	if (_dirty) then {
		WBE_AISQUAD_RESPAWN = WBE_AISQUAD_RESPAWN - [ objNull ];
	};
PROFILER_END();