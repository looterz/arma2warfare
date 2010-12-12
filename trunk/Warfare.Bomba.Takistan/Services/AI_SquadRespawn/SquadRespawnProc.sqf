#include "profiler.h"
private['_dirty', '_u', '_respawnSquad', '_squad', '_timeout'];
PROFILER_BEGIN("Service_SquadRespawnProc");

	_dirty = false;
	_u = count WBE_AISQUAD_RESPAWN;
	format["Service_SquadRespawnProc: respawn queue=%1", _u] call LogHigh;
	while { _u != 0 } do {
		_u = _u - 1;
		
		_respawnSquad = WBE_AISQUAD_RESPAWN select _u;
		_timeout = _respawnSquad select 1;
		
		if (_timeout < time) then {
		
			format["Service_SquadRespawnProc Squad:=%1", _respawnSquad] call LogHigh;
			_squad   = _respawnSquad select 0;
			_squad spawn SquadRespawnWork;
		
			WBE_AISQUAD_RESPAWN set [_u, objNull ];	
			_dirty = true;
		};
		sleep 0.005;
	};
	
	if (_dirty) then {
		WBE_AISQUAD_RESPAWN = WBE_AISQUAD_RESPAWN - [ objNull ];
	};
PROFILER_END();