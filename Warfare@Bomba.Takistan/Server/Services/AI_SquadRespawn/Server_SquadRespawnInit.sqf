waitUntil {commonInitComplete};

WBE_AISQUAD_RESPAWN = [];
WBE_AISQUAD_RESPAWN_QUEUE = [];

SquadRespawnProc = Compile preprocessFile "Server\Services\AI_SquadRespawn\Server_SquadRespawnProc.sqf";
SquadRespawnWork = Compile preprocessFile "Server\Services\AI_SquadRespawn\Server_SquadRespawnWork.sqf";

AISquadRespawn = Compile preprocessFile "Server\Services\AI_SquadRespawn\Server_AISquadRespawn.sqf";

[SquadRespawnProc, 10];